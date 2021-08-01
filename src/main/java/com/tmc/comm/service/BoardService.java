package com.tmc.comm.service;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tmc.comm.dao.BoardDto;
import com.tmc.comm.dao.BoardPaginationInfo;
import com.tmc.comm.dao.FileDto;
import com.tmc.comm.dao.IBoardDao;

@Service
public class BoardService implements IBoardService{
	@Value("${fileUploadPath}")
	String fileUploadPath;
	 
	@Autowired
	private IBoardDao boardDao;	 
	 
	public int insertPost(String board_num, String user_id, String post_title, String post_content, List<MultipartFile> fileList) {
		int result = 0;
		int postResult = 0;
		int fileResult = 0;
  
		try {			
			String post_num = boardDao.getMaxPostNo();
	         
			postResult = boardDao.insertPost(post_num, board_num, user_id, post_title, post_content);  
        
            //파일 실제 경로
            String realPath = fileUploadPath + "upload\\post\\";              
            
            if(fileList==null){
            	fileResult = 1;
            }
            
            else if(fileList.size()>0 &&!"".equals(fileList.get(0).getOriginalFilename())) {
             //경로 상에 폴더가 없으면 만들기           
	            File dir = new File(realPath);
	             if(!dir.exists()) {
	                  dir.mkdirs();
	                  }           
	               
	                //파일 넣기
	             for (MultipartFile mf : fileList) {
					//실제 파일 이름
					String original_file_name = mf.getOriginalFilename();

					//시간 + 실제 파일 이름
					String save_file_name = System.currentTimeMillis() + original_file_name;
					  
					
					//파일 저장 경로                 
					String savePath = realPath + save_file_name;
					  
					// DB저장 경로
					String dbPath = "/upload/post/";
					  
					// 파일 저장
					File o_file = new File(savePath);               
					mf.transferTo(o_file);         
					   
					String file_num = boardDao.getMaxFileNo(post_num);
					//String file_num = postDao.getMaxFileNo(post_num).equals(null) ? "F0000001" : postDao.getMaxFileNo(post_num);
					   
					fileResult = boardDao.insertFile(file_num, dbPath, post_num, save_file_name, original_file_name);
					}         
	             }
		      }
		      //파일관련 에러 반환
		      catch (IOException io) {
		         System.out.println(io.getMessage());
		      }
		      catch (Exception e) {
		         System.out.println(e.getMessage());
		      }
		      
		      if(postResult==0||fileResult==0) {
		         result = 0;
		      }
		      else
		         result = 1;
		      
		      return result;
	   }
	
	public List<BoardDto> boardList(){
	      
	      List<BoardDto> boardList = boardDao.boardList();
	      return boardList;
	   }
	
	public List<BoardDto> search(String post_title) {
		List<BoardDto> boardList = boardDao.search(post_title);
		
		return boardList;
	}
	
	@Override
	public List<BoardDto> getBoardList(BoardDto params) {
		List<BoardDto> boardList = Collections.emptyList();

		int boardTotalCount = boardDao.selectBoardTotalCount(params);
		
		BoardPaginationInfo paginationInfo = new BoardPaginationInfo(params);
		paginationInfo.setTotalRecordCount(boardTotalCount);
				
		params.setPaginationInfo(paginationInfo);

		if (boardTotalCount > 0) {
			boardList = boardDao.boardList2(params);
		}

		return boardList;
	}
	
	public int deletePost(String post_num) {
	      int result = 0;
	      
	      int deleteFiles = 0;
	      int updateIsuse = 0;
	      try {
	         deleteFiles = boardDao.deleteFiles(post_num);
	         updateIsuse = boardDao.deletePost(post_num);
	      } catch (Exception e) {
	         System.out.println(e.getMessage());
	      }      
	      
	      if(deleteFiles==0&&updateIsuse==0) {
	         result = 0;
	      }else
	         result = 1;
	      
	      return result;
	   }
	
	@Transactional
	@Override
	public int updatePost(String post_num, String post_title, String post_content, List<MultipartFile> fileList, List<FileDto> fileDtoList) {
	      int result = 0;      
	      int fileResult = 0;      
	      int deleteFiles = 0;
	      int updatePost = 0;
	      
	      try {
	         updatePost= boardDao.updatePost(post_num, post_title, post_content);
	         deleteFiles = boardDao.deleteFiles(post_num);
	         
	         for (FileDto md : fileDtoList) {
	            String file_num = boardDao.getMaxFileNo(post_num);      
	            String dbPath = "/upload/post/";
	            String md_save_file_name = md.getSave_file_name();
	            String md_original_file_name = md.getOriginal_file_name();

	            if(!md_save_file_name.equals(md_original_file_name)){
	               fileResult = boardDao.insertFile(file_num, dbPath, post_num, md_save_file_name, md_original_file_name);         
	            } else {}
	         }
	      } catch (Exception e) {
	         System.out.println(e.getMessage());
	      }   
	      
	      
	      try {         
	    	  if(fileList==null){
	            	fileResult = 1;
	            }
	    	  
	    	  else if(fileList.size()>0 &&!"".equals(fileList.get(0).getOriginalFilename())) {
	         
	          String realPath = fileUploadPath + "upload\\post\\";           
	         
	          for (MultipartFile mf : fileList) {
	             //실제 파일 이름
	             String original_file_name = mf.getOriginalFilename();
	             
	                //시간 + 실제 파일 이름
	             String save_file_name = System.currentTimeMillis() + original_file_name;
	               
	             
	             //파일 저장 경로                 
	             String savePath = realPath + save_file_name;
	               
	             // DB저장 경로
	             String dbPath = "/upload/post/";
	               
	             // 파일 저장
	             File o_file = new File(savePath);               
	             mf.transferTo(o_file);         
	            
	             String file_num = boardDao.getMaxFileNo(post_num);
	                        
	              fileResult = boardDao.insertFile(file_num, dbPath, post_num, save_file_name, original_file_name);
	            }               
	         }          
	      } catch (IOException io) {
	         System.out.println(io.getMessage());
	      } catch (Exception e) {
	         System.out.println(e.getMessage());
	      }
	      
	         
	      
	      if(deleteFiles==0&&updatePost==0&&fileResult==0) {
	         result = 0;
	      }else
	         result = 1;
	      
	      return result;
	   } 
	
	public BoardDto getPost(String post_num) {
		BoardDto detailView = boardDao.getPost(post_num);
	      return detailView;
	   }
	
	public List<BoardDto> getFileList(String post_num){
	      
	      List<BoardDto> getFileList = boardDao.getFileList(post_num);
	      return getFileList;      
	   }
}

package com.tmc.comm.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.tmc.comm.dao.BoardDto;
import com.tmc.comm.dao.FileDto;

public interface IBoardService {
	public int insertPost(
			@Param("board_num") String board_num, 
			@Param("user_id") String user_id, 
			@Param("post_title") String post_title, 
			@Param("post_content") String post_content, 
			List<MultipartFile> fileList);
	
	public List<BoardDto> boardList();
		
	public List<BoardDto> search(@Param("post_title") String post_title);
	
	public List<BoardDto> getBoardList(BoardDto parms);
	
	public List<BoardDto> getBoardList2(BoardDto parms);
	
	
	public BoardDto getPost(@Param("post_num") String post_num);
	
	public int deletePost(@Param("post_num") String post_num);
	
	public int updatePost(
			@Param("post_num") String post_num, 
			@Param("post_title") String post_title, 
			@Param("post_content") String post_content, 
			List<MultipartFile> fileList, 
			List<FileDto> fileDtoList);
	
	public List<BoardDto> getFileList(@Param("post_num") String post_num);
}

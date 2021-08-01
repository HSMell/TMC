package com.tmc.comm.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.tools.reflect.Sample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tmc.comm.dao.BoardDto;
import com.tmc.comm.dao.FileDto;
import com.tmc.comm.dao.IBoardDao;
import com.tmc.comm.dao.Pagination;
import com.tmc.comm.service.IBoardService;


@Controller
public class BoardController {

   @Autowired
   IBoardService bService;
   
   @Autowired
   IBoardDao bDao;
   
   @RequestMapping(value = "/notice_list")
   public String boardList(
         @ModelAttribute("BoardDto") BoardDto boardDto,
         @ModelAttribute("parmas") BoardDto params,
         @RequestParam(defaultValue="1") int curPage,
         HttpServletRequest request,
         Model model) throws Exception{
      
      int listCnt = bDao.selectBoardTotalCount(params);
      
      Pagination pagination = new Pagination(listCnt, curPage);
      
      BoardDto.setStartIndex(pagination.getStartIndex());
      BoardDto.setCntPerPage(pagination.getPageSize());
           // 전체리스트 출력
      List<BoardDto> boardList = bService.getBoardList(params);
            
      model.addAttribute("boardList", boardList);
      model.addAttribute("listCnt", listCnt);
           
      model.addAttribute("pagination", pagination);
      
      return "/board/notice_list";      
   }         
   
   @RequestMapping(value = "/notice_list/2")
   public String boardList2(
         @ModelAttribute("BoardDto") BoardDto boardDto,
         @ModelAttribute("parmas") BoardDto params,
         @RequestParam(defaultValue="2") int curPage,
         HttpServletRequest request,
         Model model) throws Exception{
      
      int listCnt = bDao.selectBoardTotalCount(params);
      
      Pagination pagination = new Pagination(listCnt, curPage);
      
      BoardDto.setStartIndex(pagination.getStartIndex());
      BoardDto.setCntPerPage(pagination.getPageSize());
           // 전체리스트 출력
      List<BoardDto> boardList = bService.getBoardList2(params);
            
      model.addAttribute("boardList", boardList);
      model.addAttribute("listCnt", listCnt);
           
      model.addAttribute("pagination", pagination);
      
      return "/board/notice_list";      
   }      
   
   @RequestMapping(value = "/search")
   public String search(Model model,HttpServletRequest req) {

      String search_value = req.getParameter("search_value");
      List<BoardDto> isResult = bService.search(search_value);
      
      model.addAttribute("isResult", isResult);
      
      return "/board/search_list";
   }
         
//   @RequestMapping("/")
//    public String root(@ModelAttribute("parmas") BoardDto params,Model model) throws Exception {
//      
//      List<BoardDto> boardList = bService.boardList();
//      model.addAttribute("boardList", boardList);   
//      
//      return "/board/notice_list";
//      }
//   
//   @RequestMapping("/notice_list")
//    public String root2(@ModelAttribute("parmas") BoardDto params, Model model) {
//      
//      List<BoardDto> boardList = bService.getBoardList(params);
//      model.addAttribute("boardList", boardList);      
//      
//      return "/board/notice_list";
//      }
   
    @RequestMapping("/notice_write")
      public String boardadd(HttpServletRequest req) {       
            return "/board/notice_write";
      }     
    
    @ResponseBody
    @RequestMapping("/requestupload")
    public String requestupload2(@RequestParam("article_file") @Nullable List<MultipartFile> fileList,HttpServletRequest req) {
            
       String board_num = req.getParameter("boardNum");
       String user_id = req.getParameter("user_id");
       String post_content = req.getParameter("text_content");
       String post_title= req.getParameter("text_title");
       
       String result = "";
       int resultint = bService.insertPost(board_num, user_id, post_title, post_content, fileList);
        
       if(resultint == 0) {
          result = "redirect:/notice_write";
          } else {
             result = "redirect:/notice_list";   
          }      
        
       return result;
       }
    
   
    
    @RequestMapping("/notice_view")
    public String postDetailView(HttpServletRequest req, Model model) {
       String post_num = req.getParameter("post_num");
       
       BoardDto result = bDao.getPost(post_num);
       List<BoardDto> getFileList = bService.getFileList(post_num);
       
       model.addAttribute("result", result);
       model.addAttribute("getFileList", getFileList);
         
       return "/board/notice_view";
    }
    
    @ResponseBody
    @RequestMapping("/deleteFiles")
    public  Map<String, Object> deleteFiles(@RequestBody Map<String, Object> reqMap) {
       String post_num = reqMap.get("post_num").toString();
       
       int result = bService.deletePost(post_num);   
         
       Map<String, Object> resultMap = new HashMap<String, Object>();
       String resultStr = result == 0 ? "fail" : "success";
       resultMap.put("succesed", resultStr);
         
       return resultMap;
      }
    
    @RequestMapping("/notice_modify")
      public String updatePost(HttpServletRequest req, Model model) {
         String post_num = req.getParameter("hdn_postNum");
         
         BoardDto result = bService.getPost(post_num);
         
         List<BoardDto> getFileList = bService.getFileList(post_num);
         
         model.addAttribute("viewPost", result);
         model.addAttribute("getFileList", getFileList);
         
         return "/board/notice_modify";
      }
    
    @ResponseBody
      @RequestMapping("/reupload")
       public String requestupload(@RequestParam("article_file") @Nullable List<MultipartFile> fileList,HttpServletRequest req) {
         /* 글 내용 */ 
       String post_title = req.getParameter("text_title");       
         String post_content = req.getParameter("text_content");         
         String post_num = req.getParameter("post_num");
         String[] originals = req.getParameterValues("original_file_name");
         String[] saves = req.getParameterValues("save_file_name");
         
         List<FileDto> fileDtoList = new  ArrayList<FileDto>();
         
         String result = "";
         
         if(originals == null ) {
            int resultint = bService.updatePost(post_num, post_title, post_content, fileList, fileDtoList);
            
            if(resultint == 0) {
               result = "redirect:/notice_modify";
            } else {
               result = "redirect:/notice_list";   
            }      
            return result;
         }
         
         for (int i=0; i<originals.length;i++) {
            FileDto dto = new FileDto();
            dto.setOriginal_file_name(originals[i]);
            dto.setSave_file_name(saves[i]);
            fileDtoList.add(dto);
         }    
         /* 글 수정 서비스 */            
         int resultint = bService.updatePost(post_num, post_title, post_content, fileList, fileDtoList);
         
         if(resultint == 0) {
            result = "redirect:/notice_modify";
         } else {
            result = "redirect:/notice_list";   
         }      
         return result;
      }
}
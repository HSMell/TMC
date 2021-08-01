package com.tmc.comm.dao;

import java.util.List;

import lombok.Data;

@Data
public class BoardDto extends CommonDto{
	private String post_num;
	private String board_num;
	private String user_id;
	private String post_title;	
	private String post_content;
	private String write_date;
	private String update_date;	
	private String file_num;
	private String file_path;	
	private String save_file_name;
	private String original_file_name;
			
	private List<String> list_file_path;
	private List<String> list_save_file_name;
	
	public List<String> getList_save_file_name() {
		return list_save_file_name;
	}
	public void setList_save_file_name(List<String> list_save_file_name) {
		this.list_save_file_name = list_save_file_name;
	}
	public List<String> getList_file_path() {
		return list_file_path;
	}
	public void setList_file_path(List<String> list_file_path) {
		this.list_file_path = list_file_path;
	}
	public String getPost_num() {
		return post_num;
	}
	public void setPost_num(String post_num) {
		this.post_num = post_num;
	}
	public String getBoard_num() {
		return board_num;
	}
	public void setBoard_num(String board_num) {
		this.board_num = board_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public String getPost_content() {
		return post_content;
	}
	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getFile_num() {
		return file_num;
	}
	public void setFile_num(String file_num) {
		this.file_num = file_num;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getSave_file_name() {
		return save_file_name;
	}
	public void setSave_file_name(String save_file_name) {
		this.save_file_name = save_file_name;
	}
	public String getOriginal_file_name() {
		return original_file_name;
	}
	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public static void setStartIndex(int startIndex) {
		// TODO Auto-generated method stub
		
	}
	public static void setCntPerPage(int pageSize) {
		// TODO Auto-generated method stub
		
	}
}

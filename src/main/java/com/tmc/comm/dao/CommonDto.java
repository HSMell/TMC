package com.tmc.comm.dao;

import lombok.Data;

@Data
public class CommonDto extends BoardCriteria{
	private BoardPaginationInfo paginationInfo;

	public BoardPaginationInfo getPaginationInfo() {
		return paginationInfo;
	}

	public void setPaginationInfo(BoardPaginationInfo paginationInfo) {
		this.paginationInfo = paginationInfo;
	}
}

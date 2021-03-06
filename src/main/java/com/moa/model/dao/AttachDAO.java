package com.moa.model.dao;

import com.moa.model.vo.AttachFileVO;
import com.moa.model.vo.StoreBoardAttachFileVO;
import com.moa.model.vo.StoreRequestAttachFileVO;
import com.moa.model.vo.UserAttachFileVO;

import java.util.List;

public interface AttachDAO {
    boolean insertAttach(AttachFileVO attachFileVO);
    boolean deleteAttachSB(String uuid);
    boolean deleteAttachSR(String uuid);
    boolean deleteAttachUSER(String uuid);
    List<AttachFileVO> searchByArticleSB(Long articleNum);
    List<AttachFileVO> searchByArticleSR(Long articleNum);
    AttachFileVO searchByUserId(Long userId);
    List<AttachFileVO> getOldFiles();
}

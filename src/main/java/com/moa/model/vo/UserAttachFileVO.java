package com.moa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class UserAttachFileVO extends AttachFileVO {
    public UserAttachFileVO(String typeFlag) {
        super(typeFlag);
    }
    public UserAttachFileVO(Long id, String uuid,String uploadPath, String fileName, boolean fileType) {
        super(uuid, id, uploadPath, fileName, fileType,null);
    }

    public UserAttachFileVO(String uuid, Long id, String uploadPath, String fileName, boolean fileType, String typeFlag) {
        super(uuid, id, uploadPath, fileName, fileType, typeFlag);
    }
}

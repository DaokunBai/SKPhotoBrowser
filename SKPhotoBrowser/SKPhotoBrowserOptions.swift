//
//  SKPhotoBrowserOptions.swift
//  SKPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/18.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import UIKit

public struct SKPhotoBrowserOptions {
    /* 是否显示状态栏 */
    public static var displayStatusbar: Bool = false
    /* 是否显示操作按钮（分享，保存到相册等等） */
    public static var displayAction: Bool = true
    /* 标题之外统一拼接的内容 */
    public static var shareExtraCaption: String? = nil
    /* 操作按钮显示的标题数组 */
    public static var actionButtonTitles: [String]?
    /* 是否显示工具条 */
    public static var displayToolbar: Bool = true
    /* 是否显示页码 */
    public static var displayCounterLabel: Bool = true
    /* 是否显示页码左右箭头按钮 */
    public static var displayBackAndForwardButton: Bool = true
    /* 是否开启垂直方向轻扫手势退出模式 */
    public static var disableVerticalSwipe: Bool = false
    /* 是否显示退出浏览模式按钮 */
    public static var displayCloseButton: Bool = true
    /* 是否显示删除按钮 */
    public static var displayDeleteButton: Bool = false
    /* 是否显示水平滚动条 */
    public static var displayHorizontalScrollIndicator: Bool = true
    /* 是否显示垂直滚动条 */
    public static var displayVerticalScrollIndicator: Bool = true
    /* 图片显示时，是否需要弹性动画 */
    public static var bounceAnimation: Bool = false
    /* 图片外的区域是否响应事件 */
    public static var enableZoomBlackArea: Bool = true
    /* 是否启用单击退出浏览模式功能 */
    public static var enableSingleTapDismiss: Bool = false
    /* 图片显示区域以外的背景色 */
    public static var backgroundColor: UIColor = .black
}

public struct SKCaptionOptions {
    public static var textColor: UIColor = .white
    public static var textAlignment: NSTextAlignment = .center
    public static var numberOfLine: Int = 3
    public static var lineBreakMode: NSLineBreakMode = .byTruncatingTail
    public static var font: UIFont = .systemFont(ofSize: 17.0)
}

public struct SKToolbarOptions {
    public static var textColor: UIColor = .white
    public static var font: UIFont = .systemFont(ofSize: 17.0)
}

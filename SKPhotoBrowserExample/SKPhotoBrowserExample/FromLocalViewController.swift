//
//  ViewController.swift
//  SKPhotoBrowserExample
//
//  Created by suzuki_keishi on 2015/10/06.
//  Copyright © 2015 suzuki_keishi. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class FromLocalViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SKPhotoBrowserDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [SKPhotoProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SKPhotoBrowserOptions.displayStatusbar = false  // 是否显示状态栏
        SKPhotoBrowserOptions.displayAction = true      // 分享按钮
        SKPhotoBrowserOptions.shareExtraCaption = nil // 标题之外统一拼接的内容
        SKPhotoBrowserOptions.actionButtonTitles = ["保存到相册", "分享"]
        SKPhotoBrowserOptions.displayToolbar = true   // 是否显示工具条
        SKPhotoBrowserOptions.displayCounterLabel = true    // 是否显示页码
        SKPhotoBrowserOptions.displayBackAndForwardButton = false    // 页码左右箭头按钮
        SKPhotoBrowserOptions.disableVerticalSwipe = true   // 是否开启垂直方向轻扫手势退出模式
        SKPhotoBrowserOptions.displayCloseButton =  false    // 退出浏览模式按钮
        SKPhotoBrowserOptions.displayDeleteButton = false    // 删除照片按钮
        SKPhotoBrowserOptions.displayHorizontalScrollIndicator = false // 是否显示水平滚动条
        SKPhotoBrowserOptions.displayVerticalScrollIndicator = false // 是否显示垂直滚动条
        SKPhotoBrowserOptions.bounceAnimation = true   // 图片显示时，是否不要弹性动画
        SKPhotoBrowserOptions.enableZoomBlackArea = true  // 图片外的区域是否响应时间（单击退出）
        SKPhotoBrowserOptions.enableSingleTapDismiss = true // 是否启用单击退出浏览模式功能
        SKPhotoBrowserOptions.backgroundColor = .black   // 图片显示外的区域背景色

        setupTestData()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


 // MARK: - UICollectionViewDataSource
extension FromLocalViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exampleCollectionViewCell", for: indexPath) as? ExampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.exampleImageView.image = UIImage(named: "image\((indexPath as NSIndexPath).row % 10).jpg")
//        cell.exampleImageView.contentMode = .ScaleAspectFill
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FromLocalViewController {
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExampleCollectionViewCell else {
            return
        }
        guard let originImage = cell.exampleImageView.image else {
            return
        }
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: images, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.delegate = self
//        browser.updateCloseButton(UIImage(named: "image1.jpg")!)
        
        present(browser, animated: true, completion: {})
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 300)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 200)
        }
    }
}


// MARK: - SKPhotoBrowserDelegate

extension FromLocalViewController {
    func didShowPhotoAtIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
    }
    
    func willDismissAtPageIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
    }
    
    func willShowActionSheet(_ photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(_ index: Int) {
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
    func removePhoto(index: Int, reload: (() -> Void)) {
        reload()
    }
    
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
}

// MARK: - private

private extension FromLocalViewController {
    func setupTestData() {
        images = createLocalPhotos()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createLocalPhotos() -> [SKPhotoProtocol] {
        return (0..<10).map { (i: Int) -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10).jpg")!)
//            photo.caption = caption[i%10]
//            photo.contentMode = .ScaleAspectFill
            return photo
        }
    }
}

class ExampleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var exampleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exampleImageView.image = nil
        layer.cornerRadius = 25.0
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        exampleImageView.image = nil
    }
}

var caption = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               ]

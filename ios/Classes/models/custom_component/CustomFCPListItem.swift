//
//  FCPListItem.swift
//  flutter_carplay
//
//  Created by Oğuzhan Atalay on 21.08.2021.
//

import CarPlay

@available(iOS 14.0, *)
class CustomFCPListItem {
  private(set) var _super: CPListItem?
  private(set) var elementId: String
  private var text: String
  private var detailText: String?
  private var isOnPressListenerActive: Bool = false
  private var completeHandler: (() -> Void)?
  private var image: String?
  private var playbackProgress: CGFloat?
  private var isPlaying: Bool?
  private var accessoryType: CPListItemAccessoryType?
  
  init(obj: [String : Any]) {
    self.elementId = obj["_elementId"] as! String
    self.text = obj["text"] as! String
    self.detailText = obj["detailText"] as? String
    self.isOnPressListenerActive = obj["onPress"] as? Bool ?? false
    self.image = obj["image"] as? String
    self.playbackProgress = obj["playbackProgress"] as? CGFloat
    self.isPlaying = obj["isPlaying"] as? Bool
  }
  
  var get: CustomFCPListItem {
    let listItem = CustomFCPListItem.init(text: text, detailText: detailText)
    listItem.handler = ((CPSelectableListItem, @escaping () -> Void) -> Void)? { selectedItem, complete in
      if self.isOnPressListenerActive == true {
        DispatchQueue.main.async {
          self.completeHandler = complete
          FCPStreamHandlerPlugin.sendEvent(type: FCPChannelTypes.onListItemSelected,
                                           data: ["elementId": self.elementId])
        }
      } else {
        complete()
      }
    }
    if image != nil {
      listItem.setImage(UIImage().fromFlutterAsset(name: image!))
    }
    if playbackProgress != nil {
      listItem.playbackProgress = playbackProgress!
    }
    if isPlaying != nil {
      listItem.isPlaying = isPlaying!
    }
    if accessoryType != nil {
      listItem.accessoryType = accessoryType!
    }
    self._super = listItem
    return listItem
  }
  
  public func stopHandler() {
    guard self.completeHandler != nil else {
      return
    }
    self.completeHandler!()
    self.completeHandler = nil
  }
  
  public func update(text: String?, detailText: String?, image: String?, playbackProgress: CGFloat?, isPlaying: Bool?, accessoryType: String?) {
    if text != nil {
      self._super?.setText(text!)
      self.text = text!
    }
    if detailText != nil {
      self._super?.setDetailText(detailText)
      self.detailText = detailText
    }
    if image != nil {
      self._super?.setImage(UIImage().fromFlutterAsset(name: image!))
      self.image = image
    }
    if playbackProgress != nil {
      self._super?.playbackProgress = playbackProgress!
      self.playbackProgress = playbackProgress
    }
    if isPlaying != nil {
      self._super?.isPlaying = isPlaying!
      self.isPlaying = isPlaying
    }
  }
}

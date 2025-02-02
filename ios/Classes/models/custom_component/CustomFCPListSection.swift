//
//  FCPListSection.swift
//  flutter_carplay
//
//  Created by Oğuzhan Atalay on 21.08.2021.
//

import CarPlay

@available(iOS 14.0, *)
class CustomFCPListSection {
  private(set) var _super: CPListSection?
  private(set) var elementId: String
  private var header: String?
  private var items: [CPListTemplateItem]
  private var objcItems: [CustomFCPListItem]
  
  init(obj: [String : Any]) {
    self.elementId = obj["_elementId"] as! String
    self.header = obj["header"] as? String
    self.objcItems = (obj["items"] as! Array<[String : Any]>).map {
      CustomFCPListItem(obj: $0)
    }
    self.items = self.objcItems.map {
      $0.get
    }
  }
  
  var get: CustomFCPListSection {
    let listSection = CustomFCPListSection.init(items: items, header: header, sectionIndexTitle: header)
    self._super = listSection
    return listSection
  }
  
  public func getItems() -> [CustomFCPListItem] {
    return objcItems 
  }
}

//
//  AVAsset+EZPlayer.swift
//  EZPlayer
//
//  Created by yangjun zhu on 2016/12/28.
//  Copyright © 2016年 yangjun zhu. All rights reserved.
//


///
/// おそらく今回のアプリでは使わない想定です。
///


import AVFoundation
public extension AVAsset {

    // タイトル取得 ???
    // https://developer.apple.com/reference/avfoundation/avmetadataitem
    public var title: String? {
        
        
        var error: NSError?
        let status = self.statusOfValue(forKey: "commonMetadata", error: &error)
        
        if error != nil {
            return nil
        }
        if status == .loaded{
            let metadataItems = AVMetadataItem.metadataItems(from: self.commonMetadata, withKey: AVMetadataCommonKeyTitle, keySpace: AVMetadataKeySpaceCommon)
            if metadataItems.count > 0  {
                let titleItem = metadataItems.first
                
                print(titleItem!)
                
                return titleItem?.value as? String
            }
        }
        return nil
    }

    /// cc 字幕 ???
    public var closedCaption: [AVMediaSelectionOption]? {
        var closedCaptions = [AVMediaSelectionOption]()
        if let mediaSelectionGroup = self.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristicLegible){
            for option in mediaSelectionGroup.options {
                if option.mediaType == "clcp" {
                    closedCaptions.append(option)
                }
            }
        }
        if closedCaptions.count > 0{
            
            print(closedCaptions)
            
            return closedCaptions
        }
        return nil
    }

    /// subtitle
    public var subtitles: [(subtitle: AVMediaSelectionOption,localDisplayName: String)]? {
        var subtitles = [(subtitle: AVMediaSelectionOption,localDisplayName: String)]()
        if let mediaSelectionGroup = self.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristicLegible){
            for option in mediaSelectionGroup.options {
                if !option.hasMediaCharacteristic(AVMediaCharacteristicContainsOnlyForcedSubtitles) {
                    if let localDisplayName = self.localDisplayName(forMediaSelectionOption: option){
                        subtitles.append((option,localDisplayName))
                    }
                }
            }
        }
        if subtitles.count > 0{
            
            print(subtitles)
            
            return subtitles
        }
        return nil
    }

    /// audio
    public var audios: [(audio: AVMediaSelectionOption,localDisplayName: String)]? {
        var audios = [(audio: AVMediaSelectionOption,localDisplayName: String)]()
        if let mediaSelectionGroup = self.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristicAudible){
            for option in mediaSelectionGroup.options {
                if let localDisplayName = self.localDisplayName(forMediaSelectionOption: option){
                    audios.append((option,localDisplayName))
                }
            }
            if audios.count > 0{
                
                print(audios)
                
                return audios
            }
        }
        return nil
    }

    public func localDisplayName(forMediaSelectionOption subtitle: AVMediaSelectionOption) -> String?{
        var title: String? = nil
        var metadataItems = AVMetadataItem.metadataItems(from: subtitle.commonMetadata, withKey: AVMetadataCommonKeyTitle, keySpace: AVMetadataKeySpaceCommon)
        if metadataItems.count > 0 {
            let preferredLanguages = NSLocale.preferredLanguages
            for language: String in preferredLanguages {
                let locale = Locale(identifier: language)
                var titlesForLocale = AVMetadataItem.metadataItems(from: metadataItems, with: locale)
                if titlesForLocale.count > 0 {
                    title = titlesForLocale[0].stringValue
                    break
                }
            }
            if title == nil {
                title = metadataItems[0].stringValue
            }
        }
        
        print(title!)
        
        return title
    }

}

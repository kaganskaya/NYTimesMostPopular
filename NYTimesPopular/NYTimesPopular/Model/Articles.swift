//
//  Articles.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 5/31/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

    struct Article: Codable {
        
        let url: String?
        let adxKeywords: String?
        let column: String?
        let section, byline: String?
        let type: ResultType?
        let title, abstract, publishedDate: String?
        let source: Source?
        let id, assetID, views: Int?
        let desFacet: [String]?
        let orgFacet, perFacet, geoFacet: Facet?
        let media: [Media]?
        let uri: String?
        
        let subsection: String?
        let shareCount: Int?
        let countType: CountType?
        let etaID: Int?
        let nytdsection: String?
        let updated: String?
        
       
        let emailCount: Int?
        
        enum CodingKeys: String, CodingKey {
            
            case url
            case adxKeywords = "adx_keywords"
            case column, section, byline, type, title, abstract
            case nytdsection
            case publishedDate = "published_date"
            case source, id
            case assetID = "asset_id"
            case views
            case desFacet = "des_facet"
            case orgFacet = "org_facet"
            case perFacet = "per_facet"
            case geoFacet = "geo_facet"
            case media, uri
            case updated
            case subsection
            case shareCount = "share_count"
            case countType = "count_type"
            case etaID = "eta_id"
            case emailCount = "email_count"

            
        }
    }

    enum CountType: String, Codable {
        case emailed = "EMAILED"
        case sharedFacebook = "SHARED-FACEBOOK"
    }
    enum Subsection: String, Codable {
        case artDesign = "art & design"
        case asiaPacific = "asia pacific"
        case empty = ""
        case politics = "politics"
    }

    enum Facet: Codable {
        case string(String)
        case stringArray([String])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([String].self) {
                self = .stringArray(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(Facet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Facet"))
        }
    
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let x):
                try container.encode(x)
            case .stringArray(let x):
                try container.encode(x)
                }
            }
    }

    struct Media: Codable {
        let type: MediaType
        let subtype: Subtype
        let caption, copyright: String
        let approvedForSyndication: Int
        let mediaMetadata: [MediaMetadatum]
        
        enum CodingKeys: String, CodingKey {
            case type, subtype, caption, copyright
            case approvedForSyndication = "approved_for_syndication"
            case mediaMetadata = "media-metadata"
        }
    }

    struct MediaMetadatum: Codable {
        let url: String
        let format: Format
        let height, width: Int
    }

    enum Format: String, Codable {
        case mediumThreeByTwo210 = "mediumThreeByTwo210"
        case mediumThreeByTwo440 = "mediumThreeByTwo440"
        case standardThumbnail = "Standard Thumbnail"
    }

    enum Subtype: String, Codable {
        case photo = "photo"
    }

    enum MediaType: String, Codable {
        case image = "image"
    }

    enum Source: String, Codable {
        case ap = "AP"
        case theNewYorkTimes = "The New York Times"
    }

    enum ResultType: String, Codable {
        case article = "Article"
        case interactive = "Interactive"
    }

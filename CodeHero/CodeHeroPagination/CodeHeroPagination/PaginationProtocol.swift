//
//  PaginationProtocol.swift
//  CodeHeroPagination
//
//  Created by Rafael Escaleira on 18/07/21.
//

import Foundation

public protocol PaginationDelegate {
    func pagination(didSelected offset: Int)
}

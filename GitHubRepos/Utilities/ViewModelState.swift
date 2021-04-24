//
//  ViewModelState.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import Foundation
import Combine

enum ViewModelState {
    case empty
    case loading(Cancellable)
    case loaded
    case error(Error)
}

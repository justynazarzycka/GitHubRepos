//
//  checkVMState.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import SwiftUI

func checkVMState(content: AnyView, state: ViewModelState) -> some View {
    switch state {
    case .empty:
        return AnyView(EmptyView())
    case .loading:
        return AnyView(ProgressView())
    case .loaded:
        return AnyView(content)
    case let .error(error):
        return AnyView(Text(error.localizedDescription))
    }
}

//
//  PlaceManagerView.swift
//  ThePlace2019
//
//  Created by Artem Evdokimov on 26.10.19.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import SwiftUI



struct PlaceManagerView: UIViewControllerRepresentable {
//    func makeCoordinator() -> PlaceManagerView.Coordinator {
//        Coordinator(self)
//    }
    
    func makeUIViewController(context: Context) -> SearchAddressVC {
        SearchAddressVC(nibName: "SearchAddressVC", bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: SearchAddressVC, context: UIViewControllerRepresentableContext<PlaceManagerView>) {
        
    }
}

struct PlaceManagerView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceManagerView()
    }
}

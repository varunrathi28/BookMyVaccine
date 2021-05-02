//
//  ChildViewcontroller.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//


import SwiftUI

class ChildViewcontroller: UIHostingController<CustomView> {
    required init?(coder: NSCoder) {
            super.init(coder: coder,rootView:CustomView());
        }

        override func viewDidLoad() {
            super.viewDidLoad()
        }
}

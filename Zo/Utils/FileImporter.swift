//
//  FileImporter.swift
//  Zo
//
//  Created by Brian Heralall on 4/21/22.
//

import SwiftUI
import UniformTypeIdentifiers

// Similar to Image Picker, however, selecting files. 

struct MessageDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.plainText, .pdf] }

    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    /** A representation of a file in the file system. **/
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
    
    
    
}

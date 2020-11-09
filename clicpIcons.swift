#!/usr/bin/swift


import Foundation

// Do a/Users/hanlitao/Desktop/eee/eeeny additional setup after loading the view.
let sourcePath = "/Users/hanlitao/Desktop/定制资源/Icons"
let workProjectPath = "/Users/hanlitao/Desktop/rrrfffffffccvgghh/rrrfffffffccvgghh"

let manger = FileManager.default
let exportpath = sourcePath  + "/AppIcon.appiconset"
if manger.fileExists(atPath: exportpath) {
   try! manger.removeItem(atPath: exportpath)
}
try! manger.createDirectory(atPath: exportpath, withIntermediateDirectories: true, attributes: nil)
let array = try! manger.contentsOfDirectory(atPath:sourcePath)
for (_,obj) in array.enumerated(){
    if obj == "AppIcon.appiconset" {
        continue
    }
    let originPath =  sourcePath + "/\(obj)"
    let url = URL(fileURLWithPath: originPath)
    let inoutData = try! Data.init(contentsOf: url)
    let dataProvider = CGDataProvider(data: inoutData as CFData)
    if let inputImage = CGImage(pngDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent) {
        if inputImage.width == 1024 {
            print(inputImage.width)
                   print("转换成功")
            
            createImage(image: inputImage, scale: 2, iphone: "iphone")
            createImage(image: inputImage, scale: 3, iphone: "iphone")
            
            createImage(image: inputImage, scale: 1, iphone: "ipad")
            createImage(image: inputImage, scale: 2, iphone: "ipad")

        }else{
            print("转换失败，图片必须是1024Px")
            
        }
        
    }else {
        print("转换失败，图片必须是png格式")
    }
}

for (_,obj) in array.enumerated(){
    let string:NSString = obj as NSString
    if string.pathExtension == "png" {
     
        let originPath =  sourcePath + "/\(obj)"
        
        try! manger.copyItem(atPath:  originPath , toPath: exportpath + "/1024.png")
    }
}

let data =   manger.contents(atPath: exportpath + "/Contents.json" )

let jsonString = "{\n  \"images\" : [\n    {\n      \"filename\" : \"20@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"20@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"29@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"29@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"40@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"40@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"60@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"60x60\"\n    },\n    {\n      \"filename\" : \"60@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"60x60\"\n    },\n    {\n      \"filename\" : \"20@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"20@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"29@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"29@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"40@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"40@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"76@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"76x76\"\n    },\n    {\n      \"filename\" : \"76@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"76x76\"\n    },\n    {\n      \"filename\" : \"83.5@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"83.5x83.5\"\n    },\n    {\n      \"filename\" : \"1024.png\",\n      \"idiom\" : \"ios-marketing\",\n      \"scale\" : \"1x\",\n      \"size\" : \"1024x1024\"\n    }\n  ],\n  \"info\" : {\n    \"author\" : \"xcode\",\n    \"version\" : 1\n  }\n}\n"

//try! jsonString.write(toFile: exportpath + "/1cc.json", atomically: true, encoding: .utf8)


let jsonData = jsonString.data(using: .utf8)
    
manger.createFile(atPath: exportpath + "/Contents.json", contents: jsonData!, attributes: nil)

let desnation = workProjectPath + "/Assets.xcassets" + "/AppIcon.appiconset"

if manger.fileExists(atPath: desnation){
   try!  manger.removeItem(atPath: desnation)
}

try! manger.moveItem(atPath: exportpath, toPath: desnation)



//1024 1      2x 80 3x 120
func createImage(image:CGImage,scale:Int,iphone:String){
    let iphoneArray  = [20,29,40,60.0]
    let ipadArray = [20,29,40,76,83.5]
    var name = ""
    
    var array = iphoneArray
    
    if iphone == "iphone" {
        
    }else{
        array = ipadArray
    }
    
    if scale == 1 {
        name = "@x"
    }
    if scale == 2 {
        name = "@2x"
    }
    if scale == 3 {
        name = "@3x"
    }
    
    for widthPt in array{
        if widthPt == 83.5 && scale == 1{
            continue
        }
        
                let width = Int(widthPt*Double(scale))
                let height = Int(widthPt*Double(scale))
        
                var test = ""
             
              
              if widthPt == 83.5 {
                  test   = String(widthPt) + "\(name)"
              }else{
             
                
                 test = String(Int(widthPt)) + "\(name)"
              }
               
               let fileName = test
        
               
              
                let bitsPerComponent = image.bitsPerComponent
                let bytesPerRow = image.bytesPerRow
                let colorSpace  = CGColorSpaceCreateDeviceRGB()
                
                if let context = CGContext.init(data: nil,
                                                width: width,
                                                height: height,
                                                bitsPerComponent: bitsPerComponent,
                                                bytesPerRow: bytesPerRow,
                                                space: colorSpace,
                                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                    context.interpolationQuality = .high
                    context.draw(image, in: .init(origin: .zero, size: .init(width: width, height: height)))
                    if let outputImage = context.makeImage() {
                        let outputImagePath = exportpath + "/\(fileName).png"
                        let outputUrl = URL(fileURLWithPath: outputImagePath) as CFURL
                        let destination = CGImageDestinationCreateWithURL(outputUrl, kUTTypePNG, 1, nil)
                        if let destination = destination {
                            CGImageDestinationAddImage(destination, outputImage, nil)
                            if CGImageDestinationFinalize(destination) {
                                print("图片生成成功\n")
                            }else {
                                // print("图片: \(filename) 生成失败\n")
                            }
                        }
                    }else {
                        print("图片生成失败")
                    }
                }
        }
}



import Foundation

class SessionConfig {
    var isInitiator: Bool
    var turn: TurnConfig
    var streams: StreamsConfig
    
    init(data: Any) {
        self.isInitiator = data.objectForKey("isInitiator") as! Bool
        
        let turnObject: Any = data.objectForKey("turn")!
        self.turn = TurnConfig(
            host: turnObject.objectForKey("host") as! String,
            username: turnObject.objectForKey("username") as! String,
            password: turnObject.objectForKey("password") as! String
        )
        
        let streamsObject: Any = data.objectForKey("streams")!
        self.streams = StreamsConfig(
            audio: streamsObject.objectForKey("audio") as! Bool,
            video: streamsObject.objectForKey("video") as! Bool
        )
    }
}

struct TurnConfig {
    var host: String
    var username: String
    var password: String
}

struct StreamsConfig {
    var audio: Bool
    var video: Bool
}

class VideoConfig {
    var container: VideoLayoutParams
    var local: VideoLayoutParams?
    
    init(data: Any) {
        let containerParams: Any = data.objectForKey("containerParams")!
        let localParams: Any? = data.objectForKey("local")
        
        self.container = VideoLayoutParams(data: containerParams)
        
        if localParams != nil {
            self.local = VideoLayoutParams(data: localParams!)
        }
    }
}

class VideoLayoutParams {
    var x, y, width, height: Int
    
    init(x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    init(data: Any) {
        let position: [Any] = data.objectForKey("position")! as! [Any]
        self.x = position[0] as! Int
        self.y = position[1] as! Int
        
        let size: [Any] = data.objectForKey("size")! as! [Any]
        self.width = size[0] as! Int
        self.height = size[1] as! Int
    }
}

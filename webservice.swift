/// global
var descripcionPelis:String?


//// dentro del onload de mi tercera actividad
let urlPath = "https://api.themoviedb.org/3/search/movie?api_key=1ab15817353555a79ecfc10362b60413&query="

let url = NSURL(string : urlPath)

let session = NSURLSession.sharedSession()


let task = session.dataTaskWithUrl(url!, completionHandler: {data, response, error -> Void in


if(error != nil){
	print(error.localizedDescription)
}

var nsdata:NSData(data:data)
self.recuperarInfoPelis(nsdata)

dispatch_async(dispatch_get_main_queue(), {println(self.descripcionPelis!);   self.labeldescripcionPelis.text = self.descripcionPelis    })

})

task.resume()

}

/// parsear

func recuperarInfoPelis(nsdata:NSData){
	let jsoncompleto : AnyObject! = NSJSONSerialization.JSONobjectWithData (nsdata,options:NSJSONReadingOptions.MutableContainers, error : nil)

	let arregloJson = jsoncompleto["results"]
	if let jsonArray = arregloJson as? NSArray{
	jsonArray.enumerateObjectsUsingBlock({model,index,stop in
	let descripcionPelis = model["overview"] as String

	print(descripcionPelis) 


	});
	}

}

# apey-cocoa

Example Gist API iOS app

Takes the 30 latest public gists on Github, and lets you explore them.

Uses AFNetworking for the requests to the Github API, and uses AFNetworking's JSON serializer to build an NSDictionary object for iterating on.

It should probably have formal classes for what we expect from the API and what we use, but there wasn't enough time. It should also probably have been built using something like RestKit if it wasn't just a demo.

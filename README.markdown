



# To-do


## Back-end (sinatra/mongo)

* Connect to a mongoHQ database
* Design basic mongo collections (bookmark & user)
* DIO - Authentication module, login, retrieve password, etc (no facebook/twitter sign-on for now)
* Save and retrieve bookmarks from database (instead of the delicious feed)
* Remove a bookmarks from a specific user feed.
* Retrieve basic site bookmarks metadata (title, meta desc, keywords, etc)
* Import from file (parse a posted chrome/ff/ie bookmark file)
* Import from delicious (from a public user feed)
* Flag a bookmarks options (spam, copyright, adult, etc)
* Website Snapshot (process that load a webpage and makes a snapshot jpg). Maybe use yottaSnap web-service? GD lib?
* Queue management for website snapshots (we have to throttle this heavy process.)
* Create scripts that analyses websites and generates facts. ex:
	* Single page website? (no internal links to other pages)
	* Rss-enabled? (has rss feed link in header)
	* CMS? (check if site is using popular blogging engine like wordpress, thumblr, etc)
	* Using jquery, analytics, etc? (we check the included JS)
	* Key website colours? (we analyze the snapshot thumbnails)

	
#### Back-End (Lower priority)

* Admin tools: 
	* remove bookmark from DB (and all users that had it), 
	* ban users/ip (spammers/trolls)
* Invite system: let users invites others.
* Simple Feedback system: letting user post comment
* Import/sync  delicious bookmarks from a private user feed (would require delicious auth)
* Retrieve more metadata info about websites using freebase.com API
* Matching websites from a specific field to an Ontology (so users can filter them with precise criteria). Fields-specefic classification opens a  world of possibilities, so we'll make sure we have a stable product before implementing these features.
	

## Design(css/html)
* Design preference/settings page
* Better style the visual bookmarks listing, and add flag/remove/details buttons.
* Design an alternative "list view"
* Design importing workflow (clear instructions + file upload control)
* Design the login pages (create account, login, lost my account)
* Mobile-optimized design
* Design a public page (so users can sign-up for beta invites)
* Design a detail page for bookmarks (larger snapshot, we show all fact around this website). This will NOT be part of the usual user workflow, but more of an extra page with additional info and advanced options (for contributors and power users)


## Front-end (js/html)
* Save/retrieve viewing preference (zoom level) to a local cookie
* Save bookmark data locally, using html5 LocaStorage (so we don't need to re-query the server for the same data every time.)
* Update accounts settings using the API (ajax call)
* Add login controls to template
* Handle bookmark adding & removing (handling the Dom element, and contacting the API in parallel)
* Add options for each bookmarks (flag, delete, details)
* Trigger Google-analytics pageviews on key events (add url, visit a link, etc).
* Show options of a bookmarks on rollover (remove, details, etc)
* Improve the regEx for Urls (more permissive...)
* Fine-tune the file upload (show progress, possibly improbe the upload.js script)
* Detect user-agent (browser + deveice), and set classes on the body accordingly (so we can toggle specific settings)
* Settings: Toggle different instructions for different browsers using the Select input.






# More Info

Discussion (prompt.im):
http://prompt.im/SemanticBookmarks

Demo
http://semantic-bookmarks.heroku.com/


google bookmark api.
http://code.google.com/p/gmarks-android/wiki/BookmarksAPI




### possibly missing gems?
* bundler
* ZenTest?
* autotest
* ZenTest

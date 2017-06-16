
This project has been coded using Xocde 8 (8E162) and Swift 3

Features:
Main view has a search bar in which you can enter any text to view result of Flickr image search API for that text. Tapping on (bookmark) icon on top right displays all searched history items.


What could be done better:

1) Adding a loader/spinner to display during the time when results are being fetched from api.  
2) Purging data from memory ie; when user scrolls down and down from page 1 to n then the result array keeps on increasing. We could just keep result of current page (+ previous and next page) and purge all others. Fetch them on demand (of user's scrolling)
3) Past search history could be saved in persistent store such as Core Data, etc.
4) Adding testcases

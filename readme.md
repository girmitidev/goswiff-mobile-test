#GoSwiff Mobile Test

######Files
	/data/GoSwiff.db
	
######Schema
	Tables
	- countries
		- `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE
		- `code3L` TEXT
		- `code2L` TEXT
		- `name` TEXT
		- `name_official` TEXT
		- `flag_32` TEXT
		- `flag_128` TEXT
		- `latitude` TEXT
		- `longitude` TEXT
	
######Requirements
1. Create a mobile app for each platform with the following functionality
	- **Home Page**   
	This page will list all the countries from the SQLite database included in a
		- iOS: Table View
		- Android: List View   
		
		There should be a search functionality to filter the countries.
		Each row will show the 32x16 flag on the left, and the name on the right.
		
		Tapping on the row will open the detail page of the country
	- **Detail Page**   
	This page will show the 128x64 flag, the official name, and a map view configured to point to the coordinates listed.
	

######Delivery
A public Github repository with the completed project. Commit history should preferably be included. Temporary Github accounts is ok.

######Objectives
- Navigating from master view to detail view
- SQLite familiarity
- HTTP requests familiarity
- Search and filter familiarity
- Image caching familiarity
- Image memory management
- System design
- Maps integration familiarity
- GIT familiarity
- Project setup
- Ready to compile test (source code should compile without errors)
- Apps will be profiled for performance and memory
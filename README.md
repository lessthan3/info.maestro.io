# info.maestro.io

http://info.maestro.io/

### Project Overview
This is the source code for the info.maestro.io website. It is a great example of a dobi application. 

- config.cson: specifies what version of core and admin to use, dependencies, page types, regions, and other package information
- schema: schema information for the pages, regions, and site design. style.cson provides variables that will be accessible in your style sheets
- templates: provides the html templates for pages and regions
- presenters: provides application logic for pages and regions
- style: stylus files for styling the site. variables.styl provides global styling variables and functions

### How to get your own site from this package
Want your own site running on this package?
1. Install the dobi command line tools:  `npm install -g dobi` 
2. Clone this site to your own: `dobi clone info2 your-new-site`
3. Load your site at http://www.maestro.io/your-new-site

### How to develop 
1. `cd` to the directory where you have this repo stored locally
2. `dobi run` to start a dev server
3. load your site at http://www.maestro.io/your-new-site?dev=1

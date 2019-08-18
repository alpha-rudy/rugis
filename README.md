# rugis
Rudy's GIS tools collection

Upstream Links:
* Docker Registry @ rudychung/rugis
* GitHub @ alpha-rudy/rugis

## Quick Start

* Create a directory for data volume. Let's say gis-works.

      mkdir gis-works
      cd gis-works
    
* Run the container

      docker run -v $(pwd):/mnt/data \
        -it --name rugis
        rudychung/rugis

* And then next time, simply start it

      docker start -i rugis

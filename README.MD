Code review notes:


Fixed crash as soon as the app runs, by correcting the cell reuse identifier.

Demonstrated knowledge of swift by adding a 'CakeManager' to download and parse JSON cake data.

Added a 'Cake' class to store the cake data.

Improved the loading of the table, by making the cake download asyncronous.

Added a basic image cache. This could be put in a UIImageView extension and dedicate image cache in a larger project, but felt it wasn't required for this demo.

Introduced a refresh of data on pull to refresh.

Added constraints to cell, so all data is readable.

Added a constants file for URL definitions.

Added basic unit tests


# ios-favorite-movies
A sample application to find and save a list of your favorite movies

## Prerequisites
1. MacOS (10.11.x or above)
2. Xcode 8.1

## Quick Start
1. Clone the repo and go to that directory
    ```bash
    git clone https://github.com/clarkio/ios-favorite-movies.git
    cd ios-favorite-movies
    ```

2. Open the project in Xcode
    ```bash
    open Favorite\ Movies/Favorite\ Movies.xcodeproj/
    ```
3. Select iPhone 7 for the simulator
4. Run the project by pressing CMD + R or clicking the Play button

## Main View
This view shows the list of the favorite movies. It uses a table view with a custom cell to show the favorite movies on the screen. The custom cell provides an ImageView to show the movie poster, a label for the movie title and a label for the year the movie was released. Lastly, it shows a "Find Movies" button which navigates to the Search View

## Search View
This view provides a way to search for movies to add to the favorites list. It uses a text field, button and table view with a custom cell to provide the search results. The custom cell is slightly different from the main view as it includes a "Fav" button that handles adding that movie to the main favorites list.

## Detail View
This view wasn't covered in the video, but is an example of performing an action when a table cell is selected. Within the main view's table view each table cell is selectable. When the cell is selected this triggers navigation to the Detail View. The Detail View shows the movie title along with the plot which is retrieved from the OMDb API.

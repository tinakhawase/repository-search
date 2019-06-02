# repository-search
This app will search for the GitHub repositories and display the details including:
 - Protocol based approach
 - MVVM architecture
 - Basic unit tests

## How it works?
- This app is making use of the API v3 of the Github, to seach the repository (https://developer.github.com/v3/search/)
- The input needs to be passed in the following format:
  ```
    SEARCH_KEYWORD_1+SEARCH_KEYWORD_N+QUALIFIER_1+QUALIFIER_N
  ```
- Once the results are displayed, you can further select the item from the table which will take you to the details page of the repository, which includes following 
  - name of repository
  - count of subscribers
  - list of subscribers 
  
## Future scope and improvements
- Better UI and UX
- More Unit tests
- Failure scenario handling

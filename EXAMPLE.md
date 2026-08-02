Review session output:

1. Fix null pointer exception in UserService.getProfile() when session token expires
2. Patch memory leak in WebSocket connection pool during reconnect loops
3. Correct off-by-one error in pagination logic on /api/orders endpoint
4. Escape user input in search query builder to close SQL injection vector
5. Resolve race condition in cache invalidation between worker threads
6. Update deprecated moment.js calls to native Intl.DateTimeFormat
7. Fix broken retry backoff — was retrying every 0ms instead of exponentially
8. Remove hardcoded staging URL from production build config
9. Add missing await in payment webhook handler causing silent failures

Issues: hard for me to work through all of them if I have questions / fixes for them 


Solution: Split down smaller into a back and forth interactive session


Starting a review session -> This could be a question to the user maybe?  The response is I have found 9 items would you like them as a list or begin a review session of the output? There is a lot of value in ensuring I understand
what is being reviewed and validate all the pieces with my adhd it can be difficult so making it more manageable is something I want to explore more!


Review Session: 

AI: 1. Fix null pointer exception in UserService.getProfile() when session token expires this issue is a concern because XYZ...

User: Ah yeah need to clean that up a bit

AI: 2. Patch memory leak in WebSocket connection pool during reconnect loops

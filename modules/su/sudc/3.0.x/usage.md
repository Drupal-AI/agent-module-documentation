<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SearchUnify Drupal Connector (sudc) integrates Drupal with the SearchUnify enterprise/hosted search platform, rendering a SearchUnify-powered results page and proxying queries to the SearchUnify backend.
---
Configured at `/admin/config/sudc` (`administer site configuration`), the module stores SearchUnify credentials — CDN, Provision Key, Endpoint, JWT expiry, and one or more UID/Search-URL pairs. It exposes a dynamic front-end route `/searchunify/{dynamic_path}` that renders the `su_results` template for the matching UID, plus REST endpoints under `/search-unify/v1/`: `searchresultbypost` and `su-gpt` proxy search/GPT requests to SearchUnify using the site's stored access token, and `search_jwt` returns a JWT for the current user. Outbound calls go through a `RestCalls` service that honors an `sslVerify` flag (default TRUE) and obtains an OAuth token from SearchUnify with the Provision Key. The Provision Key and UIDs are validated against SearchUnify when the config form is saved.

Setup: install (pulls `firebase/php-jwt`), enable, then enter CDN/Provision Key/Endpoint and your UID/Search-URL pairs; the front-end page appears at `/searchunify/<search-url>`. Note the `/search-unify/v1/*` endpoints and the results page are gated only by the `access content` permission (granted to anonymous by default) and the JWT/search page expose the SearchUnify access token to the client — review the recorded security observations before exposing this on an anonymous-accessible site.
---
- Render a SearchUnify-powered results page at a configured path.
- Proxy search queries to SearchUnify from the browser.
- Proxy GPT/AI search requests to SearchUnify's mlService.
- Issue a per-user JWT for authenticating to SearchUnify.
- Store SearchUnify CDN, endpoint and provision key in config.
- Map multiple SearchUnify UIDs to Drupal URL paths.
- Validate the provision key and UIDs on save.
- Configure JWT token lifetime (minutes).
- Serve the search UI at `/searchunify/{path}`.
- Post JSON queries to `/search-unify/v1/searchresultbypost`.
- Call `/search-unify/v1/su-gpt` for generative answers.
- Fetch a signed JWT at `/search-unify/v1/search_jwt`.
- Override the `su_results` template in your theme.
- Show the in-module help page at `/admin/config/sudc/help`.
- Obtain an OAuth access token from SearchUnify automatically.
- Toggle SSL verification for local/dev (keep TRUE in prod).
- Embed SearchUnify search into a headless/AJAX front end.
- Support Drupal 9, 10 and 11.
- Pass the current user's id/email/roles into the JWT payload.
- Resolve the active UID from the referring search page URL.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds HTTP OAuth Fetcher adds an OAuth 2.0-enabled HTTP fetcher to Feeds (3.x) that obtains an access token and sends it as an Authorization header when downloading a feed source, with credentials selected from Key entities.

---

Feeds HTTP OAuth Fetcher provides one Feeds fetcher plugin, "Download from url (OAuth 2.0)" (id `http_oauth`), that extends Feeds' core `HttpFetcher`. When a feed runs, the fetcher first POSTs to a per-feed access token URL to obtain an OAuth 2.0 access token, then downloads the feed source with the token in the `Authorization` header. It supports the `client_credentials` and `password` grant types, and for client credentials it can place the client id and secret either in the request body or in an HTTP Basic `Authorization` header. OAuth settings are stored per feed on the feed edit form — access token URL, grant type, credential placement, scope, and the credential fields — while the standard HTTP fetcher options (timeout, always download, caching, conditional requests) are configured on the feed type. Credential fields (client id, client secret, and for the password grant username and password) use the Key module's `key_select` element, so each references a Key entity that is resolved at request time through the key repository. It depends on the Feeds module and the Key module, does not patch Feeds core, and reuses the core fetcher's caching and conditional-request behaviour.

---

- Import feed data from an API that requires OAuth 2.0 authentication.
- Add a Feeds fetcher plugin, "Download from url (OAuth 2.0)".
- Fetch a protected HTTP endpoint on the schedule Feeds already runs.
- Use the OAuth 2.0 `client_credentials` grant to obtain an access token.
- Use the OAuth 2.0 `password` grant to obtain an access token.
- Send the client id and secret in the token request body.
- Send the client id and secret as an HTTP Basic `Authorization` header.
- Attach the obtained token to the feed download as an `Authorization` header.
- Reference the client id from a Key entity via a key-select field.
- Reference the client secret from a Key entity via a key-select field.
- Reference the username and password (password grant) from Key entities.
- Set the OAuth scope requested from the token endpoint.
- Configure the access token URL per individual feed.
- Keep OAuth settings scoped to individual feeds rather than the feed type.
- Reuse the core HTTP fetcher's request timeout and always-download options.
- Keep the core fetcher's response caching for a feed.
- Keep conditional requests (`If-None-Match` / `If-Modified-Since`) on refetch.
- Import content from a SaaS API behind OAuth into Drupal nodes via Feeds.
- Add OAuth-protected fetching without patching or forking Feeds core.
- Choose the fetcher on a feed type at Structure, then configure OAuth per feed.
- Combine OAuth fetching with any Feeds parser and processor.
- Support Drupal 10 and Drupal 11 with Feeds 3.x.

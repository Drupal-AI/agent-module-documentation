<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bitly Links creates Bitly short URLs for your nodes by calling the Bitly v4 API, after an admin authorizes the site's Bitly app through OAuth.

Use it to attach shareable short links to content, for example for social posts.

---

Install with `composer require drupal/bitly_links` and enable it (`drush en bitly_links`).

Register a Bitly OAuth app, enter its client ID/secret and run the authorization flow from the module's admin pages (`/admin/bitly_links/authorize`, `/bitly_links/authorization`). Access tokens and client credentials are stored in Drupal `State`. All module routes require `access administration pages`. Use `/admin/bitly_links/shorten_test` to verify connectivity. API calls go to `https://api-ssl.bitly.com` over HTTPS with Guzzle's default TLS verification.

---

- Generate Bitly short links for nodes.
- Call the Bitly v4 `/v4/shorten` endpoint.
- Authenticate with a Bearer access token from OAuth.
- Provide an admin flow to authorize the Bitly app.
- Exchange the OAuth code for an access token.
- Store client ID, secret and token in Drupal State.
- Offer a settings form for node integration options.
- Provide an access-status page to check the current token.
- Provide a shorten-test page to verify the integration.
- Gate every route behind `access administration pages`.
- Use HTTPS (`api-ssl.bitly.com`) with default TLS verification.
- Log API exceptions to the `bitly_links` channel.
- Support Drupal 9.4 and Drupal 10.
- Group admin pages under `/admin/bitly_links`.
- Keep credentials out of exported configuration (State storage).
- Attach short links to node workflows.
- Serve as a focused Bitly integration.
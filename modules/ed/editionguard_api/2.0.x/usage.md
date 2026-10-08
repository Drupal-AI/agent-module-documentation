<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EditionGuard API provides a Guzzle-based client service (`editionguard_api.client`) that talks to the hosted EditionGuard v2 ebook-DRM/fulfilment REST API through a set of endpoint plugins.
---
The module solves the problem of integrating a Drupal store or library with EditionGuard's DRM ebook platform without hand-writing HTTP calls. Each API operation (list/get/create/update/replace/delete books, master links, transactions, download lists, deliver book links) is a plugin under `Plugin/EditionGuardApi/Endpoint/`, discovered by `editionguard_api.endpoint_plugin_manager`. The client authenticates by POSTing the admin-configured `oauth_email` / `oauth_password` to `https://app.editionguard.com/api/v2/obtain-auth-token`, caching the returned token in `cache.default` until `token_expire`, and sending it as an `Authorization: Token <token>` header. Book create/update/replace switch to multipart uploads (streaming the `resource` file). All traffic is HTTPS with Guzzle's default certificate verification (TLS is not disabled).

Operationally the credentials live in `editionguard_api.settings` config (email + password in plaintext config), so treat exported config as sensitive. The three routes (settings, test, endpoint test) are all gated by `administer site configuration`; there are no anonymous or front-end endpoints. Typical setup: enter EditionGuard credentials on the settings form, enable logging while integrating, then call `\Drupal::service('editionguard_api.client')->request($endpoint, $query, $form)` from your own code.
---
- Enter EditionGuard OAuth email/password at /admin/config/services/editionguard-api.
- Toggle request/response logging while debugging an integration.
- Set the cached token lifespan via `token_expire`.
- Obtain the client service `editionguard_api.client` in custom code.
- List all books in the EditionGuard account (book_list endpoint).
- Fetch a single book's metadata (book_get).
- Create a new DRM book, uploading the ebook file as multipart (book_create).
- Update or replace an existing book's file/metadata (book_update, book_replace).
- Delete a book (book_delete).
- List, get, create or delete transactions (transaction_* endpoints).
- List and get master links (master_link_* endpoints).
- Generate reader/download links for a book (book_generate_links).
- Deliver a single or multiple book links to a reader (deliver_book_link(s)).
- Retrieve the download list for fulfilment (download_list).
- Instantiate an endpoint plugin via the endpoint plugin manager.
- Pass query and form params to `request()` for any endpoint.
- Exercise any endpoint interactively from the Test form.
- Inspect a specific endpoint's parameters via the Endpoint Test form.
- Cache OAuth tokens across requests to avoid re-authenticating each call.
- Wrap the client in your own service for order fulfilment / entitlement checks.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an OAuth2 (bearer-token) authentication provider plugin for the API Sync suite, backed by the oauth2_client module.

---

`apisync_oauth` registers the `apisync_oauth` API Sync auth provider plugin (`ApiSyncOAuthPlugin`). It is a token-based provider: it does not implement the OAuth exchange itself but delegates to the contrib `oauth2_client` module's `oauth2_client.service`, selecting a configured `oauth2_client` client entity by id. On each OData request it adds an `Authorization: Bearer <token>` header, fetching or refreshing the token through the client service (client-credentials style). Enable it when the remote OData / REST service authenticates with OAuth2. Configure the OAuth2 client (endpoints, client id/secret — the secret is held by `oauth2_client`, which supports the Key module) first, then select that client on the API Sync authorization form.

---

- Authenticate the OData client to a remote API with OAuth2 bearer tokens.
- Reuse an existing `oauth2_client` client entity for token acquisition.
- Add `Authorization: Bearer` headers to every API Sync request.
- Refresh/re-fetch tokens automatically on 401/403 (via the OData client retry path).
- Keep the client secret out of API Sync config (managed by `oauth2_client` / Key).
- Provide the `oAuth2 Authentication` option on the authorization provider selector.
- Validate the chosen client by fetching a live token when the auth config is saved.
- Pair with `apisync_pull` / `apisync_push` for authenticated sync.

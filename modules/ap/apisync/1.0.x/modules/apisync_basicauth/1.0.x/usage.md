<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an HTTP Basic Authentication provider plugin for the API Sync suite.

---

`apisync_basicauth` registers the `basic_auth` API Sync auth provider plugin (`ApiSyncBasicAuthPlugin`, id `basic_auth`). It is a non-token provider: on each OData request it adds an `Authorization: Basic <base64(user:password)>` header from the username and password entered in the `apisync_auth` config entity's provider settings. Enable it when the remote OData / REST service accepts HTTP Basic credentials rather than OAuth. Configure the credentials on the API Sync authorization form (`/admin/config/apisync/authorize`), and set the instance URL to an HTTPS endpoint so credentials are protected in transit.

---

- Authenticate the OData client to a remote API using HTTP Basic auth.
- Provide the `basic_auth` option on the API Sync authorization provider selector.
- Send `Authorization: Basic` headers built from a configured username/password.
- Integrate Drupal with OData services that require username/password credentials.
- Serve as the default auth provider (`apisync_auth` defaults `provider = basic_auth`).
- Use a simple credential model where OAuth is unavailable.
- Pair with `apisync_pull` / `apisync_push` for authenticated sync.
- Act as a reference implementation for a non-token auth provider plugin.

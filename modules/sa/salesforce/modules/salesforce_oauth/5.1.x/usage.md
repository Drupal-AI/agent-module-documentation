Salesforce OAuth user-agent Provider adds interactive OAuth authentication to the Salesforce suite: you authorize Drupal against a Salesforce connected app via the browser and store the resulting token.

---

The module registers an `oauth` `@SalesforceAuthProvider` plugin (`SalesforceOAuthPlugin`) selectable when creating a `salesforce_auth` config entity (route `salesforce.auth_config`). An OAuth authorization stores `consumer_key`, `consumer_secret` and `login_url` in the auth entity's `provider_settings`, and completing it walks the OAuth user-agent flow through a callback route (`salesforce.oauth_callback`) to obtain and store an access/refresh token (via `salesforce.auth_token_storage`, backed by State). Which authorization the client uses by default is `salesforce.settings.salesforce_auth_provider`. Compared with the JWT provider, this method involves an interactive login (good for admins authorizing a connection), whereas JWT is unattended/server-to-server. Actually completing the flow requires the external Salesforce org and a browser; selecting the default provider is local config. Depends on `salesforce`.

---

- Authorize Drupal to Salesforce through an interactive OAuth login.
- Configure a connected app's consumer key and secret for OAuth.
- Point an authorization at production or a sandbox via login_url.
- Store and refresh OAuth access/refresh tokens automatically.
- Let an admin click through the Salesforce OAuth consent screen.
- Set an OAuth authorization as the suite's default provider.
- Maintain multiple OAuth authorizations for different orgs.
- Refresh or revoke the OAuth token via Drush (salesforce:refresh-token / revoke-token).
- Use OAuth when a browser-based authorization is preferred over JWT.
- Provide auth for push/pull sync using a user-agent token.
- Re-authorize after a secret rotation.
- Switch the default authorization between OAuth and JWT.
- Keep consumer secret in config for the connected app.
- Handle the OAuth callback route to complete authorization.
- Authorize as the logged-in Salesforce user.
- Use the standard Salesforce auth UI to add an OAuth connection.
- Support GovCloud/production/sandbox endpoints via login_url.
- Recover a broken connection by re-running the OAuth flow.
- Combine with logger to record auth events.
- Choose OAuth for simpler setups without managing a private key.

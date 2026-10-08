Salesforce JWT Auth Provider adds key-based (JWT bearer) Salesforce authentication: a server-to-server auth method that signs a JWT with a private key stored via the Key module, needing no interactive OAuth login.

---

The module registers two `@SalesforceAuthProvider` plugins — `jwt` (`SalesforceJWTPlugin`) and `jwt_govcloud` (`SalesforceJWTGovCloudPlugin`) — selectable when creating a `salesforce_auth` config entity (route `salesforce.auth_config`). A JWT authorization stores its settings in the auth entity's `provider_settings`: `login_url` (e.g. `https://login.salesforce.com` for production or `https://test.salesforce.com` for a sandbox), `consumer_key` (the connected app's consumer key), a `username` to impersonate, and `encrypt_key` — the id of a **Key module** entity holding the private key used to sign the JWT assertion. Because it uses a signed assertion rather than a user login, it is ideal for headless/cron sync. Completing a live authorization exchanges the signed JWT for a token from Salesforce (which needs the external org), but the auth config entity and its settings are local. Depends on `salesforce` and `key`.

---

- Authenticate Drupal to Salesforce without an interactive OAuth login.
- Use a private key (via the Key module) to sign a JWT bearer assertion.
- Run unattended cron push/pull with server-to-server auth.
- Connect to a Salesforce sandbox (login_url https://test.salesforce.com).
- Connect to production (login_url https://login.salesforce.com).
- Authenticate to a Salesforce GovCloud org (jwt_govcloud provider).
- Impersonate a specific Salesforce username for the integration.
- Store the signing private key securely as a Key entity.
- Configure the connected app's consumer key for the JWT flow.
- Avoid storing/refreshing OAuth refresh tokens.
- Set up multiple JWT authorizations for different orgs.
- Make one JWT authorization the default provider for the suite.
- Rotate the signing key by updating the referenced Key entity.
- Provide auth for headless/decoupled Drupal-Salesforce sync.
- Keep credentials out of code by referencing a Key entity.
- Use JWT auth in CI/deployment where no browser is available.
- Pair with salesforce_push/pull for automated sync.
- Switch environments by changing login_url per authorization.
- Authorize via signed assertion suitable for service accounts.
- Configure through the shared Salesforce auth UI (salesforce.auth_config).

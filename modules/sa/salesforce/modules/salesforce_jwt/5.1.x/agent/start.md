# Salesforce JWT Auth Provider — agent index

Key-based (JWT bearer) Salesforce authentication — server-to-server, no interactive login.
Provides two auth-provider plugins used by a `salesforce_auth` config entity. Depends on
`salesforce`, `key`. Configure via the shared route `salesforce.auth_config`.

- **Set up a JWT authorization (provider settings, the Key)** →
  [configure/jwt.md](configure/jwt.md)

Key facts:
- Auth-provider plugin ids: `jwt` (`SalesforceJWTPlugin`), `jwt_govcloud`
  (`SalesforceJWTGovCloudPlugin`) — see the base module's `plugins/auth-providers.md`.
- Each JWT authorization is a `salesforce_auth` config entity with `provider` = `jwt` (or
  `jwt_govcloud`) and `provider_settings`:
  - `login_url` — `https://login.salesforce.com` (prod) or `https://test.salesforce.com` (sandbox)
  - `consumer_key` — connected app consumer key
  - `username` — Salesforce user to impersonate
  - `encrypt_key` — id of a **Key** entity holding the private key that signs the JWT
- The auth config entity is local; completing the token exchange needs the Salesforce org.
- Make it the suite default via `salesforce.settings.salesforce_auth_provider`.

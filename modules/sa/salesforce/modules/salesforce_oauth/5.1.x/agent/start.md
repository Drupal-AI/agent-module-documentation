# Salesforce OAuth user-agent Provider — agent index

Interactive OAuth (user-agent) Salesforce authentication. Provides the `oauth`
`@SalesforceAuthProvider` plugin used by a `salesforce_auth` config entity; completing it
walks the browser OAuth flow via `salesforce.oauth_callback`. Depends on `salesforce`.
Configure via the shared route `salesforce.auth_config`.

- **Setup & the default-provider setting** →
  [configure/oauth.md](configure/oauth.md)

Key facts:
- Auth-provider plugin id: `oauth` (`SalesforceOAuthPlugin`) — see base module
  `plugins/auth-providers.md`.
- An OAuth authorization is a `salesforce_auth` config entity (`provider` = `oauth`) with
  `provider_settings`: `consumer_key`, `consumer_secret`, `login_url`.
- Tokens are stored via `salesforce.auth_token_storage` (State); the callback route is
  `salesforce.oauth_callback`.
- The suite's default authorization is `salesforce.settings.salesforce_auth_provider`.
- Completing the OAuth flow needs the external org + a browser; **selecting the default
  provider is local config** — that is what the eval cases exercise.
- Drush: `salesforce:refresh-token` / `salesforce:revoke-token` manage the stored token.

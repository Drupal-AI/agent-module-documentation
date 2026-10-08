# Simple OAuth Password Grant — agent index

Adds the OAuth2 **password grant** (id `password`) to Simple OAuth. A trusted first-party client
exchanges a Drupal username/email + password for an access token at `/oauth/token`. Depends on
`simple_oauth`. No admin settings page (`configure: null`), no permissions, no Drush. Only config
schema: `grant_type.password`.

> Security: the password grant is discouraged by OAuth2 Best Practices. Use only for trusted,
> secure, first-party apps; prefer Authorization Code where possible.

- **Enable the grant on a Consumer & request a token (the `grant_types` field, the token request)** →
  [configure/enable-grant.md](configure/enable-grant.md)
- **The `password` Oauth2Grant plugin (how the grant is built, refresh token TTL)** →
  [plugins/password-grant.md](plugins/password-grant.md)
- **The user repository: credential check, username-or-email, flood protection** →
  [api/user-repository.md](api/user-repository.md)

Key facts: plugin id `password` (`…\Plugin\Oauth2Grant\Password`); the grant is turned on per
`consumer` entity via its `grant_types` field (value `password`); service
`simple_oauth_password_grant.repositories.user`; flood events
`oauth2_password_grant.failed_login_ip` / `…failed_login_user` using `user.flood` config;
consumer form gains a "Default scopes" section.

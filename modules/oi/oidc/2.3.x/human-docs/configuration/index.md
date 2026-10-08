# Configuration

You configure OpenID Connect Client by creating one or more **realms** — one per
identity provider. Each realm is a plugin; the module ships a generic realm you can
set up entirely from the admin interface, and developers can write their own realm
plugins if a provider needs special handling.

## Open the realm administration

Log in as a user with the **Administer OIDC** permission (a restricted permission, so
grant it only to trusted administrators), then open the OIDC realm administration in
the admin interface.

## Configure a generic realm

For the generic realm you'll typically provide:

- **The provider connection** — the issuer / discovery details and endpoints of your
  identity provider (Keycloak, Entra ID, Okta, Auth0, Google, and so on).
- **Client ID and client secret** — the credentials your identity provider issues
  for this Drupal application (see *Storing the client secret* below).
- **Username format** — how new Drupal usernames are derived from the provider's
  claims.
- **Default role** — a role automatically assigned to newly created users.

Save the realm. Its login route is then `/oidc/login/{realm}`. You can optionally
redirect `/user/login` to a realm (or a custom page) so users don't accidentally end
up on Drupal's default login form.

## The decisions that matter most

Three project decisions shape the configuration more than any single field — settle
them deliberately:

1. **Existing local accounts** with matching email addresses — decide whether they
   are linked to the identity provider or refused. Account linking is handled through
   the External Authentication layer this module depends on.
2. **Role derivation** — the default role and any claim‑to‑role mapping decide who
   becomes an administrator. Keep it conservative; a permissive mapping over‑grants,
   and you need to know what happens when a provider claim changes.
3. **Local password login** — decide whether Drupal's own login stays enabled as a
   fallback (still an attack surface) or is closed off once SSO works.

## Storing the client secret

The client secret is a credential — treat it like one:

- With DDEV, keep it out of version control in an environment variable:
  `ddev dotenv set .ddev/.env --oidc-client-secret=<value>` (never commit
  `.ddev/.env`), then `ddev restart`.
- Prefer supplying it through the [Key](https://www.drupal.org/project/key) module or
  a settings override rather than committing it to exported configuration.

## Security posture

- **State/nonce (login CSRF).** Protection against login CSRF and token replay comes
  from the standard OpenID Connect `state` and `nonce` checks, which this OIDC layer
  provides as part of the protocol flow — leave them in force.
- **TLS on the provider connection.** OpenID Connect relies on HTTPS between Drupal
  and the identity provider; always use `https://` issuer/endpoint URLs so tokens are
  exchanged over verified transport.

(The agent docs for this module focus on the SSO decisions above and the `gmp`
requirement; where they don't speak to a specific implementation detail, this guide
does not assume one.)

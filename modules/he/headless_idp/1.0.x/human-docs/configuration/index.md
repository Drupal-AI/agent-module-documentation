# Configuration

Configuring Headless IdP means telling Drupal which external identity provider to
trust and exactly how to verify the tokens it issues. Getting the trust model
right is the whole point of the module, so work through it carefully.

## The trust model in plain terms

Drupal does not authenticate the password itself — the **provider** does. Your
front end signs the user in against the IdP and gets a JWT; Drupal's job is to
decide whether to trust that token. It does so by:

- **Verifying the JWT signature** against the provider's published keys (JWKS), so
  a token that wasn't signed by your provider is rejected.
- **Pinning the issuer and audience**, so a validly-signed token minted for a
  *different* application or tenant is rejected.
- **Rejecting algorithm confusion**, so an attacker can't downgrade or swap the
  signing algorithm.
- **Linking** the verified identity to a Drupal user through the External
  Authentication module.

Only after all of that does Drupal treat the request as authenticated.

## Choose and configure a provider

Pick the provider your organisation uses — **AWS Cognito**, **Okta**, **Entra
ID** (workforce), or **Entra External ID** (customer/CIAM). For the chosen
provider you'll supply the connection details it needs so Drupal can find the
JWKS and validate tokens — typically the issuer URL, the audience/client
identifier, and the provider's user-pool or tenant details. Each provider
declares which capabilities it supports (password sign-in, MFA, migration, and so
on) and the module adapts to what that provider offers. If you need a provider
that isn't bundled, the plugin API lets you add one without disturbing the
existing ones.

## Handle secrets safely

Any client secret or API credential the provider requires must be treated as
sensitive:

- **Never hard-code or commit** provider secrets — keep them out of exported
  config and version control.
- **Store them in environment variables.** With DDEV, use the built-in dotenv
  command and restart so the container loads them:

  ```bash
  ddev dotenv set .ddev/.env --idp-client-secret=<value>
  ddev restart
  ```

  Reference the variable from your provider configuration rather than typing the
  secret inline.
- **Always use HTTPS** for the issuer/JWKS endpoints and for your own auth API.

Note that the *issuer URL*, *audience*, and *JWKS URL* are not secrets — they are
public trust anchors — but the values must be exactly correct, because they are
what stop a wrong-audience or wrong-issuer token from being accepted.

## Built-in protections you should keep on

The module applies brute-force / flood protection per user, per IP, and per
session (mirroring Drupal core's `user.flood` defaults), returns **generic
errors** so attackers can't tell whether an account exists, and enforces a
configurable **password-complexity policy** with length caps. Leave these enabled
and tune the flood thresholds and password policy to your needs rather than
switching them off.

## Legacy password migration

If you are moving an existing Drupal user pool onto the IdP, note that hashed
passwords cannot be bulk-migrated (hashes are one-way). The module handles this
**lazily and only after proof**: a legacy password is migrated to the IdP the
next time the user logs in, and only once that legacy password has actually been
verified. There is also a Drush command to migrate from `openid_connect`.

## Operator tooling

Drush commands let you inspect the configured providers, manage the Drupal-to-IdP
account links, run migrations, and manage MFA preferences — useful for
troubleshooting a user who can't sign in or confirming which provider is active.

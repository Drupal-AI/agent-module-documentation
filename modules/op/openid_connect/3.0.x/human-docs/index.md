# OpenID Connect — manual setup guide

**OpenID Connect** (`openid_connect`) is a pluggable OpenID Connect / OAuth 2.0
*client* (relying party) for Drupal. It lets an external identity provider — Google,
Okta, GitHub, Facebook, LinkedIn, or any generic OIDC-compliant server such as Azure
AD, Auth0, or Keycloak — authenticate people and log them into your Drupal site.
This is how you add "Sign in with Google" or single sign-on (SSO) against your
organization's identity provider.

Each provider you support is an **OpenID Connect client** configuration entity that
you create at **Configuration → People → OpenID Connect clients**. Each client
references a client *plugin* (`generic`, `google`, `okta`, `github`, `facebook`, or
`linkedin`) and stores its client ID, client secret, and endpoint details. When
someone logs in, the module redirects them to the provider, receives them back at
`/openid-connect/{client}`, exchanges the authorization code for tokens and profile
data, and then matches, connects, or creates a Drupal account — mapping the
provider's OIDC claims (name, email, picture, and so on) onto Drupal user fields.
The Generic client can even auto-discover a provider's endpoints from its
`.well-known` issuer URL.

Beyond the per-provider clients, a global settings form controls site-wide behavior:
auto-connecting existing users by email, re-saving profile data on every login,
propagating logout back to the provider, showing providers on the core login form,
and more. A "Sign in with" block and a per-user "Connected Accounts" form round out
the experience, and role mappings can grant Drupal roles from provider data.

The module depends on core's **File** module and the contrib **External
Authentication** (`externalauth`) module, and needs PHP 8.1+. **Note:** the 3.0.x
branch is an **alpha** release (`3.0.0-alpha8`), so test carefully before relying on
it in production. This guide is written for a **human** clicking through the admin
UI; if you want terse, token-cheap references for an AI coding agent — including the
login flow, services, and extension hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and External
   Authentication with Composer, then enable it.
2. [Configuration](configuration/index.md) — add an identity provider client, set
   the redirect URI, and tune the global login behavior.

## Where it lives in the admin menu

Everything sits under **Configuration → People → OpenID Connect clients**
(`/admin/config/people/openid-connect`): this is the list of provider clients and
the entry point for adding one. A **Settings** tab on that page
(`/admin/config/people/openid-connect/settings`) holds the site-wide options. Both
are gated by the **Administer OpenID Connect clients** permission. Users manage their
own linked providers at **My account → Connected Accounts**
(`/user/{user}/connected-accounts`), governed by separate per-user permissions.

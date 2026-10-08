# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An external **Identity Provider** (Keycloak, Microsoft Entra/Azure AD, Okta,
  Auth0, Google, etc.) where you can register an OAuth/OIDC application and get a
  client ID and secret.
- No third-party Composer or PHP library requirements — the module bundles its
  own JWT/RSA helper for OpenID id-token handling.

For creating **new** Drupal accounts from IdP logins, using a non-email login
attribute, or role/group/profile mapping, you also need a **paid miniOrange
license**. The free build logs in existing, email-matched users only.

## Install with Composer

From the project root:

```bash
composer require drupal/miniorange_oauth_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/miniorange_oauth_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en miniorange_oauth_client -y
```

## Grant the permission

All of the module's admin screens are gated by the **miniOrange Administrator
Privilege** (`mo_administrator`) permission. Assign it — at
*People → Permissions* — only to trusted administrator roles, since it exposes
IdP client credentials and controls site-wide authentication.

## Keep the client secret out of version control

Your IdP **client secret** is sensitive. Rather than committing it, store it in
an environment variable and reference it from configuration. With DDEV you can
save it into the container's dotenv file:

```bash
ddev dotenv set .ddev/.env --mo-oauth-client-secret='<your-client-secret>'
ddev restart
```

Then paste the value into the connection form once, or reference the environment
variable via a config override in `settings.php` for the relevant config entity.
Never hard-code or commit the secret. Once installed, continue to
[Configuration](../configuration/index.md).

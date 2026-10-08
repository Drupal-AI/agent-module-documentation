# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **External Authentication** module (`drupal/externalauth` `^1.3 || ^2.0.7`) —
  it stores the link between a SAML login and a Drupal account. Composer installs it
  automatically as a dependency.
- The **OneLogin php‑saml** PHP library (`onelogin/php-saml` `^3.8.1 || ^4.3.1`),
  which does the actual SAML message signing and validation. Composer installs it
  for you.

Optional but recommended companions:

- **Key** (`drupal/key`) — store the SP private key/certificate safely (for example
  from an environment variable) instead of in plain configuration.
- **Flood Control** (`drupal/flood_control`) — an admin UI over the failed‑login
  flood protection.
- **Views** (`drupal/views`, in core) — gives you an admin list of the SAML ↔ user
  links with a delete UI.

## Install with Composer

From the project root:

```bash
composer require drupal/samlauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in External
Authentication and the php‑saml library along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/samlauth -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en samlauth -y
```

Drupal enables External Authentication automatically as a dependency. Once enabled,
head to [Configuration](../configuration/index.md) — SAML login will not work until
you fill in the SP and IdP details.

## Submodules — enable only what you need

SAML Authentication ships two optional submodules that extend how SAML attributes
map onto Drupal accounts. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **User Fields** | `samlauth_user_fields` | Map arbitrary SAML attributes onto Drupal user profile fields. |
| **User Roles** | `samlauth_user_roles` | Grant or revoke Drupal roles based on SAML attribute or group values, either on every login or only on the first login. |

For example, to add attribute‑to‑role mapping:

```bash
drush en samlauth_user_roles -y
```

Each submodule requires the base SAML Authentication module, which is already
present once you've installed it above.

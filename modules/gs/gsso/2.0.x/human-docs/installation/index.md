# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Group** module (`group`). Version 2 of Group SSO targets version 2 of the
  Group module — match the major versions.
- **SimpleSAMLphp Authentication** installed and configured as the actual login
  provider. Group SSO plugs into its login flow but does not authenticate on its
  own, so nothing happens until SimpleSAMLphp is doing the sign‑in.

Note: this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/gsso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Group module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gsso -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gsso -y
```

## Set up Group first

Before Group SSO can do anything useful, configure Group the way you normally
would: create your **group types**, decide what **group content** they hold, and
define the **group roles** you want to assign. Group SSO maps IdP claims onto
these existing roles and groups, so they need to exist before you build the
mapping matrix.

## Verify it worked

Go to **`/admin/group/sso`** as a user with the **Administer group** permission.
If the settings form loads, the module is installed and ready to configure. A full
end‑to‑end check requires a SAML login: after configuring the mapping, sign in
through your IdP and confirm the expected roles and Group memberships appear on
the account.

# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **SAML Authentication** module (`samlauth`) — a hard dependency. This
  module extends samlauth and reuses its metadata, SSO, SLO and ACS endpoints, so
  samlauth must be present and working.

There are no additional PHP or third‑party library requirements. This release is
an early (alpha) version — read the project's README before deploying it to
production.

## Install with Composer

From the project root:

```bash
composer require drupal/samlauth_multi_idp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `samlauth` and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/samlauth_multi_idp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en samlauth_multi_idp -y
```

On installation a **default IdP** is set up automatically. If you already had an
IdP configured in `samlauth`, it is imported as that default.

## Verify it worked

Go to **`/admin/config/people/saml/idp`**. You should see the default IdP listed.
From here you can add more providers and enable their login links — see
[Configuration](../configuration/index.md).

# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other Drupal module dependencies and no special PHP libraries.
- A registered **GSIS OAuth 2 service** — you need a consumer **ID** and
  **secret** issued by GSIS, plus the allowed redirect URL configured on the GSIS
  side (for example `https://www.example.com/gsis`). You can obtain these by
  registering your service with GSIS.

## Install with Composer

From the project root:

```bash
composer require drupal/gsislogin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gsislogin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gsislogin -y
```

Enabling the module adds the GSIS user fields to your user accounts:
`field_gsis_userid`, `field_gsis_taxid`, `field_gsis_firstname`,
`field_gsis_lastname`, `field_gsis_fathername`, `field_gsis_mothername`, and
`field_gsis_birthyear`.

> **Caution:** these fields (and their data) are **removed if you later uninstall
> the module**. Export or back up any values you need to keep before uninstalling.

## Verify it worked

Log in as an administrator and go to **Configuration → People → GSIS OAuth2
Login** (`/admin/config/people/gsislogin`). If the form loads, the module is
installed. After you enter your GSIS credentials there (see
[Configuration](../configuration/index.md)), visit `/gsis/login` and confirm the
"Login with GSIS" option appears.

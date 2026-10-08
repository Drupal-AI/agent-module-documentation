# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **SAML Authentication** module (`samlauth`), configured against your
  identity provider — a hard dependency, since this module inspects the OU
  attribute in the SAML assertions samlauth processes.

There are no additional PHP or third‑party library requirements. Note this
project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/samlauth_restrict_to_ou -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `samlauth` and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/samlauth_restrict_to_ou -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en samlauth_restrict_to_ou -y
```

## Verify it worked

Go to **`/admin/config/people/saml-restrict`** and confirm the restriction
settings form appears. The restriction is not enforced until you turn on the
master toggle and fill in your allowed OUs — see
[Configuration](../configuration/index.md).

# Installation

## Requirements

- **Drupal 10.6+ or 11.2+** (`core_version_requirement: ^10.6||^11.2`).
- Drupal core's **JSON:API** module (`jsonapi`) enabled — this is a hard
  dependency and is what the module hardens.
- For two-factor integration only: the contributed **TFA** module, if you plan to
  enable the `jsonapi_security_tfa` submodule.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_security -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_security -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_security -y
```

Drupal will enable core JSON:API automatically as a dependency if it is not on
already.

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Two-Factor Authentication integration** | `jsonapi_security_tfa` | Requires users to have TFA enabled before they can access or modify data through JSON:API. Requires the contributed **TFA** module. |

Enable it separately once TFA is installed:

```bash
drush en jsonapi_security_tfa -y
```

> **Heads up:** once the TFA submodule is on, users who have not yet set up TFA
> will be affected. Roll it out deliberately and make sure your users can enrol
> before you enforce it.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep jsonapi_security
```

Then open [Configuration](../configuration/index.md) to set the policy switches
(query depth, collection access, read-only mode) to match your site's exposure.

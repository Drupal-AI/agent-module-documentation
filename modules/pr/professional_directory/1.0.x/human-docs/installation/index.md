# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **File** (`file`) and **Link** (`link`) modules — enabled automatically
  as dependencies.
- No external service is required.

### Recommended

- A **CAPTCHA-compatible** module to protect the public registration form from
  spam and bots.
- The **`chillerlan/php-qrcode`** library if you want phone QR codes generated.

## Install with Composer

From the project root:

```bash
composer require drupal/professional_directory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the File and Link
dependencies (and any shared dependencies) at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/professional_directory -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en professional_directory -y
```

Drupal enables `file` and `link` at the same time if they aren't already on.

## Next steps

Head to [Configuration](../configuration/index.md) to set the directory name,
categories, registration window, and notification emails, and to grant the
private-area permission to your member role.

## Verify it worked

Visit `/professional-directory/signup` — the public application form should load.
Submit a test application, then confirm it appears (unvalidated) at
`/admin/content/professional-directory`, where you can validate or reject it.

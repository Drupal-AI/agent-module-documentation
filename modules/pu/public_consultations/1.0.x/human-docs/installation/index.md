# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Webform** (`webform`) — and Webform UI, so you can build the forms.
- **Pathauto** (`pathauto`) — for clean, automatic URLs on consultation pages.

Composer pulls in Webform and Pathauto automatically when you require the module
with the `-W` flag below. Note that this module has *not-covered* security
advisory coverage, so review it against your own security policy before using it
on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/public_consultations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Webform and Pathauto dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/public_consultations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en public_consultations -y
```

Drupal will enable Webform and Pathauto at the same time if they aren't already
on.

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Demo content** | `public_consultations_demo_content` | Creates sample public consultations so you can explore the feature and see how a fully configured consultation looks. Use it on a development or trial site, not in production. |

Enable it if you want the demo material:

```bash
drush en public_consultations_demo_content -y
```

## Verify it worked

Log in as an administrator and go to **Content → Add content**. You should see a
**Public Consultation** option in the list of content types. You can also visit
**Configuration → Content → Public Consultations settings** to confirm the
module's settings page is available. From there, see
[Configuration](../configuration/index.md) to set everything up.

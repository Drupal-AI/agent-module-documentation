# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Your **own mosparo installation**, with a **project** set up in it (mosparo is
  self-hosted; the module connects to it).
- For the submodules: the matching form system —
  the **[CAPTCHA](https://www.drupal.org/project/captcha)** module for
  `mosparo_captcha`, core **Contact** for `mosparo_contact`, and the
  **[Webform](https://www.drupal.org/project/webform)** module for
  `mosparo_webform`.

There are no third-party PHP library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/mosparo_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mosparo_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module plus the submodule(s) for the forms you want to protect:

```bash
# Base module:
drush en mosparo_integration -y

# Then one or more of:
drush en mosparo_captcha -y     # via the CAPTCHA module
drush en mosparo_contact -y     # core Contact forms
drush en mosparo_webform -y     # Webform forms
```

## Submodules

| Submodule | Machine name | Protects |
|-----------|--------------|----------|
| CAPTCHA integration | `mosparo_captcha` | Any form the CAPTCHA module covers (requires the CAPTCHA module) |
| Contact | `mosparo_contact` | Core Contact forms |
| Webform | `mosparo_webform` | Webform forms (requires the Webform module) |

Each submodule requires the base `mosparo_integration` module.

## Verify it worked

Confirm the module (and chosen submodules) are enabled:

```bash
drush pm:list --status=enabled | grep mosparo
```

Then complete the connection setup in [Configuration](../configuration/index.md),
apply protection to a form, and submit that form as an anonymous visitor to
confirm the mosparo box appears and legitimate submissions go through.

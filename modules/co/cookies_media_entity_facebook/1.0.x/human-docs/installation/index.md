# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **COOKiES** consent‑management module (`cookies`).
- The **Media Entity Facebook** module (`media_entity_facebook`), version **4.0.0 or
  later**.

Both dependencies are pulled in by Composer/Drupal when you install this module.
There are no additional third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookies_media_entity_facebook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in COOKiES and Media
Entity Facebook and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookies_media_entity_facebook -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookies_media_entity_facebook -y
```

This also enables **COOKiES** and **Media Entity Facebook** if they are not already
on.

## Verify it worked

Make sure the relevant service is configured in your COOKiES setup, then view a page
containing a Facebook media embed as a visitor who has not consented. The embed
should be withheld and replaced by the COOKiES consent placeholder, and the Facebook
content should load only after consent is given. There is nothing to configure in
this submodule itself.

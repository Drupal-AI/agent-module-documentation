# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core only — there are no contrib module or third-party library
  dependencies.

To actually populate the files you will need details from your app teams: iOS app
IDs and deep-link paths, Android package names and SHA-256 signing-certificate
fingerprints, and (if relevant) your Apple developer and Apple Pay merchant
association strings.

## Install with Composer

From the project root:

```bash
composer require drupal/mobile_app_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mobile_app_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mobile_app_links -y
```

There are no submodules. Once enabled, fill in the config forms — see
[Configuration](../configuration/index.md).

> **The served files are public by design.** Apple and Google require the
> `/.well-known/...` association files to be reachable by anyone for the app-domain
> association to verify, so all four served routes are open to the public. Their
> contents are entirely what you enter in the config forms.

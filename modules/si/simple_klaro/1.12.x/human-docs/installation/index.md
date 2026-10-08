# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Klaro JavaScript library** (`kiprotect/klaro`, pinned to **v0.7.22**). The
  module can use the library either from a CDN or installed via Composer, but the
  **recommended** setup is a local Composer install, which needs a couple of extra
  steps (below).
- No dependent Drupal modules.

## Install the module with Composer

From the project root:

```bash
composer require drupal/simple_klaro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_klaro -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install the Klaro library locally (recommended)

To serve the Klaro library from your own site rather than a CDN, use the Composer
merge plugin so that the module's `composer.libraries.json` is included:

1. Add the merge plugin:

   ```bash
   composer require wikimedia/composer-merge-plugin
   ```

2. Add the following to the `extra` section of your site's `composer.json` (adjust
   the `docroot` path if your webroot differs):

   ```json
   "merge-plugin": {
       "include": [
           "docroot/modules/contrib/simple_klaro/composer.libraries.json"
       ]
   }
   ```

3. Run `composer update` so the Klaro library is pulled in.

## Enable the module

```bash
drush en simple_klaro -y
```

## Verify it worked

Once enabled, the consent manager appears automatically on the front end of every
page — visit your site as an anonymous visitor and you should see the Klaro consent
dialog. To configure the services and texts, go to **Configuration → System → Simple
Klaro** (see [Configuration](../configuration/index.md)).

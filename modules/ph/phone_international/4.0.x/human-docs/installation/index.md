# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is enabled on standard installs.
- The PHP library **`giggsey/libphonenumber-for-php`** (`^9.0`) and the **`ext-zip`**
  PHP extension — both are pulled in automatically when you install via Composer.
- The **intl-tel-input** JavaScript library, version **25.3 or newer**. You can
  either load it from a CDN (the module's default option) or install a local copy
  into your site's `libraries/` folder — see "Get the JavaScript library" below.

Because the module depends on an external PHP library, **it must be installed
with Composer** — do not use the tarball from the project page.

## Install with Composer

From the project root:

```bash
composer require drupal/phone_international -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in `giggsey/libphonenumber-for-php`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phone_international -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phone_international -y
```

## Get the JavaScript library

The country-flag widget needs the **intl-tel-input** JS library (v25.3+). You
have two choices, and which one applies is set on the module's settings page (see
[Configuration](../configuration/index.md)):

- **CDN** — leave the "Load from CDN" setting on and the module loads the assets
  from jsDelivr. Nothing to install locally; the downside is an external request.
- **Local copy** — turn the CDN setting off and place the library in
  `libraries/intl-tel-input`. The quickest way is the bundled Drush command:

  ```bash
  drush phone_international:plugin
  ```

  (aliases `piplugin` / `pi-plugin`). It downloads intl-tel-input into your
  `libraries/` directory. Alternatively, install it with Composer via
  asset-packagist (`composer require npm-asset/intl-tel-input:^25.3`) if your
  project is set up for NPM assets.

The site's **Status report** (`/admin/reports/status`) warns you if a local
library is missing or older than v25.3, so check there if the widget doesn't
appear correctly.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields**, add a field,
and confirm **International Phone** appears in the field-type list. Add it, then
open a node's edit form — you should see the country-flag selector and phone
input. Type a number, save, and confirm it is stored and displayed correctly.

Next, see [Configuration](../configuration/index.md) to choose the CDN-vs-local
setting and tune the widget and formatter options.

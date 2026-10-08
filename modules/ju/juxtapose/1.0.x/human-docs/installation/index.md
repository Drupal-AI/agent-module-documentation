# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — the only module dependency, and normally
  already enabled.
- The **JuxtaposeJS** JavaScript library (installed as a separate step below).

## Install with Composer

From the project root:

```bash
composer require drupal/juxtapose -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/juxtapose -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the JuxtaposeJS library

The slider itself is drawn by the JuxtaposeJS library, which is not bundled. Get
the latest version and extract it into your site's `/libraries` directory so the
JavaScript ends up at exactly this path:

```
/libraries/juxtapose/build/js/juxtapose.js
```

If you manage libraries with Composer, JuxtaposeJS can be installed automatically
via a `composer.libraries.json` entry.

## Enable the module

```bash
drush en juxtapose -y
```

Or enable **Juxtapose Slider Image Formatter** on the **Extend** page
(`/admin/modules`).

## Verify it worked

Go to a content type's **Manage display** (**Structure → Content types → *(type)* →
Manage display**) that has a multi‑value image field. The **Juxtapose Before After
Slider** format should be selectable for that field. Choose it, add a node with at
least two images in the field, and confirm the draggable before/after slider
appears on the rendered page.

> **Heads up:** This release is not covered by Drupal's security advisory policy,
> so review it before use on a security‑sensitive site.

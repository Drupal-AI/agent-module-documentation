# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **clipboard.js** JavaScript library (v2.0.11) — this is an external
  dependency that is **not bundled** with the module and must be downloaded
  separately (see below).

The module has no other module dependencies and no PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/clipboardjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clipboardjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Download the clipboard.js library (required)

The module needs the clipboard.js file placed at:

```
DRUPAL_ROOT/libraries/clipboard/dist/clipboard.js
```

The simplest way, if your project uses Asset Packagist, is:

```bash
composer require npm-asset/clipboard:^2.0.11
```

Otherwise download v2.0.11 from <https://clipboardjs.com/> (or GitHub) and copy
`clipboard.js` into `libraries/clipboard/dist/`. After installing, check **Reports
→ Status report** (`/admin/reports/status`): the module shows an **error** if the
library is missing, a **warning** if only an alternative (Wikimedia composer‑merge)
path is found, and **OK** once it is in place.

## Enable the module

```bash
drush en clipboardjs -y
```

## Submodules

Clipboard.js ships no submodules.

## Next steps

There is no settings page to configure. Add a copy button by choosing a
Clipboard.js formatter on a content type's **Manage display** page — see [How to
use it](../index.md#how-to-use-it) in the overview.

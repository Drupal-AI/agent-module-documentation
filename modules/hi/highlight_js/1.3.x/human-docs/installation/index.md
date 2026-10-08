# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** (`ckeditor5`) module — the code button lives in the
  CKEditor 5 toolbar, so this is a hard dependency (Drupal enables it
  automatically).

There are no third‑party Composer or PHP library requirements; the Highlight.js
library ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/highlight_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/highlight_js -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en highlight_js -y
```

## Verify it worked

After enabling, the setup is done in the admin UI: add the button to a text
format and choose your languages and theme, as described in
[Configuration](../configuration/index.md). Once that's done, edit a piece of
content with that format enabled — the Highlight.js button should appear in the
CKEditor 5 toolbar, and clicking it should open the code‑insertion dialog.

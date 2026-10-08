# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) — Drupal 9+ ships with it, and this
  module depends on it. Drupal enables it as a dependency automatically.
- The module includes the PrismJS library and its available styles, so there is no
  separate library download step.

## Install with Composer

From the project root:

```bash
composer require drupal/prismjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prismjs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prismjs -y
```

## Verify it worked

After enabling, go to **Configuration → Content authoring → Prism Js**
(`/admin/config/content/prism-js`) and confirm you can pick languages and a theme —
see [Configuration](../configuration/index.md). Then add the Prism Js button to a
CKEditor 5 toolbar, create content, and insert a code snippet to confirm it renders
highlighted.

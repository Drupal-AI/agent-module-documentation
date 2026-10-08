# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Filter** module (`filter`) — standard in Drupal.
- The contributed **[Token](https://www.drupal.org/project/token)** module
  (`token`) — Composer pulls this in automatically with the `-W` flag.
- To use the tokens inside CKEditor content, the contributed
  **[Token Filter](https://www.drupal.org/project/token_filter)** module as well
  (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/render_menu_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Token
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/render_menu_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en render_menu_token -y
```

## For CKEditor / body-text use: add Token Filter

If you want to place `[menu:render:…]` tokens inside filtered content such as a
node body, install and enable Token Filter, then turn its filter on for a
**trusted, editor-only** text format:

```bash
composer require drupal/token_filter -W
drush en token_filter -y
```

Then go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), configure a trusted format, and enable the
**Replace tokens** filter. Do not enable it on formats available to anonymous
users.

## Verify it worked

Add a `[menu:render:MACHINE_NAME]` token — using a real menu's machine name from
**Structure → Menus** — to a piece of content that uses a token-enabled format (or
another place where tokens are processed). Save and view it; the token should be
replaced with the rendered menu tree, showing only the links the viewer is allowed
to see.

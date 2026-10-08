# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — a dependency, enabled automatically.
- A **writable `public://`** — the module stores generated assets under
  `public://custom_bootstrap_icon_font/`.
- **Source SVG icons on disk:**
  - Bootstrap Icons under `web/libraries/bootstrap-icons/icons` — download a
    release from <https://github.com/twbs/icons/releases> and extract it there.
  - Font Awesome SVGs under `web/libraries/fontawesome/icons` — these are **not**
    bundled; you provide the SVGs (from <https://fontawesome.com/search?ic=free>),
    either by dropping files in that directory or via the admin form's "Upload SVG
    icons" section. (Some hosts don't allow writing to `libraries/` from the web
    UI — in that case upload via SFTP/CI.)
- **Node tooling for building the font:** `node`, `npm`, and `npx`, with
  **Fantasticon** available to the same environment that runs Drush (and, if you
  build from the UI, to the PHP/web user too).

## Install with Composer

From the project root:

```bash
composer require drupal/custom_bootstrap_icon_font -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_bootstrap_icon_font -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_bootstrap_icon_font -y
```

## Install Fantasticon (the font generator)

The recommended, deterministic approach is a project‑level install at the folder
you run Drush from:

```bash
# Only if you don't already have a root package.json:
npm init -y

npm install --save-dev fantasticon

# Confirm it's available without prompting to download:
npx --no-install fantasticon --version
```

A global install (`npm install -g fantasticon`) also works. Avoid relying on
`npx fantasticon` with no install on CI/servers, since it may try to download
Fantasticon interactively.

> With DDEV, run the npm commands through `ddev npm …` (or inside `ddev ssh`) so
> Fantasticon lives in the same container that runs Drush.

## Verify it worked

Log in as a user with the **administer custom bootstrap icon font** permission and
open **Configuration → Media → Custom Bootstrap Icon Font**
(`/admin/config/media/bootstrap-icon-font`). The generate form should load. Then
select an icon and build (see [Configuration](../configuration/index.md)) — a font
and CSS should appear under `public://custom_bootstrap_icon_font/font/`.

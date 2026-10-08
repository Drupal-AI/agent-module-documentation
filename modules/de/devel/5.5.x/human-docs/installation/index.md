# Installation

## Requirements

Devel needs:

- **PHP 8.3 or newer**.
- **Drupal 10.3+, 11, or 12** (core requirement `^10.3 || ^11 || ^12`).
- Two libraries that Composer pulls in automatically:
  - **symfony/var-dumper** — powers the default variable dumper.
  - **doctrine/common** — a supporting dependency.

Devel has no other required Drupal module dependencies. **Drush** is optional but
recommended: it provides the `devel:*` command-line tools (`devel:token`,
`devel:hook`, `devel:event`, `devel:services`, `devel:uuid`, `devel:reinstall`).

## Install with Composer

Because Devel is a development-only tool, install it as a **dev dependency** so
it never ships to production. From the project root:

```bash
composer require drupal/devel -W --dev
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the required
libraries as needed; `--dev` records Devel under `require-dev` in your
`composer.json`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/devel -W --dev`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel -y
```

Once enabled, the configuration screen appears under **Configuration →
Development → Devel settings** (`/admin/config/development/devel`).

## Useful submodules and companions

Devel ships one submodule and works well alongside a couple of separate
projects:

- **Devel Generate** (`devel_generate`) — bundled with Devel. Creates bulk dummy
  content (nodes, users, taxonomy terms, menus) for testing. Enable it with:

  ```bash
  drush en devel_generate -y
  ```

- **Webprofiler** (`webprofiler`) — a separate project that adds a Symfony-style
  performance and inspection toolbar (queries, timing, services). Install and
  enable it separately:

  ```bash
  composer require drupal/webprofiler --dev
  drush en webprofiler -y
  ```

- **Kint** — an alternative, richer variable dumper. Kint is not a submodule; it
  is a PHP library you add with Composer, after which it becomes selectable as
  the **Variables Dumper** on the Devel settings page:

  ```bash
  composer require kint-php/kint --dev
  ```

  See [Configuration](../configuration/index.md) for choosing the dumper.

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Devel
settings** (`/admin/config/development/devel`). You should see the Devel settings
form with **Settings** and **Toolbar Settings** tabs:

![The Devel settings page after installation](../images/settings.png)

If the page loads with the error-handler and Variables Dumper options, the
module is installed correctly. Next, review the
[configuration](../configuration/index.md).

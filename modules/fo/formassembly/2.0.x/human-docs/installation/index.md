# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Map Widget** module (`drupal/map_widget ^2.0`) — a Drupal dependency that
  Composer pulls in automatically.
- PHP extensions **libxml** (`ext-libxml`) and **json** (`ext-json`), used to
  parse the remote form markup. These are standard on most Drupal hosts.
- Non‑Drupal PHP libraries **`fathershawn/oauth2-formassembly`** (the OAuth
  client) and **`symfony/dom-crawler`** / **`symfony/css-selector`** (markup
  parsing). Because of these, the module **must** be installed with Composer, not
  by downloading a tarball.

Optional extras you may want later: **Token** (to pre‑fill form values from
Drupal data), **Key** (to store OAuth credentials securely — recommended, see
Configuration), and `scrivo/highlight.php` with `gajus/dindent` (to display the
fetched form HTML for inspection on the entity edit form).

The module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root, the maintainers recommend pinning the 2.x branch:

```bash
composer require 'drupal/formassembly:^2.0' -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and Composer will bring in Map Widget and the OAuth and
Symfony libraries at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require 'drupal/formassembly:^2.0' -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formassembly -y
```

This also enables **Map Widget** if it isn't already on.

## Verify it worked

Log in as an administrator and go to **Structure → FormAssembly forms**
(`/admin/structure/fa_form`). If the FormAssembly forms listing appears, the
module is installed. Before you can pull forms in, you need to authorise the site
against FormAssembly with OAuth — see [Configuration](../configuration/index.md).

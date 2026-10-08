# Installation

> **Before you install:** this module is **unsupported** and its security coverage has been
> revoked over an unfixed flaw (see the security warning in the
> [manual setup guide](../index.md)). Prefer an actively maintained alternative where you can.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** (`link`) module — part of Drupal core.
- A **parser backend**. The built‑in PHP Readability parser (`fivefilters/readability.php`) is
  the default and is pulled in with the module. Optional alternatives include the Node.js
  Postlight/Mercury parser, `j0k3r/graby` (which needs the `php-tidy` extension), or an
  external Mercury parser API.

## Install with Composer

From the project root:

```bash
composer require drupal/postlight_parser -W
```

This installs the module together with the PHP Readability library it needs. If you want the
optional Graby backend as well:

```bash
composer require j0k3r/graby -W
```

(Graby additionally requires the `php-tidy` extension on your server.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/postlight_parser -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postlight_parser -y
```

## Verify it worked

Add a **Link** field to a content type, set its form widget to **Postlight parser**, and map
the output fields. Paste an article URL into the field and confirm the title, body, and image
are extracted.

**Then lock it down:** do not leave the `/parser/{parser}` endpoint reachable by anonymous
users. Review the security warning in the [manual setup guide](../index.md) and restrict the
route and the fetched URL before this module is exposed on any public site.

# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required.
- To actually produce any output you'll need a **custom module** containing your
  JSLD plugins — JSLD is an API and ships with none of your site's markup built
  in.

## Install with Composer

From the project root:

```bash
composer require drupal/jsld -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsld -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsld -y
```

## Verify it worked

On its own, enabling JSLD produces no visible change — it waits for you to supply
plugins. Once you've added a `@JsldEntity` or `@JsldPath` plugin in a custom
module (see "How to use it" in the [overview](../index.md)), visit a page that
plugin targets and view the page source: you should find your JSON‑LD emitted in a
`<script type="application/ld+json">` block. You can also paste the URL into
Google's Rich Results Test to confirm the structured data is picked up.

# Drupal CMS Helper — manual setup guide

**Drupal CMS Helper** (`drupal_cms_helper`) is the "glue" module that ships with
Drupal CMS. It provides recipe-developer tooling and a set of shims for behavior
that isn't in Drupal core yet. On a Drupal CMS site it's a required dependency of
recipes and site templates, so **it should not be uninstalled**.

Its headline feature is **recipe export**: a `site:export` Drush command (and an
equivalent `SiteExporter` service) that serialise your running site's
configuration and content into a distributable `Site`-type recipe — writing a
`recipe.yml`, a `composer.json`, a `config/` tree, and exported default content.
This lets you turn a hand-built site into a site template that can be applied at
install time. There's also an admin route to download the whole site as a ZIP
recipe. Alongside export, it adds a `--generic` option to core's `config:export`
that strips the `_core` and `uuid` keys so the output is recipe-ready.

The module also ships a couple of stable config-action plugins for use inside
recipes — `setDefaultImage` (point an image field at a file by UUID that may not
exist yet) and `themeDevelopmentMode` (toggle Twig debug/cache development
settings) — plus a large collection of **internal** shims (extra hidden Drush
commands, internal config actions, form/render/menu alterations) that are marked
`@internal` and will be removed as the matching core issues land. Most of the
module's surface is internal; only a small part is a stable API.

It has **no configuration UI of its own** and depends only on core's Path Alias
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (though on Drupal CMS it's already present).

## Where it lives in the admin menu

There's no settings page. The one admin screen it adds is the site-export
download at **Configuration → Development → Site export**
(`/admin/config/development/site-export`), which requires the **Administer site
configuration** permission. Everything else is driven from the command line.

## How to use it

**Export your site as a recipe** (the main use):

```bash
drush site:export --destination=/path/to/recipe
```

Useful options:

- `--destination=<dir>` — where to write the recipe. Defaults to the Composer
  recipe ("cookbook") path if one can be determined.
- `--overwrite` — allow writing into an existing destination directory.
- `--base=<dir>` — build on top of a base recipe; its files are copied first,
  then your site's config and content are regenerated over the top.
- `--dev` — export in development mode (enables theme development instead of
  forcing CSS/JS aggregation on).

The command writes a `recipe.yml` (with `type: Site`, an `install:` list of every
installed module and theme, and a `config:` section), a `composer.json`, a
`config/` tree, and a `content/` tree of default content. Config that belongs to
core, System, and User is emitted as config *actions* rather than files. Site
name and mail, `core.extension`, path aliases, and a few internal entity types
are deliberately excluded so the recipe stays portable.

**Produce recipe-ready config** from any site:

```bash
drush config:export --destination=/path/to/dir --generic
```

**Download the site as a ZIP** instead of using the CLI: visit
`/admin/config/development/site-export` as an administrator.

**Use the config actions in a recipe** — inside a recipe's `config: actions:`
section you can call `setDefaultImage` (set an image field's default to a file
UUID that doesn't exist yet, e.g. shipped as recipe default content) and
`themeDevelopmentMode` (enable/disable Twig debug, Twig cache, and render-cache
development settings).

There are also hidden, internal commands (`content:export:all`,
`content:import`, `site:archive`) for exporting/importing default content and
archiving a site — see the [`agent/`](../agent/start.md) docs if you need them,
but note they're `@internal` and may change.

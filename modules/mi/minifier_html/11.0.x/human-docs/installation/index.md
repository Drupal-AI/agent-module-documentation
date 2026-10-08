# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

Minifier HTML has no module dependencies and no third-party Composer or PHP library
requirements.

> **Read this before enabling.** The module has no settings and no exclusions: it
> collapses whitespace across the whole HTML document, including inside `<pre>`,
> `<code>`, `<textarea>`, and `<script>`. That can destroy preformatted content and
> — because textarea contents are a field's *value* — silently corrupt stored
> content when an editor re-saves a form. See the [main guide](../index.md) for the
> full explanation. For most sites, minifying at a CDN or reverse proxy is the
> safer way to get the same page-size saving.

## Install with Composer

From the project root:

```bash
composer require drupal/minifier_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/minifier_html -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en minifier_html -y
```

Minification is now active on every HTML response — there is nothing to configure.
To turn it off, uninstall the module:

```bash
drush pmu minifier_html -y
```

## Verify it worked

Load a page on your site and view its HTML source (or compare the response size
with the module enabled versus disabled) — you should see the markup with
whitespace and comments stripped, and a smaller total byte size. At the same time,
check any pages that use `<pre>`/`<code>` blocks or editing textareas to confirm
the module's effects are acceptable for your content before leaving it enabled.

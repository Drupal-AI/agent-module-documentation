# Twig Tweak — manual setup guide

**Twig Tweak** (`twig_tweak`) is a developer and themer tool that adds a bundle of
convenient functions and filters to Twig. Drupal's default Twig integration is
intentionally minimal, so common theming jobs — embedding a view, rendering a
block or region, printing a single field, replacing tokens, or generating an
image‑style URL — normally force you to drop into PHP in a `*.theme` file. Twig
Tweak closes that gap so you can do all of it inline, right in a template.

Once enabled it registers around twenty functions (such as `drupal_view()`,
`drupal_block()`, `drupal_region()`, `drupal_entity()`, `drupal_field()`,
`drupal_menu()`, `drupal_image()`, and debug helpers like `dump`/`dd`) and about
eighteen filters (such as `image_style`, `token_replace`, `truncate`,
`transliterate`, `file_url`, and `view`). These are available immediately in any
`*.html.twig` template — the rendering is handled by dedicated services that take
care of access checks and cache metadata for you.

There is **nothing to configure**: Twig Tweak has no admin UI, no permissions, and
no settings page. You enable it and start using the helpers in your templates. It
depends only on core's **System** module and requires PHP 8.1+ and Twig 3.10.3+.
It also ships Drush commands for debugging and validating Twig, and it optionally
suggests `symfony/var-dumper` for a nicer `dump()` while debugging.

This guide is written for a **human** working in template files. If you want
terse, token‑cheap references for an AI coding agent — including the full function
and filter catalogs — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Twig Tweak has no admin screen. After you enable the module, its functions and
filters simply become available in every Twig template. A few of the most common:

- **Embed a view** — render a view display straight from a template:
  `{{ drupal_view('who_s_new', 'block_1') }}`. Use
  `drupal_view_result()` first if you want to check whether a view returns any
  rows before printing it.
- **Render a block or region** — `{{ drupal_block('system_branding_block') }}` or
  `{{ drupal_region('sidebar_first') }}`.
- **Render an entity or a single field** —
  `{{ drupal_entity('node', 123, 'teaser') }}` for a whole entity in a view mode,
  or `{{ drupal_field('field_image', 'node', 1, 'teaser') }}` for one field.
- **Print a menu** — `{{ drupal_menu('main') }}`.
- **Work with tokens and config** — replace a token with
  `{{ drupal_token('site:name') }}` or the `token_replace` filter, and read a
  config value with `{{ drupal_config('system.site', 'name') }}`.
- **Transform values with filters** — apply an image style
  (`{{ node.field_image.entity.uri.value|image_style('thumbnail') }}`), or
  `truncate`, `transliterate`, `format_size`, `file_url`, and more.
- **Debug a template** — dump a variable with `{{ dump(node) }}` / `{{ dd(node) }}`,
  or run `drush twig-tweak:debug` to list every registered function, filter, and
  test.

For the complete catalog of functions and filters and their arguments, the
[`agent/`](../agent/start.md) docs are the exhaustive reference.

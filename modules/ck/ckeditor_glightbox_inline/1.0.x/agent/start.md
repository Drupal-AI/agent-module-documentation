<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor GLightbox Inline (ckeditor_glightbox_inline) — agent index

A single **output text filter** that wraps inline `<img>` tags in an `<a>` link so
they open in a **GLightbox** overlay. Despite the "CKEditor" name it adds **no**
CKEditor 5 plugin, button, route, permission, or JavaScript of its own — it is a
`FilterBase` plugin plus two hooks. Version **1.0.1** (version dir `1.0.x`). Core
`^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Maintainer: Ivan Abramenko
(levmyshkin).

## Dependencies

- Drupal module: **`glightbox`** (`glightbox:glightbox` in `.info.yml`) — provides the
  GLightbox JS library and the `glightbox.attachment` service.
- Composer: `drupal/glightbox:^1.0` (`composer.json`, `minimum-stability: dev`). No
  third-party PHP libraries.

## What it provides (from source)

- **Filter plugin** `ckeditor_glightbox_inline` — `src/Plugin/Filter/CkeditorGlightboxInline.php`,
  `@Filter` id `ckeditor_glightbox_inline`, title "GLightbox Inline Text Filter",
  type `TYPE_TRANSFORM_IRREVERSIBLE`, weight `-10`. One setting: `css_classes`
  (default `"glightbox"`).
  - `settingsForm()`: a single textfield for `css_classes` ("use space as delimiter").
  - `process($text, $langcode)`: loads the HTML with `Html::load()`, iterates every
    `<img>`. If the image has no `class`, or its class does **not** contain the
    substring `noGlightbox`, it creates an `<a>`, inserts it before the img, moves the
    img inside it, and sets on the anchor: `href` = the image's `src`, `class` = the
    `css_classes` setting, `data-glightbox-gallery` = `"ckeditor-glightbox-inline"`.
    Returns `Html::serialize($dom)` in a `FilterProcessResult`. Images whose class
    contains `noGlightbox` are skipped (opt-out).
- **Hooks** (`src/Hook/CkeditorGlightboxInlineHooks.php`, OOP `#[Hook]` attributes,
  with `#[LegacyHook]` procedural shims in `ckeditor_glightbox_inline.module`):
  - `hook_page_attachments` — calls `glightbox.attachment` service `->attach($page)`
    and attaches the module's own library on **every page**.
  - `hook_help` — for route `help.page.ckeditor_glightbox_inline`, reads a README file
    and returns it escaped inside `<pre>`. NOTE (bug, not security): it reads
    `__DIR__ . '/README.md'` where `__DIR__` is `src/Hook/`, but the README lives at
    the module root, so the file does not exist and the help page renders empty.
- **Library** `ckeditor_glightbox_inline/ckeditor_glightbox_inline`
  (`.libraries.yml`) — declares only a dependency on `glightbox/glightbox`; ships
  **no** JS or CSS of its own (no `js/`, `css/`, or `templates/`).
- **Service** `Drupal\ckeditor_glightbox_inline\Hook\CkeditorGlightboxInlineHooks`
  (`.services.yml`, `autowire: true`) — just the hook class.
- **Config schema** `filter_settings.ckeditor_glightbox_inline` (type `filter`,
  `config/schema/…schema.yml`) — the single `css_classes` string.

## Usage

Enable the module (pulls in GLightbox), then at
`/admin/config/content/formats` configure a text format and turn on the
**"GLightbox Inline Text Filter"** filter. Optionally adjust `css_classes`. Inline
images in that format then open in a GLightbox overlay on output; add class
`noGlightbox` to an individual image to exclude it. The GLightbox library is loaded
site-wide via `hook_page_attachments`, not gated to filtered content.

## Notes / gotchas

- No permissions, routes, controllers, uploads, Drush commands, or plugin types.
- `css_classes` is an **admin-only** filter setting (set by users with
  `administer filters`); it is not editor- or visitor-supplied.
- The library and GLightbox JS are attached on **all** pages, not only pages using
  the filter.
- This is the complete surface — a single-filter module — so there are no agent
  subdocs; everything is captured here.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Aside CKEditor 5 plugin

The whole module is defined declaratively in `ckeditor5_aside.ckeditor5.yml`. There is no PHP or
JavaScript.

## Plugin definition (`ckeditor5_aside.ckeditor5.yml`)

Plugin id `ckeditor5_aside_customHeadings`:

- `ckeditor5.plugins: []` — ships no compiled CKEditor 5 JS plugin of its own.
- `ckeditor5.config.heading.options` — appends one option to core's existing Heading feature:
  `{ model: 'aside', title: 'Aside', view: 'aside' }`. This makes **"Aside"** appear in the heading
  dropdown; picking it re-tags the current block as an `<aside>` element (mapping the `aside` model
  to the `aside` view/HTML tag).
- `drupal.label: 'CKEditor 5 Aside'` — label shown in the format's *CKEditor 5 plugin settings*.
- `drupal.library: ckeditor5_aside/admin.ckeditor5_aside` — the admin CSS library (below).
- `drupal.elements: ['<aside>']` — the only tag this plugin contributes to the text format's allowed
  HTML. It is the bare `<aside>` tag with **no attributes** (no `class`, `style`, `id`, or event
  attributes).
- `drupal.conditions.plugins: [ckeditor5_heading]` — the plugin is only available when the core
  **Heading** plugin is also enabled in the format; without Heading there is no dropdown to extend.

## Library (`ckeditor5_aside.libraries.yml`)

- `admin.ckeditor5_aside` — a CSS-only library: `css/ckeditor5_aside.admin.css`. No JS assets.

## Admin styling (`css/ckeditor5_aside.admin.css`)

Styles the `aside` element seen **inside the editor** so authors can distinguish it: `float: right`,
`width: 33%`, a 3px black border, padding/margin, reduced font size, and a box shadow. These styles
are loaded via the plugin's `drupal.library` in the editing context only — **the rendered front end
receives no styling**, so you must style `<aside>` in your own theme.

## Install / enable

1. `drush en ckeditor5_aside` (module dependency: core `ckeditor5`).
2. At *Administration › Configuration › Content authoring › Text formats and editors*, edit a format
   that uses the **CKEditor 5** editor.
3. Enable the core **Heading** toolbar item/plugin if it is not already active.
4. The **Aside** option now appears in the heading dropdown. When the plugin is active it
   automatically adds `<aside>` to the format's allowed HTML tags; if you use *Limit allowed HTML
   tags* manually, ensure `<aside>` is present.

## Behavior and limits

- Selecting **Aside** wraps a **single** block: e.g. `<p>text</p>` or `<h3>text</h3>` becomes
  `<aside>text</aside>`. Per the project, it works only when there are no nested tags; surrounding
  multiple stacked tags with one aside is not supported.
- Only structural `<aside>` markup is produced — no attributes are added or allowed by the plugin.

## What it does not provide

No routes, no permissions, no services, no hooks, no Drush commands, no config schema, no
`config/install`, and no settings form. Configuration is entirely the standard per-text-format
CKEditor 5 settings.

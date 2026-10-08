<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Aside (ckeditor5_aside) — agent index

Adds a single **"Aside" option to the CKEditor 5 heading dropdown** that wraps the current block in
`<aside>…</aside>`. Package **CKEditor 5**. Depends only on core **`ckeditor5`**. Core requirement
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

- **The CKEditor 5 plugin definition, how to enable it, allowed tags, and the admin styling** →
  [plugins/aside.md](plugins/aside.md)

## What it actually is

- **No PHP, no JS.** The entire module is one CKEditor 5 plugin definition
  (`ckeditor5_aside.ckeditor5.yml`), one library (`ckeditor5_aside.libraries.yml`), and one admin
  CSS file (`css/ckeditor5_aside.admin.css`).
- **No routes, no permissions, no services, no hooks, no config schema, no config/install.** Nothing
  to administer beyond the standard per-text-format CKEditor 5 settings.
- Requires the core **Heading** plugin (`ckeditor5_heading`) to be enabled in the same text format
  (declared via `conditions.plugins`).

## Mechanism (from source)

- Plugin `ckeditor5_aside_customHeadings` in `ckeditor5_aside.ckeditor5.yml` sets `ckeditor5.plugins: []`
  and injects one extra option into core's `heading` config:
  `{ model: 'aside', title: 'Aside', view: 'aside' }`. Selecting it in the editor converts the block
  to an `<aside>` element.
- `drupal.elements: ['<aside>']` — the only HTML this plugin adds to the format's allowed tags is the
  bare `<aside>` tag (no attributes). `drupal.library` loads `ckeditor5_aside/admin.ckeditor5_aside`.
- `css/ckeditor5_aside.admin.css` styles the `aside` element (float, border, shadow) **inside the
  editor only**; the front-end theme gets no styling — you style `<aside>` yourself.

## Operate it

1. `drush en ckeditor5_aside`.
2. In a text format that uses CKEditor 5 (Full HTML etc.), enable the **Heading** plugin, then the
   **Aside** option appears in the heading dropdown.
3. Ensure the format's filters allow the `<aside>` tag (the plugin adds it to allowed tags
   automatically when active).

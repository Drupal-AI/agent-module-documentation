<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `<pre>` heading plugin (ckeditor5_pre)

## What it is
A **declarative** CKEditor 5 plugin — no custom JS is built or shipped. The whole feature is
`ckeditor5_pre.ckeditor5.yml`:

```yaml
ckeditor5_pre_customHeadings:
  ckeditor5:
    plugins: []
    config:
      heading:
        options:
          - { model: 'pre', title: 'Pre', view: 'pre', class: 'ck-heading_pre' }
  drupal:
    label: CKEditor 5 Pre
    library: ckeditor5_pre/admin.ckeditor5_pre
    elements:
      - <pre>
    conditions:
      plugins:
        - ckeditor5_heading
```

- `plugins: []` — contributes no CKEditor 5 JS plugin class. It only **merges into the `heading`
  config** that core's `ckeditor5_heading` plugin reads, appending one more block-format option.
- `config.heading.options[]` — one option: model `pre`, UI title "Pre", view element `pre`, and the
  label class `ck-heading_pre` (used only for the toolbar/dropdown label styling, not on output markup).
- `drupal.elements: [<pre>]` — declares that this plugin is responsible for the `<pre>` HTML element.
  Drupal's CKEditor 5 → filter integration uses this so that, when a text format is saved, `<pre>` is
  added to the format's **Allowed HTML tags** (filter_html) automatically.
- `drupal.conditions.plugins: [ckeditor5_heading]` — the option only appears when the core Headings
  plugin is enabled (i.e. the **Headings** button is in that format's toolbar).
- `drupal.library` — attaches `ckeditor5_pre/admin.ckeditor5_pre`.

## The library / CSS
`ckeditor5_pre.libraries.yml` defines `admin.ckeditor5_pre` → `css/ckeditor5_pre.admin.css`, whose only
rule styles the dropdown label:

```css
.ck.ck-heading_pre .ck-button__label { white-space: pre; font-family: monospace; }
```

Purely cosmetic (the "Pre" entry looks monospace in the menu). It does not affect rendered content.

## Install / enable
1. `drush en ckeditor5_pre` (core `ckeditor5` is a dependency).
2. Edit a text format+editor (`/admin/config/content/formats/manage/<format>`) that uses CKEditor 5.
3. Ensure the **Headings** button is in the active toolbar (the option is gated on `ckeditor5_heading`).
4. **Save the format** — this is required for restricted formats (e.g. Basic HTML) so `<pre>` is added
   to "Limit allowed HTML tags and correct faulty HTML". "Pre" then appears in the Headings dropdown.

## Operating notes
- Provides no config of its own — no `config/install`, no `config/schema`, no admin settings route
  (`configure` is null). All behavior lives in per-format editor config.
- Provides no permissions, routes, services, hooks, or Drush commands.
- Reliable for plain text and single-level tags inside the block; wrapping multiple nested block-level
  elements may round-trip unexpectedly (a documented upstream limitation).
- Applies to Drupal 10, 11 and 12 (`core_version_requirement: ^10 || ^11 || ^12`).

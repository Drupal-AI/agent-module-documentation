<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Section (ckeditor_section) — agent index

Version **1.0.1** (`1.x`). Drupal core CKEditor 5 plugin, `core_version_requirement: ^9.3 || ^10 || ^11`.
Package `CKEditor`. No composer requirements beyond core; no PHP dependencies.

## What it does

Adds a single CKEditor 5 toolbar button (**Section** / "Add Section") that wraps
the selected block(s) of content in a semantic HTML `<section>` element — the same
UX pattern core uses for block quotes, applied to `<section>`. It is a pure
authoring/UI enhancement: there is **no PHP** in the module at all — no routes, no
controllers, no services, no permissions, no hooks, no `.module`/`.install`, no
config schema. Everything is a compiled CKEditor 5 JavaScript plugin plus two YAML
definitions and CSS.

## Composition (entire module)

- `ckeditor_section.info.yml` — module definition. `type: module`, package `CKEditor`.
- `ckeditor_section.ckeditor5.yml` — the CKEditor 5 plugin definition:
  - plugin id `ckeditor_section_section`, JS plugin `section.Section`.
  - `drupal.label: section`, toolbar item `section` (label "Add Section").
  - `library: ckeditor_section/section`, `admin_library: ckeditor_section/admin.section`.
  - **`elements: - <section>`** — registers a bare `<section>` (no attributes) with
    the editor's allowed-tags handling. This is what integrates with the text
    format's "Allowed HTML tags" so the wrapper survives filtering.
- `ckeditor_section.libraries.yml`:
  - `section` — attaches `css/section.editor.css` + minified `js/build/section.js`,
    depends on `core/ckeditor5`.
  - `admin.section` — attaches `css/section.admin.css` (toolbar-button icon in the
    editor-config admin UI).
- `js/ckeditor5_plugins/section/src/` — plugin source (webpack-built into
  `js/build/section.js`):
  - `index.js` / `section.js` — `Section` plugin, requires `SectionEditing` + `SectionUI`.
  - `sectionui.js` — registers the `section` toolbar `ButtonView`; toggleable,
    bound to command `blockSection` `value`/`isEnabled`; executes `blockSection`.
  - `sectioncommand.js` — `SectionCommand` (registered as `blockSection`). Wraps/
    unwraps selected block groups in the GHS model element **`htmlSection`** (the
    model name Drupal's General HTML Support assigns to `<section>`). Mirrors
    CKEditor's block-quote command logic (`getRangesOfBlockGroups`, wrap/unwrap/
    split/merge).
  - `sectionediting.js` — `SectionEditing`; adds the command, a post-fixer that
    removes empty `htmlSection` elements and unwraps ones placed where the schema
    disallows them, and Enter/Backspace handlers that toggle out of a section when
    the caret is in an empty trailing/leading block.
- `css/section.editor.css` — in-editor styling of `.ck-content section` (dotted
  top/bottom border + a "section" label pseudo-element) so authors can see the
  wrapper.
- `css/section.admin.css` — toolbar-button background icon (`icons/section.svg`).
- Build tooling only: `package.json`, `package-lock.json`, `webpack.config.js`,
  `phpcs.xml.dist`, `.gitlab-ci.yml`. No `composer.json`, no `README`.

## Model / command reference (for agents)

- Command name: **`blockSection`** (execute to toggle a section around the selection).
- Toolbar item / component name: **`section`**.
- Model element it produces: **`htmlSection`** → renders to `<section>` via GHS.
- CKEditor JS plugin global: `CKEditor5.section` exporting `{ Section }`.

## Setup (no settings page)

There is no admin config route for this module. Per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`):
1. Enable the CKEditor 5 editor for the format.
2. Drag the **Section** button into the toolbar.
3. Ensure the format's **Allowed HTML tags** permit **`<section>`** — otherwise the
   text-format filter strips the wrapper on output. The module registers only a
   bare `<section>` (no class/style/attributes), so no extra attribute allowances
   are needed or added by the module.

See `human-docs/` for the click-through human guide and `usage.md` for the summary.

## Notes

- Only ships the toolbar button + editing behavior; it does not itself add or
  loosen any HTML filter. Output sanitization is entirely Drupal core's text-format
  filtering; the module widens nothing beyond the bare `<section>` tag it registers.
- Requires the format to be a CKEditor 5 editor (depends on `core/ckeditor5`).

# Icon Select — manual setup guide

**Icon Select** (`icon_select`) lets you manage a library of SVG icons as
taxonomy terms and pick them through a visual icon‑picker field widget. All the
chosen icons are served from a single, automatically generated and sanitized SVG
**sprite sheet**, and you can render them either through an entity‑reference
field or with a simple `svg_icon()` Twig function in your templates.

It's a tidy way to back a design system with editorially managed icons. Editors
add icons as terms — one SVG per term, each with a unique symbol ID — and get a
visual checkbox‑style picker instead of an autocomplete when choosing one on
content. Front‑end developers can drop any icon into a template with
`{{ svg_icon('ui-check') }}` (optionally passing CSS classes). Because every icon
lives in one shared sprite, swapping an icon site‑wide is as easy as replacing
one term's SVG file — the sprite regenerates automatically.

On install the module creates an **`icons`** taxonomy vocabulary. Each icon term
has two fields: **Symbol ID** (`field_symbol_id`, a required, unique string that
becomes the SVG `<symbol id>` — use lowercase, e.g. `ui-check`) and an **SVG
file** (`field_svg_file`). Whenever an icon term is added, edited, or deleted, the
module rebuilds the sprite: it reads every icon's SVG, runs it through the
`enshrined/svg-sanitize` sanitizer (stripping scripts and exploits), assembles the
`<symbol>` sheet, and writes it to `public://icons/icon_select_map.svg` by
default. It depends on core's **Taxonomy**, **Field**, and **File** modules plus
the SVG sanitizer library.

There is no dedicated settings page. The one adjustable option — where the sprite
file is written — lives on the `icons` vocabulary edit form, and the sprite can be
rebuilt on demand with a Drush command. Everything else is done through normal
taxonomy, field‑display, and Twig workflows, all covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with its SVG
   sanitizer library) and enable it.

## Where it lives in the admin menu

Icon Select has no `configure` route of its own. You work with it in a few
familiar places:

- **The icon library** — **Structure → Taxonomy → Icons**
  (`/admin/structure/taxonomy/manage/icons`). Add icons with *Add term*
  (`/admin/structure/taxonomy/manage/icons/add`).
- **The sprite path setting** — the `icons` vocabulary *edit* form
  (`/admin/structure/taxonomy/manage/icons`) has a **"Path of SVG sprite file"**
  textfield (default `icons/icon_select_map.svg`, relative to the public files
  folder). Saving it re‑runs sprite generation.
- **Field wiring** — the *Manage form display* and *Manage display* tabs of
  whatever content type references the icons vocabulary (see below).

## How to use it

**1. Add some icons.** Go to **Structure → Taxonomy → Icons → Add term**. Give
each term a unique **Symbol ID** (lowercase, e.g. `ui-check`) and upload one
**SVG file**. Prefer SVGs that include a `viewBox` — one without it renders a
visible "Missing viewBox" placeholder. Saving the term automatically rebuilds the
sprite.

**2. Add an icon field to your content.** On the content type (or any bundle) you
want to carry an icon:

- Add an **Entity reference** field targeting **Taxonomy term**, bundle
  **Icons**.
- On **Manage form display**, set that field's widget to **Icon Select** — the
  visual picker.
- On **Manage display**, set the field's formatter to **SVG Icon**, which outputs
  `<svg><use xlink:href="#symbol-id">` referencing the sprite.

Editors will now see the icon picker (with previews) when editing content, and the
chosen icon renders on the page.

**3. Or drop icons straight into a template.** In any Twig template you can write:

```twig
{{ svg_icon('ui-check') }}
{{ svg_icon('ui-check', 'icon--large') }}
```

The function renders the icon from the sprite and always adds the CSS classes
`icon` and `icon--<symbol-id>` (e.g. `icon--ui-check`), so you can style icons by
symbol.

**4. Regenerating the sprite.** The sprite rebuilds automatically whenever you add,
edit, or delete an icon term. After bulk changes made outside the term forms (a
migration, say), or if the sprite file was deleted, rebuild it manually with
Drush:

```bash
drush generate-sprites   # or the alias: drush gens
```

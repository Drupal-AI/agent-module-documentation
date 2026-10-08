# External-use Icons — manual setup guide

**External-use Icons** (`ex_icons`) is an icon toolkit for Drupal built around SVG
sprite sheets. Any module or theme that ships a `dist/icons.svg` sprite has its
`<symbol>` icons automatically discovered and made available across the site — in
Twig templates, as a content field, and through a visual icon picker. Icons are
rendered efficiently as `<svg><use href="…">` references to the shared sprite,
which keeps markup small and lets one downloaded file serve every icon.

Importantly, the module **ships no icons of its own** — it's the plumbing, not the
icon set. You (or your theme, or another module) provide the sprite; External-use
Icons finds it and exposes the symbols. It also takes care of accessibility
niceties like `aria-hidden`/text alternatives and can compute a missing width or
height from an icon's aspect ratio.

Because it's mostly a developer and site‑builder tool, there is no central
settings page. You use it by shipping a sprite and then referencing icons from
fields or templates, as described below.

This guide is written for a **human** clicking through the admin UI and templates.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

### Provide a sprite

Put a sprite sheet at `dist/icons.svg` inside a module or theme. Each icon is a
`<symbol id="…" viewBox="…">…<title>Label</title>…</symbol>` element; the `id`
becomes the icon's machine name and the `<title>` becomes its (translatable)
label. Symbols without an `id`, or with an invalid `viewBox`, are skipped.
Several extensions can each ship their own sprite at once. After changing a
sprite, clear the icon cache (see below).

### Add an icon field to content

On a content type's **Manage fields** screen, add a field of type **Icon**
(`ex_icon`). It stores an icon id plus an optional text alternative, and its
field settings let you make that text alternative *disabled*, *optional* or
*required* for accessibility. Editors then pick an icon from a visual grid
(the **Icon** widget) when filling in content.

Two formatters are available on **Manage display**:

- **Icon (default)** — renders the chosen icon. It also works on plain *string*
  and *list_string* fields, so you can display an existing text field as an icon
  without changing its storage. You can set a fixed width and/or height (supply
  only one and the other is derived from the icon's aspect ratio).
- **Icon link** — for **link** fields: renders the link with an icon as its
  content instead of text, with options for `rel="nofollow"`, opening in a new
  window, and a token‑replaced title.

### Use icons in templates and code

- **Twig function:** `{{ ex_icon('shopping-cart', { height: 20, class: 'foo' }, 'Show more'|t) }}`
- **Render array:** `['#theme' => 'ex_icon', '#id' => 'arrow', '#title' => t('Show more'), '#attributes' => ['width' => 25]]`
- **Form element:** `['#type' => 'ex_icon_select', …]` gives you a graphical icon
  chooser in a custom form.

### Refresh after editing a sprite

Icon definitions are cached and auto‑cleared when modules or themes are installed
or uninstalled. After editing a sprite's contents, clear them manually:

```bash
drush cache-clear ex-icons
```

## Where it lives in the admin menu

There is **no dedicated settings page**. You work with External-use Icons through
the **Manage fields** / **Manage form display** / **Manage display** screens of
your content types (to add and show Icon fields), through your theme's or module's
`dist/icons.svg` file, and — for developers — through the Twig function and render
element.

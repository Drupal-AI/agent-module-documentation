# UI Styles — manual setup guide

**UI Styles** (`ui_styles`) lets modules and themes declare reusable, named sets
of CSS classes — "styles" — in a small YAML file, and then exposes those styles as
a friendly selector that site builders can use to apply the classes to blocks,
Layout Builder sections, views, regions, CKEditor content, and more. In short, it
turns a design system's utility classes (think Bootstrap's `text-primary`,
`bg-dark`, `rounded`) into a curated dropdown of "approved" options, instead of a
free‑text class field where editors can type anything.

Under the hood, UI Styles discovers style definitions from any `*.ui_styles.yml`
file shipped by an enabled module or theme. Each definition has a label, an
optional category, and a list of options whose keys are the actual CSS classes to
add and whose values are the labels shown in the UI. Builders pick options through
a shared form element; their choices are stored as a small `{ selected, extra }`
mapping wherever the relevant integration keeps its config, and at render time the
chosen classes are injected onto the element. A separate stylesheet generator can
even produce a stripped‑down preview stylesheet so the CKEditor iframe and the
styles library page show the real look of each class.

The **base module ships no admin UI of its own** — there is no settings page. Its
job is discovery and the reusable selector. The actual integration points come
from the many optional **submodules**, and the styles themselves come from YAML
files you (or a theme/distribution) provide. UI Styles requires **PHP 8.3+** and
the `sabberworm/php-css-parser` library, and runs on Drupal 10.3 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and the submodules you need.

## Where it lives in the admin menu

The base UI Styles module has **no configuration page** (`configure` is null).
Instead, the style selector shows up wherever a submodule wires it in — on the
block configuration form, in Layout Builder section settings, in a view's display
options, in the CKEditor 5 toolbar, and so on. There is a read‑only *styles
library* page (provided by the `ui_styles_library` submodule) that lists every
declared style and option for documentation and QA.

## How to use it

There are two halves to getting value from UI Styles:

**1. Define some styles.** Add a file named `<provider>.ui_styles.yml` to the root
of an enabled module or theme, listing your classes. For example, in a theme:

```yaml
# my_theme.ui_styles.yml
text_color:
  label: 'Text color'
  category: 'Colors'
  options:
    text-primary: 'Primary'
    text-danger: 'Danger'
    text-muted: 'Muted'
```

The `options` **keys are the CSS classes** that get added; the values are the
labels shown in the selector. Run `drush cr` after adding or editing the file so
discovery picks it up. Styles provided by a module are offered for every theme;
styles provided by a theme are only offered when that theme (or a subtheme of it)
is active.

**2. Enable the integration you want and apply the styles.** Turn on the
submodule for each place you want the selector to appear (see the table below),
then edit a block, Layout Builder section, view, etc., and pick your styles from
the grouped selector that now appears there.

## Submodules — enable only what you need

| Submodule | What it adds |
|-----------|--------------|
| **`ui_styles_block`** | Apply styles to individual blocks in the block layout. |
| **`ui_styles_layout_builder`** | Apply styles to Layout Builder sections and the regions inside them. |
| **`ui_styles_views`** | Apply styles to a view's rows, exposed filter form, or pager. |
| **`ui_styles_page`** | Apply styles to theme regions (header, content, footer) per theme. |
| **`ui_styles_entity_status`** | Add a visual treatment to unpublished content so editors can spot it. |
| **`ui_styles_ckeditor5`** | Let authors wrap content in a named style from the CKEditor 5 toolbar. |
| **`ui_styles_ui_patterns`** | Expose UI Styles class selection as a UI Patterns source. |
| **`ui_styles_library`** | A "styles library" page listing every declared style/option, plus preview support. |

Enable them individually, for example:

```bash
drush en ui_styles_block ui_styles_layout_builder -y
```

Developers can also add classes to any render array in code via the style plugin
manager's `addClasses()`, or alter discovered definitions with
`hook_ui_styles_styles_alter()` — see the [`agent/`](../agent/start.md) docs.

# UI Examples — manual setup guide

**UI Examples** (`ui_examples`), part of the UI Suite, gives theme developers a
browsable **Examples library**: a catalog of small render-array snippets that
each module or theme can contribute, rendered by your active theme so you can
preview how standard Drupal elements and design-system components actually look.
Instead of hunting for a page that happens to show a table, a blockquote, or a
status message, you open one library page and see them all, side by side, styled
by your theme.

Examples are declared as **YAML plugins**, not PHP classes — any enabled module
or theme can ship them. Each example has an id, a label, a category, a weight,
and a `render` array (the thing that gets displayed). Because it is just YAML,
front-end developers can add reference elements without writing code, and can
even demonstrate a Single Directory Component with its slots, or a layout with
its regions. The module groups examples by category and lets you view any one on
its own to inspect its markup and styling.

There is no settings page and nothing to configure — enabling the module gives
you the library, and you populate it by writing example YAML (or by installing
the bundled defaults submodule). This is a developer/theming tool, so this guide
folds the "how to use it" notes into this page rather than a separate
configuration chapter.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the full YAML plugin format and the alter
hook — read the sibling [`agent/`](../agent/start.md) docs, especially
[`agent/plugins/examples.md`](../agent/plugins/examples.md).

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the defaults submodule.

## How to use it

- **Browse the library.** After enabling the module, go to **Appearance → UI →
  Examples** (`/admin/appearance/ui/examples`) to see every registered example
  grouped by category. A parent **UI libraries** page at `/admin/appearance/ui`
  aggregates any sibling UI Suite libraries (styles, components, icons,
  patterns) you have installed.
- **View one example on its own** at `/admin/appearance/ui/examples/{name}` to
  inspect its rendered markup in isolation.
- **Add your own examples.** In any module or theme, create either
  `ui_examples/<anything>.ui_examples.yml` or a root
  `<extension>.ui_examples.yml` file, and describe each example (`id`, `label`,
  `description`, `category`, `weight`, optional `links`, and a `render` array).
  For readability you may omit the `#` prefix on render-array keys — the module
  restores it before rendering. Clear caches and your examples appear in the
  library.
- **Access.** The library pages are gated by the **Access UI examples library**
  permission (`access_ui_examples_library`). Note that the module's update path
  grants this permission to *every* role, because the pages only ever show
  developer-authored demo render arrays — no user data is exposed.

## Where it lives in the admin menu

Everything is under **Appearance → UI** (`/admin/appearance/ui`), with the
examples list at **Appearance → UI → Examples**
(`/admin/appearance/ui/examples`).

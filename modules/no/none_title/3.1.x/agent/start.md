<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# None Title (none_title) — agent index

Suppresses a node's title from display when an editor types the literal string **`<none>`** into the
title field. Depends only on core `node`. Version **3.1.0**. Core requirement `^9.1 || ^10 || ^11`.
No configuration, no permission, no routes, no config schema, no Drush commands.

## What it actually does

The title field stays **required**, and the editor still fills it in — with the exact string
`<none>` (leading/trailing whitespace is trimmed and ignored). The value is stored on the node as-is.
Display is then suppressed by two hooks in `none_title.module`:

1. **`none_title_preprocess_field()`** — on every rendered field, when `#field_name == 'title'` and
   `#object` is a `NodeInterface`, any item whose trimmed value equals `<none>` has its rendered
   `#context['value']` rewritten to `''`. Effect: the node page `<h1>` renders empty.
2. **`none_title_views_plugins_field_alter()`** — replaces the Views `field` plugin class globally
   with `Drupal\none_title\Plugin\views\field\EntityField` (`src/Plugin/views/field/EntityField.php`).
   Its `getItems()` calls the parent then `unset()`s any item whose field is `title` and whose raw
   value is `<none>`. Effect: the title cell in Views listings (e.g. `admin/content`) comes out empty.

There is **no** config form, submit handler, token pattern, or auto-generation. `<none>` is real
stored data, not a computed placeholder.

## Where the sentinel still leaks through (by design)

`<none>` is the entity **label**, so it still appears anywhere the label is read directly instead of
rendered via the title field or a Views field handler: the HTML `<title>` element and Open Graph
title, breadcrumbs and menu links, entity-reference autocomplete and rendered reference labels, and
the search index. Callers that need those blanked must handle them separately.

## Gotchas

- The Views alter overrides the **global** `field` handler class for *all* fields, so it can conflict
  with another module that overrides the same `field` plugin.
- An accessible page still needs a heading — only hide the `<h1>` if the words are marked up as a
  heading somewhere else.
- `hook_help` renders `README.md` (raw `<pre>` unless the contrib `markdown` module is enabled).

## Files
- `data.json` — metadata.
- `usage.md` — short / dense / use-case bullets.
- Source of truth: `none_title.module`, `src/Plugin/views/field/EntityField.php`.

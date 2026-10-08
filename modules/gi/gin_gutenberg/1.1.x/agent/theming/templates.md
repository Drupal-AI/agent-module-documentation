<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: what Gin Gutenberg adds

All logic is in `src/Hook/GinGutenbergHooks.php` (with `#[LegacyHook]` shims in `gin_gutenberg.module`).
Everything below fires only on Gutenberg-enabled node forms with a Gin/Claro theme (see
[../configure/setup.md](../configure/setup.md)).

## Library

- `gin_gutenberg/gin_gutenberg` (defined in `gin_gutenberg.libraries.yml`): `dist/gin_gutenberg.js` +
  `dist/gin_gutenberg.css`. Attached by `page_attachments_alter` and `form_node_form_alter` (only when
  `_gin_gutenberg_gin_is_active()`), not site-wide.

## HTML/body class

- `preprocess_html` adds `gutenberg--enabled` to `$variables['attributes']['class']` (the `<html>` tag)
  on `entity.node.edit_form` / `node.add` when Gutenberg is enabled for the entity. Gin's CSS keys off
  this class.

## Page templates (theme hooks + suggestions)

- `hook_theme` registers two templates (in this module's `templates/`):
  - `page__node__edit__gutenberg` → `page--node--edit--gutenberg.html.twig`
  - `page__node__add__gutenberg` → `page--node--add--gutenberg.html.twig`
- `hook_theme_suggestions_page_alter` adds those suggestions on the edit/translation-add and add
  routes when Gutenberg is enabled for the node/type.
- Both templates receive a `node_type` variable (via `preprocess_page__node__...__gutenberg` →
  `_gin_gutenberg_get_node_type()`).

## Node-form structural changes (`form_node_form_alter`)

- Opens the `metabox_fields` field group (`#open = TRUE`).
- Moves the core **status** (Published) element out of its default group into the Gutenberg **`meta`**
  sidebar pane (`$form['meta']['status']`, weight 1).
- Adds a `#process` callback `processGutenbergSidebar` that, on the content-translation add form of a
  moderated full-Gutenberg type:
  - pins the advanced container's HTML id back to `edit-advanced` (Drupal's id-uniquifier otherwise
    renames it to `edit-advanced--N`, blanking Gutenberg's sidebar), and
  - reparents the `moderation_state` control (grouped or bare) into the `meta` pane.

## No theme functions/preprocess beyond the above

There are no render elements or theme functions to call programmatically; this module only reshapes and
restyles the existing node form. To change the look further, override the two Twig templates in your
theme or add CSS scoped to `.gutenberg--enabled`.

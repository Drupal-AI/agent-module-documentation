<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activate the Gin Gutenberg integration

Gin Gutenberg has **no configuration form or config object of its own**. You do not configure this
module — you satisfy the conditions under which its hooks fire. It stores nothing.

## The two activation conditions

The integration attaches on a node add/edit form only when BOTH helpers return true:

1. **Gutenberg full editing is enabled for the content type** — `_gin_gutenberg_is_gutenberg_enabled($entity)`
   reads `gutenberg.settings:<node_type>_enable_full`. This is **Gutenberg's** config, set at
   *Structure → Content types → (type) → Edit* ("Enable Gutenberg experience for this content type"),
   route/UI provided by the `gutenberg` module — not by gin_gutenberg.
2. **A Gin- or Claro-based theme is active and the user may use Gutenberg** — `_gin_gutenberg_gin_is_active()`
   requires the `use gutenberg` permission (from the gutenberg module) and that the effective admin (or
   frontend) theme has `gin` or `claro` in its base-theme chain.

So the practical checklist to see the Gin-styled Gutenberg editor:
- Enable modules `gutenberg` and `gin_gutenberg`.
- Set the admin theme to **Gin** (or Claro) at `admin/appearance` (`system.theme:admin`).
- Turn on the Gutenberg experience for the content type (sets `gutenberg.settings:<type>_enable_full`).
- Grant the editing role the `use gutenberg` permission.

## Enable Gutenberg for a content type with Drush (example)

```php
// drush php:eval — turn on full Gutenberg for the Article type (Gutenberg's own flag)
\Drupal::configFactory()->getEditable('gutenberg.settings')
  ->set('article_enable_full', TRUE)
  ->save();
```

Once that flag is TRUE and the admin theme is Gin/Claro, gin_gutenberg's hooks add the
`gutenberg--enabled` class, attach its library, and swap in its page templates automatically on the
Article add/edit forms — see [../theming/templates.md](../theming/templates.md).

## Routes the integration recognises as a content form

`node.add`, `entity.node.edit_form`, `entity.node.content_translation_add`,
`quick_node_clone.node.quick_clone`, plus any form whose `base_form_id` is `node_form`
(`_gin_gutenberg_is_content_form()`); media-library widget/exposed-filter forms are excluded.

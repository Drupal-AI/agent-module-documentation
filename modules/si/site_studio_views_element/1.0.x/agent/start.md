<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Studio Views Element (site_studio_views_element) — agent index

Adds one Acquia Site Studio (Cohesion) custom element, **"Drupal View"** (plugin id
`site_studio_views_element`), that lets an author select a View **block** display and render it inside
a Site Studio component or template. Installed version **1.0.2**. Core `^8 || ^9 || ^10 || ^11`.

## What it is / is not

- **Is:** a single `cohesion_elements` **CustomElement** plugin plus one theme hook + template. That
  is the entire module — no routes, no permissions, no config entities, no config schema, no services,
  no Drush, no submodules, no hooks beyond `hook_theme()`.
- **Is not:** a new plugin type, a Views handler/style, or a standalone block. It provides a plugin
  *instance* of Site Studio's own CustomElement type; it depends on Site Studio to render it.

## Mechanism (read the source, it is ~100 lines)

- `Plugin/CustomElement/ViewsElement::getFields()` builds the element's settings form. It loads every
  `view` config entity, and for each display whose `display_plugin == 'block'` adds an option to a
  single `view_id` select, keyed `view_id:display_id` (label combines View label, display title and
  block description). Only **block** displays are listed — page/feed/attachment/etc. are excluded.
- `ViewsElement::render()` splits the selected `view_id:display_id`, calls `Views::getView($view_id)`,
  `setDisplay($display)`, `execute()`, then `buildRenderable($display)` (with **no `$args`**), and
  returns that render array under `#theme => 'site_studio_views_element'`.
- Output is themed by `templates/site-studio-views-element.html.twig`:
  `<div class="{{ elementClass }}" data-element="site-studio-views-element">{{ elementMarkup }}</div>`.

## Two behaviours worth knowing

1. **No arguments are passed to the View.** `buildRenderable($display)` is called with no `$args`, so a
   display's contextual filters resolve only from their own "Provide default value" settings — not from
   the element config or the surrounding Site Studio context. There is no UI to type arguments.
2. **The manual `execute()` is redundant.** The real render happens through core's `#type => 'view'`
   element (`Drupal\views\Element\View::preRenderViewElement`), which re-executes the display and — key
   point — checks `$view->access($display_id)` before producing output. So the View's access plugin
   **is** enforced at render time; the earlier `execute()` just runs the query once more than needed.

## Dependencies

`cohesion` (Site Studio's Drupal side) and `drupal:views` are hard module dependencies;
`acquia/cohesion: ^6.8 || ^7 || ^8` is the composer requirement. Site Studio is Acquia's commercial
product and needs a licence — this module is only useful where that stack is already installed. The
`^8..^11` core range is intent, not test evidence; the element API belongs to Site Studio and versions
independently, so verify against the installed Site Studio/Cohesion version.

## Detail docs

- [plugins/views-element.md](plugins/views-element.md) — the `ViewsElement` CustomElement plugin:
  the settings field, the render path, block-display filtering, arguments, and access behaviour.
- [theming/site-studio-views-element.md](theming/site-studio-views-element.md) — the `hook_theme()`
  hook, template variables, and how to override the wrapper.

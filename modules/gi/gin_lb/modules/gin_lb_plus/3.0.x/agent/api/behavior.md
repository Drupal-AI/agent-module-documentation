<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What gin_lb_plus does (and the code that does it)

Pure UI layer. No services you call, no config, no plugins. Everything is driven by three
hook implementations in `gin_lb_plus.module` plus one event subscriber.

## 1. `LayoutBuilderBrowserEventSubscriber` (the main piece)

`src/EventSubscriber/LayoutBuilderBrowserEventSubscriber.php`, registered as
`gin_lb_plus.layout_choose_controller_alter`, subscribes to `KernelEvents::VIEW` at **weight 45**
(args `@extension.list.module`, `@file_url_generator`). It mutates two controller results by route:

- **`layout_builder.choose_section`** → replaces the flat layout list with a `field_group`
  `horizontal_tabs` element holding two tabs:
  - **Sections** — the original `$build['layouts']['#items']`, each given
    `#theme = gin_lb_plus_icon`, `#icon_type = section`, and the layout's `plugin_id`; labels get
    class `gin-lb-plus-link__label`.
  - **Library** — `getLibrarySectionLinks()`: `SectionLibraryTemplate::loadMultiple()` rendered as
    links to `section_library.import_section_from_library` (off-canvas AJAX when the request is
    AJAX), each with the template image or the bundled `images/section-empty-icon.svg`. The tab is
    `#access` only when at least one template exists.
- **`layout_builder.choose_block`** → converts `$build['block_categories']` to
  `#type = horizontal_tabs`; every block link gets `#theme = gin_lb_plus_icon`,
  `#icon_type = block`, a `gin-lb-plus-link__label` wrapper, and the core
  `layout-builder-browser*` classes are stripped in favour of `gin-lb-plus`. Only runs when the
  build has no `add_block` key (i.e. the category chooser, not the block form).

## 2. `gin_lb_plus_form_alter()`

- On a node's `node_<bundle>_layout_builder_form`: adds `$form['actions']['add_to_library']`, a
  link to route `section_library.add_template_to_library` (storage type `overrides`, the node's
  `entity_type.id`, delta 1) rendered as an off-canvas AJAX button
  (`glb-button gin-lb-plus-button use-ajax`), gated by that route's access. Also adds the Gin LB
  button classes to an existing `move_sections` action.
- On `section_library_add_template_to_library` / `section_library_add_section_to_library`: sets
  `#gin_lb_form = TRUE`, class `glb-form`, and an `#after_build` of
  `Drupal\gin_lb\HookHandler\FormAlter::afterBuildAttachGinLbForm` so the form inherits gin_lb styling.

## 3. `gin_lb_plus_page_attachments()`

Attaches library `gin_lb_plus/core` when
`gin_lb.context_validator->isLayoutBuilderRoute() && ->isValidTheme()` — i.e. on a Layout Builder
route and only when the active theme is **not** Gin. That library (`gin_lb_plus.libraries.yml`)
bundles `css/gin-lb-plus.core.css`, `.lb.css`, `.link.css` and depends on
`field_group/element.horizontal_tabs`.

## 4. `gin_lb_plus_icon` theme hook

The module's only `hook_theme()` entry (template `templates/gin-lb-plus-icon.html.twig`,
variables `uri`, `icon_type`, `plugin_id`, `width`, `height`, `svg`, `alt`).
`gin_lb_plus_preprocess_gin_lb_plus_icon()` fills a default `uri` from
`images/block-empty-icon.svg` or `images/section-empty-icon.svg` (by `icon_type`) when none is set.

## What it does NOT provide

No config object or schema, no settings form / `configure` route, no permissions, no Drush,
no plugin types, and **no `*.api.php`** (it invites no hooks of its own). To change its behaviour
you override the `gin_lb_plus_icon` template or the `gin_lb_plus/core` CSS, or you populate
`section_library_template` entities to fill the **Library** tab.

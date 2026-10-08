<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Display Processor adds a plugin type that lets you select and configure, per entity view mode, a single plugin that alters and decorates the rendered entity.

---

Entity Display Processor is a small developer framework that turns ad-hoc `hook_entity_view_alter()` code into reusable, configurable plugins. It defines an "Entity display processor" plugin type (attribute-discovered from each module's `Plugin/EntityDisplayProcessor` namespace) and a plugin manager. It extends the Field UI "Manage display" form so a site builder can pick up to one processor plugin for a given entity type, bundle and view mode and configure its settings; the choice is stored as a third-party setting on the `entity_view_display` config entity. When an entity is later rendered in that view mode, a `hook_entity_view_alter()` implementation loads the configured plugin and runs its `process()` method over the build render array, so the plugin can add classes, wrap the output, or apply effects driven by the entity's field values. The module ships one example plugin ("Add custom classes"); the design intent is that you write more in your own modules, themes, or in-house ecosystem. It requires Drupal 11 and PHP 8.3 and has no other dependencies. It has no settings page and no permissions of its own; configuration is per view mode on Manage display.

---

- Add a CSS class to an entity's outer HTML element for a specific view mode without writing a custom module.
- Apply a decorative CSS effect (shadow, background color, border) to entities in a given view mode.
- Turn a one-off `hook_entity_view_alter()` tweak into a reusable, configurable plugin.
- Ship a display effect as part of a contrib module by providing an EntityDisplayProcessor plugin.
- Give site builders a per-view-mode "processor" selector at the bottom of Manage display.
- Wrap a rendered entity in an expand/collapse box (via a custom processor plugin).
- Drive a display effect dynamically from a field value (for example a frame whose color comes from a field).
- Add a bundle-and-view-mode-specific wrapper element around teaser output.
- Standardize display decorations across a project as installable plugins instead of copy-pasted alter hooks.
- Apply an effect that is independent of Layout Builder or Display Suite layouts.
- Attach marketing/utility CSS classes to card or teaser displays for theming hooks.
- Add data-* attributes or wrappers needed by front-end JS to specific view modes.
- Provide an alternative to full Display Suite for lightweight display tweaks.
- Configure the "Add custom classes" plugin to append space-separated classes to an entity's render element.
- Store display-processor choices in configuration so they export/deploy with the site.
- Build a library of in-house display processors reused across content types and view modes.
- Let non-developers toggle a display effect by selecting a plugin, without touching code.
- Keep display logic out of templates by moving decoration into a plugin's `process()` method.
- Reuse the internal drilldown form element (select + AJAX subform) pattern for plugin-configuration UIs.
- Add per-view-mode CSS classes to media, taxonomy term, or user displays (any fieldable entity view display).
- Provide a consistent extension point for display-only rendering changes across a multisite platform.
- Replace scattered theme preprocess overrides with a discoverable, configurable processor plugin.
- Prototype display effects quickly by writing a small plugin class and selecting it in the UI.
- Package a client-specific display treatment as a plugin so it can be enabled per project.
- Apply an accessibility-oriented wrapper or class set to entities in a chosen view mode.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stacks is a component/page-building system. Editors build reusable "widgets" (field-based content chunks) and place them, in order, on an entity through a "Stacks" field. Each widget's HTML is fully controlled by Twig template variations that live in your theme.

---

Stacks gives site builders a widget/component model instead of layout builder or paragraphs. A widget bundle (`widget_entity_type`, a config entity) defines the fields for one kind of component; a `widget_entity` is a saved instance of those field values; a `widget_instance_entity` wraps that instance on a host entity and carries per-placement settings (title, position, reusable/shareable flag). You add the field type `stacks_type` (label "Stacks") to any content type or entity — its form widget lets editors add/reorder/edit widgets inline, and its formatter renders them. Which widget bundles are offered on a given field, and which are auto-added as position-locked or position-optional "required" widgets, is chosen per field in Manage form display. Presentation is entirely template-driven: for each widget bundle you create `stacks/<machine-name-with-dashes>/templates/<name>--<variation>.html.twig` files in your theme (never in the module), plus optional preview images and per-template "theme" style options declared in `stacks.settings.yml`. A separate `widget_extend`/`widget_extend_type` entity pair provides repeatable sub-item bundles used mainly by the Content List submodule. The module also exposes several Twig functions/filters (image, view_mode, getView, pagination, block_embed, widget_instance_embed, getStacksPath) and alter hooks so developers can shape widget output and queries.

---

- Build a marketing/landing page from reusable components (hero, feature grid, CTA, quote) without a fixed content type per layout.
- Give editors drag-to-reorder, inline-edited content blocks on a node body area via a single Stacks field.
- Define a "Text Widget" or "Custom HTML Widget" component (both ship as example bundles) and reuse it across many pages.
- Create a widget bundle with exactly the fields a component needs (image + title + description) and hand-write its markup in a theme Twig template.
- Offer several visual variations of the same widget (e.g. `default`, `white-on-blue`) as template files, selectable per placement.
- Add per-variation "theme" style options (extra CSS class / conditional markup) configured in `stacks.settings.yml`.
- Auto-inject required widgets into every node of a type (position-locked banners, position-optional intros) so editors cannot forget them.
- Mark a widget instance as shareable/reusable so the same saved instance appears across multiple nodes; non-reusable ones are deleted with their host.
- Group related widget bundles under a "widget type group" (e.g. everything named `contentfeed_*`) for a tidier editor picker on large sites.
- Embed one widget instance inside another widget's template with the `widget_instance_embed()` Twig function.
- Embed a Drupal block inside a widget template with `block_embed()`.
- Render a referenced entity in a chosen view mode from a widget template using the `view_mode`/`getView` filters.
- Reference the theme's Stacks asset path in a template with the `getStacksPath` filter (e.g. for images/JS local to the widget).
- Build an editor-friendly component library that non-developers manage while developers own the markup.
- Alter final widget render arrays globally via `hook_stacks_output_alter()`.
- Skip rendering specific widgets conditionally via `hook_stacks_pre_output()`.
- Manage all widget bundles, extend bundles, saved widgets and instances from the Structure > Stacks admin hub.
- Extend the system with a custom `WidgetType` plugin when a widget needs PHP-driven behavior beyond plain fields (see the Content Feed submodule as the reference implementation).
- Reduce content-type bloat on large sites by expressing one-off page sections as widgets instead of new content types.
- Provide clients a controlled set of on-brand building blocks whose HTML you fully own in the theme.

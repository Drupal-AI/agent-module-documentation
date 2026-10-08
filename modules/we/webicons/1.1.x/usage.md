<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web Icons bundles three icon libraries — Boxicons, Font Awesome Free and Material Icons — and lets you use them two ways: as a field you add to any entity, with an AJAX icon-picker widget, and as a `webicon()` Twig function you can call directly from a template.

---

The module ships each library's CSS/fonts and exposes them through a `webicons_field` field type (widget `webicons_field`, formatter `webicons_field_default`) bound to one library per field, plus the `webicon()` Twig function from `WebiconsTwigExtension` for template-side use. Both paths render through the same `webicon_field__value` template, emitting icon-font markup — an `<i>` for Boxicons and Font Awesome, or a `<span>` carrying a Material Icons ligature — rather than inline SVG. A resolver service `webicons.service` maps a library id to a per-library factory service (`webicons.boxicons`, `webicons.fortawesome`, `webicons.materialicons`), each of which extracts its icon list from the bundled asset files and caches it; the picker modal is served at `/webicon-selector`. There is no settings form and no dependency beyond Drupal core (`^9 || ^10 || ^11`). The factory/service design is meant to be extended: define a `webicons.<id>` service with your own `IconFactory` subclass and a picker template to add a fourth library. Note that Drupal 11.1 added an icon API to core, so on a current core check whether that already covers the requirement before adding this or a similar module.

---

- Add an icon field to a content type, taxonomy term or paragraph.
- Let editors pick a Material Icon from a modal dialog.
- Use Boxicons in content without hand-writing markup.
- Store one or many icons per entity with an unlimited-cardinality field.
- Emit an icon from a Twig template with `webicon()`.
- Show an icon beside a link or a card title in a template.
- Standardise the icon set an editorial team can choose from.
- Bind a field to a single library so editors can't mix icon sets.
- Render a Font Awesome solid icon by class from Twig.
- Render a Material Icons glyph by ligature name.
- Add extra CSS classes (size, colour) to an emitted icon.
- Give a design-system component an icon field.
- Add icons to menu or listing items via a field.
- Preview the chosen icon live in the edit form.
- Filter the picker grid by icon name while choosing.
- Reduce bespoke icon markup across templates.
- Bundle Font Awesome / Boxicons / Material Icons without a separate library download.
- Add a fourth icon library by registering a new factory service.
- Support a site still on Drupal 9 or 10.
- Theme the icon output by overriding the value template.

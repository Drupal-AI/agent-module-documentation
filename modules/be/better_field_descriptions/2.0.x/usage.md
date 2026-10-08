<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better field descriptions replaces a field's plain help text on entity edit forms with a themeable description that you can position above the label, below the widget, or between the two, and it edits all of those descriptions from one admin screen instead of one field-settings form at a time.

---

Field help text is the cheapest editorial improvement a site can make and the most neglected, because editing it normally means opening every field's settings form individually, and the result is an unstyled sentence wedged under the widget. This module reworks both halves. It hooks `hook_field_widget_form_alter` on entity forms and injects the description into the widget's `#prefix` or `#suffix` (managed-file widgets use `#field_prefix`/`#field_suffix`); nothing is permanently changed on the field itself and the field's own core description is left untouched. Configuration is a three-step flow under `/admin/config/content/better_field_descriptions`: an **Entities** tab selects which entity types participate, a **Settings** tab (the default form) checkbox-selects which fields per bundle get a better description, and a **Bundles** tab is where the actual text, per-field label, and position (above / below / between title and input) are written, plus the template and a site-wide default label. Descriptions render through a Twig **template** — two ship (`better-field-descriptions-text`, a plain text block, and `better-field-descriptions-fieldset`, which wraps the text in a collapsible `<details>` using the label as legend) and any template dropped into a theme's `templates/` folder is auto-discovered; changing the selected template triggers a theme-registry rebuild. Version **2.0.3**, core `^9.3 || ^10 || ^11`, no dependencies, no config schema, no Drush. Descriptions and labels accept a restricted set of HTML — both the form defaults and the rendered output pass through `FieldFilteredMarkup::create()`, core's limited allowed-tags filter, so a holder of the editing permission can add emphasis, lists and links but not scripts or event handlers. Two permissions gate it: `administer better field descriptions settings` for the field-selection Settings form, and `add better descriptions to fields` for the Entities and Bundles screens where text is written; the latter lets its holder change help text across every bundle on the site, so treat it as an editorial-lead permission rather than a general editor one.

---

- Style field help text properly instead of leaving an unstyled sentence under the widget.
- Move a field's description above its label, or between the label and the input.
- Edit help text for many fields from one admin screen rather than field by field.
- Let editors write their own guidance without giving them field-management access.
- Standardise help text across bundles and content types.
- Add a link, list, or emphasis inside a field's description.
- Wrap a long instruction in a collapsible fieldset with the `fieldset` template.
- Improve usability of a complex content type with clearer per-field guidance.
- Explain a field's expected format or character limit at the point of entry.
- Reduce editorial mistakes by positioning guidance where it is actually read.
- Theme descriptions to match the admin theme via a custom Twig template in the theme.
- Provide a site-wide default label for descriptions and override it per field.
- Give a field description a heading/legend that the core description field cannot.
- Add guidance to a media, file, or reference field's widget.
- Onboard new editors with in-form instructions on the fields that need them.
- Replace the default under-widget description without touching the field config.
- Bulk-review and rewrite all help text before a launch.
- Attach a description to a field that has none, without editing the field settings form.
- Keep the field's own core description intact while adding a themed one alongside it.
- Ship the description configuration as exportable site config (`better_field_descriptions.settings`).
- Position guidance differently per field (above for some, below for others) within one bundle.
- Add guidance to the pseudo `title` field of a bundle, which the field UI cannot describe.

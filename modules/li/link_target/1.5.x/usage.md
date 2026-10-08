<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Target adds a field widget for core's Link field type that lets an editor pick an HTML `target` (e.g. open in a new window) per individual link value, with the set of offered targets restricted per widget instance.

---

The module ships a single field widget plugin, `link_target_field_widget` ("Link with target"), which subclasses core's `LinkWidget`. Selecting it on a link field's *Manage form display* adds a "Select a target" dropdown next to each link item's URL/title inputs, so an editor chooses `_self`, `_blank`, `parent`, or `top` for that specific link value; the choice is written into the field item's own `options.attributes.target` data (the same serialized `options` column core's Link field already stores), so no schema change and no formatter change are needed — core's link rendering already emits any `attributes` present in `options`. Separately, the widget exposes its own widget-level setting, `available_targets`, configured as checkboxes on the widget's settings form; this restricts which of the four target choices appear in every item's dropdown (an empty selection means all four are offered). That setting is persisted as ordinary widget settings (not third-party settings) inside the `entity_form_display` config entity, validated by the module's own config schema. The module defines no formatter, no service, no permissions, no Drush commands, and no hooks — its entire surface is this one widget class.

---

- Let editors open specific links in a new browser tab/window (`_blank`) on a per-link basis.
- Keep some links in the current window (`_self`) while others open elsewhere.
- Restrict a content type's link field so editors can only choose "current window" or "new window", hiding `parent`/`top`.
- Standardize an external-links field so only `_blank` is offered as a target choice.
- Give editors a "Select a target" control on the node edit form for a Basic page's link field.
- Replace ad-hoc `target="_blank"` instructions to editors with an actual widget control.
- Avoid writing a custom field widget just to add a target selector to a link field.
- Apply per-item target choice to a repeating (multi-value) link field, where each link may need a different target.
- Configure the widget on a taxonomy term's link field so term-page links can open in a new tab.
- Configure the widget on a paragraph type's link field used inside Layout Builder or paragraphs content.
- Let a "related resources" link field open external resources in a new window while internal ones stay in `_self`.
- Limit the available targets on a footer "social links" field to just `_blank`.
- Use the widget on a media entity's link field (e.g. a "source" URL) to control target behavior.
- Swap a content type's link field widget from the default `link_default` to `link_target_field_widget` via Manage form display.
- Give a call-to-action button's link field an editor-controlled target without templating logic.
- Configure the widget on a block content type's link field for a "Learn more" button.
- Prevent editors from picking `parent`/`top` targets that rarely make sense for a given field, by limiting `available_targets`.
- Read back which targets are enabled for a field's widget by inspecting `entity_form_display` config.
- Support a multilingual site where editors in different languages independently choose per-link targets.
- Apply the widget to a user profile's "personal website" link field so users choose how it opens.
- Configure the widget on a menu-link-content link field for in-context editing of link targets.
- Use the widget summary on Manage form display to audit at a glance which targets are enabled per field.
- Migrate a site off a custom link-target patch by installing this widget instead.
- Set every field on a content type that uses the Link field type to the target-aware widget in one settings pass.
- Offer only `_self` and `parent` as choices on an intranet field, hiding `_blank`/`top`.
- Allow marketing to add a "new window" toggle to a promo banner's link field without developer involvement.
- Give an editorial team a consistent, discoverable place (the link widget itself) to set link targets, instead of raw HTML attributes.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraph View Mode lets an editor choose, per paragraph item on the entity edit form, which view mode that paragraph renders in — so one paragraph type can be reused with several visual presentations.

---

Enabling the feature on a paragraph type creates a single-value field named `paragraph_view_mode` (field type `paragraph_view_mode`, a subclass of core's `string` item) on that `paragraph` bundle and places it on the bundle's default form display with weight `-100`. The widget (`paragraph_view_mode`) renders a **select** of the view modes an administrator ticked in *Available view modes*, defaulting to the widget's `default_view_mode` setting. At render time `hook_entity_view_mode_alter()` asks the `paragraph_view_mode.matcher.display_mode` service to swap the requested view mode for the value stored in the paragraph's field, so the paragraph is displayed with the editor's choice. A companion `hook_entity_form_mode_alter()` does the same for **form** modes when the widget's *Bind with the form mode* setting is on — combined with the widget's AJAX reload of the paragraph subform, picking a view mode can also switch the edit form to a form mode of exactly the same machine name. The `preview` view mode is deliberately left alone unless the widget's *Apply to preview mode* setting is enabled, so Paragraphs' own preview keeps working. There is **no settings page and no `configure` route**: the on/off switch is a checkbox injected into the paragraph type edit form, and the real source of truth is simply whether the `paragraph_view_mode` FieldConfig exists on the bundle. All of the wiring goes through one service, `paragraph_view_mode.storage_manager`, which creates, places and deletes that field.

---

- Reuse one "Card" paragraph type as a wide card, a compact card and a teaser by letting editors pick the view mode per item.
- Let a content author switch a "Quote" paragraph between a pull-quote and an inline-quote presentation.
- Offer editors two or three approved layouts for a "Columns" paragraph without creating three paragraph types.
- Cut the number of near-duplicate paragraph types (and their field duplication) on a large site.
- Give a "Media" paragraph a "full width" versus "inline" rendering choice.
- Let a hero paragraph be rendered with a dark or light view mode chosen per node.
- Restrict which view modes editors may choose by ticking only some in the widget's *Available view modes*.
- Pin a sensible default with the widget's *Default value* setting so most paragraphs need no editor decision.
- Bind view mode to form mode so choosing "compact" also hides fields that compact rendering ignores.
- Show a different set of edit fields per presentation by creating a paragraph form mode with the same machine name as the view mode.
- Reload the paragraph subform over AJAX the moment the editor changes the view mode select.
- Keep Paragraphs' own back-end preview untouched by leaving *Apply to preview mode* off.
- Deliberately let the chosen view mode also apply to the `preview` mode when the site uses preview as a real display.
- Enable the feature on a paragraph type from code with `\Drupal::service('paragraph_view_mode.storage_manager')->addField($bundle)`.
- Script the rollout across many paragraph bundles in an update hook instead of clicking through the UI.
- Read back which paragraph bundles have the feature by checking for the `paragraph.<bundle>.paragraph_view_mode` FieldConfig.
- Export the choice in configuration (`core.entity_form_display.paragraph.<bundle>.default`) so it deploys with the site.
- Change the allowed view modes per bundle by editing that form display component's `view_modes` setting.
- Migrate content that stored a presentation flag in a custom field over to the module's standard field.
- Query nodes for paragraphs rendered in a particular view mode via the `paragraph__paragraph_view_mode` field table.
- Turn the feature off for a bundle cleanly — deleting the FieldConfig also removes the shared field storage when it is the last instance.
- Let a design system expose only the view modes enabled in *Custom display settings* on the paragraph's Manage display tab.
- Give editors a plain-language select ("Default", "Preview", "Teaser") instead of asking site builders to pre-wire layouts.
- Avoid writing a custom `hook_entity_view_mode_alter()` for a per-item display switch.
- Combine with Layout Builder or a nested paragraph structure where the same component appears at different sizes.

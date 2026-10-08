<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Read-only Field Widget adds a `readonly_field_widget` field widget that, instead of an editable input, renders the field's chosen formatter output as read-only markup directly on the entity edit form.

---

The module provides a single Field Widget plugin (`readonly_field_widget`) that is applicable to virtually every field type, because `hook_field_widget_info_alter()` merges in the field types of every registered formatter. When you assign it to a field on an entity's *Manage form display*, the widget stops rendering an editable input and instead calls the entity view builder to render the field using a formatter you pick in the widget's own settings form (`formatter_type`, plus that formatter's own `formatter_settings`). Widget settings also include `label` (above/inline/hidden/visually hidden), `show_description` (repeat the field's configured description under the read-only markup), and `error_validation` (whether validation errors on the field are still flagged, since a read-only widget normally suppresses them). A `hook_form_alter()` implementation additionally sets `#access` on the field based on the *view* access of the field's items, so a value still shows to users who can view but not edit it, and is hidden entirely from users who lack view access. Because the widget renders nothing when the field is empty, it will not display on brand-new/empty entities unless a default value is set; it also explicitly warns (and empties out the field) when used as the default-value widget on `field_config` add/edit forms, since there is nothing editable to set a default with. It has no configuration route, permissions, Drush commands, or plugin types of its own — its entire persistent state is the widget's `settings` on an `entity_form_display` component, validated by the `field.widget.settings.readonly_field_widget` config schema.

---

- Show a computed or system-managed field (e.g. a UUID, external ID, or sync timestamp) as read-only text on the node edit form instead of an editable box.
- Display an image field using the `image` formatter on the edit form so editors see the actual thumbnail instead of an upload widget, when the image is managed elsewhere.
- Render a taxonomy term reference field with its normal formatter (e.g. entity reference label/rendered entity) so editors can see but not change the assigned terms.
- Show a link field's rendered anchor tag instead of the raw URL/title input widget.
- Present a "Last updated by" or "Created" field to editors as plain read-only text without exposing an editable widget.
- Lock down a field that's set exclusively via a migration or a background process, while still letting content editors see its value on the edit form.
- Show a boolean/checkbox field's formatted On/Off label as static text rather than an editable checkbox.
- Give users with "view" but not "edit" access to a field a way to still see it, since the widget checks `items->access('view')`.
- Display an entity reference field (e.g. related products, related articles) rendered via its normal view formatter on the edit form for context only.
- Render a rich text/long text field's formatted (filtered) output instead of the CKEditor/text area widget, when the body is maintained elsewhere.
- Show a file/document field's file link formatter (name + download link) without exposing a file upload/remove widget.
- Present a date field using a date formatter's human-readable output instead of the date picker widget.
- Combine with `show_description` to keep the field's admin-configured help text visible under the read-only value.
- Combine with `error_validation` enabled so a constraint violation on the field still surfaces to the editor even though the widget isn't directly editable.
- Restrict editing of a workflow-controlled field (e.g. moderation state or status) to a specific form mode while other form modes keep it editable.
- Show a computed price or calculated total field using its formatter, so editors see the number without being able to hand-edit it.
- Freeze a field after initial creation by switching its widget to `readonly_field_widget` on the default form mode once the value is set.
- Use different formatters per form mode: an editable widget on the default form, a compact read-only formatter on a "quick edit" form mode.
- Display a taxonomy term's icon/color field as rendered markup on the term edit form for reference while other fields stay editable.
- Show a computed geolocation/coordinates field rendered as a map or formatted text instead of raw lat/long inputs.
- Present a media field's rendered thumbnail/embed on the edit form for context without allowing the media reference to be changed there.
- Configure the widget via `drush php:eval` or exported config for deployment automation, since there is no settings UI page.
- Audit which fields on a bundle are locked to read-only on the edit form by inspecting the `entity_form_display` component types.
- Keep a "read receipt"/analytics counter field visible to content managers as static text without an editable number field.
- Show a taxonomy vocabulary's parent term reference as rendered output rather than an editable term-reference autocomplete.

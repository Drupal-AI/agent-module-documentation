<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a field widget that lets editors attach a DSFR icon to a core Link field.

---

`dsfr4drupal_picker_link` is a submodule of DSFR for Drupal - Picker. It provides the `dsfr4drupal_picker_link_icon` field widget ("Link with DSFR icon") for core `link` fields. The widget (`LinkIconWidget`) extends core's `LinkWidget` and mixes in the parent module's `PickerWidgetTrait`, so the standard URL/title link form gains a DSFR icon picker plus its settings (search input, allowed icon groups, required). The chosen icon's machine name is stored inside the link item's `options` array under an `icon` key, which the module registers on the link value schema via `hook_config_schema_info_alter()`. A config-schema entry also declares the widget and formatter settings. Enable it to let content editors pair an icon with a link without a separate field.

---

- Let editors pick a DSFR icon for a menu-style or call-to-action link stored in a core Link field.
- Add an icon to "read more" / "download" style links without adding a second field.
- Reuse an existing core `link` field and just switch its form widget to "Link with DSFR icon".
- Restrict the icons offered on a given link field to specific DSFR groups (widget setting).
- Toggle the picker's live search input on a per-widget basis.
- Make the icon selection required on a link field via the widget's `icon_required` setting.
- Store the selected icon machine name inside the link item's `options.icon` for theming.
- Keep link data portable: the icon travels with the link value, not in a separate table.
- Build DSFR-styled navigation blocks where each link carries its own leading icon.
- Provide consistent iconography across CTA buttons rendered from link fields.
- Configure the widget through the field's "Manage form display" settings summary.
- Combine with the parent module's icon groups and any custom groups added by other submodules.
- Migrate link content and retain the icon assignment as part of the field value options.
- Give site builders an icon-aware link field without writing a custom widget.
- Use the same DSFR icon catalogue in link fields that the picker exposes elsewhere.
- Validate icon selection at the field level using the widget's required/allowed-groups settings.

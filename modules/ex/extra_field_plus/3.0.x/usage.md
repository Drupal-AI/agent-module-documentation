<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Field Plus extends the Extra Field module so that "extra fields" (pseudo-fields defined in code) can carry their own editable display settings — a per-instance settings form with a cog on Manage display, just like a real field formatter.

---

Plain [Extra Field](https://www.drupal.org/project/extra_field) plugins render computed/pseudo fields but have no configurable settings. Extra Field Plus adds that missing layer: an interface (`ExtraFieldPlusDisplayInterface`) and two base plugin classes — `ExtraFieldPlusDisplayBase` (raw output) and `ExtraFieldPlusDisplayFormattedBase` (wrapped in the standard field template) — that your plugin extends. You implement two static methods, `extraFieldSettingsForm()` (the FAPI settings elements) and `defaultExtraFieldSettings()` (their defaults), and optionally a `settingsSummary()`. The module's `hook_form_entity_view_display_edit_form_alter()` injects a cog/settings form for each such extra field into the *Manage display* form, and its submit handler saves the chosen settings into the `entity_view_display` component (`settings` array, with `type` set to the field machine name so a config schema can validate it). At render time your plugin reads them via `getEntityExtraFieldSettings()` / `getEntityExtraFieldSetting($key)` (or the static `getExtraFieldSetting(...)`). Layout Builder is supported too: settings are stored on the `extra_field_block` section component (`extra_field_plus_settings`). A report at *Reports → Extra Field Plugins List* (`/admin/reports/extra_fields`, permission `administer site configuration`) lists all discovered plugins. There is no module settings page. Plugins live in `your_module/src/Plugin/ExtraField/Display/` and use Extra Field's `@ExtraFieldDisplay` annotation. Version 3.x renamed the plugin methods (see UPGRADE.md) — old `settingsForm()` / `defaultFormValues()` are deprecated in favour of the static `extraFieldSettingsForm()` / `defaultExtraFieldSettings()`.

---

- Give a code-defined pseudo-field a per-display settings form (like a formatter has).
- Let site builders configure an extra field differently per view mode (teaser vs full).
- Add a "wrapper HTML tag" option to a custom extra field's display.
- Add a "link to entity" checkbox to a computed field's output.
- Show a settings summary next to an extra field on Manage display.
- Build an extra field that renders inside the standard field template (label, wrappers).
- Build an extra field that outputs raw markup with no field wrapper.
- Store extra-field display settings in the `entity_view_display` config for deployment.
- Configure extra-field settings inside Layout Builder (per section component).
- Read an extra field's configured setting at render time via the plugin's helper methods.
- Provide validated settings via a config schema keyed by the field machine name.
- Migrate 8.x-1.x / 8.x-2.x extra field plugins to the 3.x static-method API.
- Audit all extra field plugins on the site from the Extra Field Plugins List report.
- Expose a computed "related items count" pseudo-field with a display-limit setting.
- Add a toggle to show/hide part of a custom extra field per bundle.
- Reuse one extra field plugin across many bundles with per-bundle settings.
- Offer editors choice of heading level for a computed title extra field.
- Provide default settings so an extra field renders sensibly before configuration.
- Keep extra-field configuration out of code and in per-display config instead.
- Base a team's custom pseudo-field library on a consistent settings pattern.
- Combine with Extra Field's discovery to add settings without changing plugin placement.

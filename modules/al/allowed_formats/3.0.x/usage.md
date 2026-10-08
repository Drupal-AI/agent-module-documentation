Adds per-field-widget checkboxes that hide the "About text formats" help link and the text-format guidelines shown beneath formatted-text (text, text_long, text_with_summary) fields, and provides an update path that migrates old allowed-formats settings into Drupal core.

---

Historically the Allowed Formats module let site builders restrict which text formats were available on each formatted-text field. Since Drupal 10.1.0 that restriction is a core field-setting feature, so the 3.x branch removes it and instead focuses on a smaller, still-useful capability: cleaning up the text-format selector UI. On the form-display widget settings for `text`, `text_long`, and `text_with_summary` fields it exposes two third-party-settings checkboxes — "Hide the help link *About text formats*" and "Hide text format guidelines" — implemented via `hook_field_widget_third_party_settings_form()` and an `#after_build` callback that unsets the `help` and `guidelines` render elements. When both are hidden and only one format is available, it also removes the surrounding format wrapper entirely. The module ships config schema for these third-party settings so they export cleanly with your form display configuration. It also provides post-update hooks and a `field_config` presave hook that convert legacy `allowed_formats` third-party settings into the core `allowed_formats` field setting, giving existing sites a clean upgrade path. It has no admin page, no permissions, no services, and no Drush commands — all configuration lives on the Manage form display screen per field.

---

- Hide the "About text formats" help link under a body field to simplify the authoring UI.
- Remove text-format guidelines shown beneath a formatted-text field.
- Present a cleaner comment or CKEditor field with no format explanation clutter.
- Strip the format selector wrapper when only a single format is allowed on a field.
- Tidy the node edit form for non-technical content editors.
- Reduce visual noise on multi-field forms with many formatted-text areas.
- Configure hide-help and hide-guidelines independently per field widget.
- Apply the setting only to specific form modes via Manage form display.
- Keep the format `<select>` while hiding just its help text.
- Export the hide settings as configuration so they deploy across environments.
- Migrate pre-10.1 allowed-formats field settings into Drupal core's field setting.
- Provide an upgrade path when moving from the 1.x/2.x branch to 3.x.
- Convert legacy checkbox-array format storage into a clean sequence.
- Clean up a text_with_summary (body) widget's help and guidelines together.
- Simplify a long-text field used for internal notes.
- Improve accessibility by removing redundant descriptive text.
- Standardize the look of formatted-text fields across many content types.
- Hide format guidance on fields where only trusted editors work.
- Streamline a paragraphs component's rich-text field.
- Remove guidelines from a field embedded in a compact inline form.
- Keep the authoring experience consistent when using a single Full HTML format.
- Suppress format help on webform-like custom entity text fields.
- Reduce confusion for editors who should not switch text formats.
- Declutter a media caption or description field.
- Ensure exported form-display config carries the hide settings via config schema.

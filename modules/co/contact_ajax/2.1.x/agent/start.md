# Contact Ajax — agent index

Makes core contact forms submit via AJAX and configures what shows after submit. Depends on core
`contact`. No settings page (`configure` null), no permissions, no Drush, no plugin types. All options
are **third-party settings** on each `contact.form.*` config entity.

- **The per-form settings, confirmation types, and how to set them (UI + config)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Settings live under `contact.form.<id>.third_party.contact_ajax` (schema
  `contact.form.*.third_party.contact_ajax`), edited from a "Contact ajax" fieldset on the contact
  form's edit page.
- Keys: `enabled` (bool), `confirmation_type` (int 1–4), `load_from_uri` (node id),
  `load_from_message` (text_format), `prefix_id` (string), `render_selector` (string).
- Confirmation type constants (in `contact_ajax.module`): `1` default message, `4` message + empty
  form, `2` node content, `3` custom message.
- AJAX callback: `contact_ajax_contact_site_form_ajax_callback` returns an `AjaxResponse` that
  replaces/injects the form wrapper; errors are returned inline.

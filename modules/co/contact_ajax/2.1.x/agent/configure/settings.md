# Configure Contact Ajax (per contact form)

No global settings. Options are third-party settings on each contact form, edited via the **"Contact
ajax"** fieldset at *Structure → Contact forms → (edit a form)* (`admin/structure/contact/manage/<id>`).
Added by `hook_form_contact_form_form_alter()` and saved by the entity builder
`contact_ajax_contact_form_form_builder()`.

## Settings (`contact.form.<id>.third_party.contact_ajax`)

| Key | Type | Form field | Meaning |
|---|---|---|---|
| `enabled` | boolean | "Ajax Form" | Submit this contact form via AJAX. |
| `confirmation_type` | integer | "On submit load" | What replaces the form after a successful submit (see below). |
| `load_from_uri` | integer (nid) | "Node to load" | Node whose full view is rendered when type = 2. |
| `load_from_message` | text_format | "Message to load" | Custom formatted message shown when type = 3. |
| `prefix_id` | string | Advanced → "Prefix id" | Custom id for the wrapper div (default `contact_ajax_<form_id>`). |
| `render_selector` | string | Advanced → "Render into this HTML element class/id" | CSS selector (e.g. `.render-here`, `#render-here`) to inject the response into; the original form is then removed from its place. |

The `load_from_uri` / `load_from_message` / advanced fields are shown conditionally (`#states`) based on
`enabled` and the chosen `confirmation_type`.

## Confirmation types (constants in `contact_ajax.module`)

| Value | Constant | After submit |
|---|---|---|
| `1` | `CONTACT_AJAX_LOAD_DEFAULT_MESSAGE` | Default status message only. |
| `4` | `CONTACT_AJAX_LOAD_CLEAN_FORM` | Default status message **and** a fresh empty form. |
| `2` | `CONTACT_AJAX_LOAD_FROM_URI` | Rendered full view of the configured node (`load_from_uri`). |
| `3` | `CONTACT_AJAX_LOAD_FROM_MESSAGE` | Custom message (`load_from_message` value). |

## Runtime behavior

When `enabled`, `contact_ajax_form_contact_message_form_alter()` wraps the message form
(`#prefix`/`#suffix` = `<div id="<element_id>">`) where `element_id` = `prefix_id` or
`contact_ajax_<form_id>`, and sets `#ajax` on the submit button
(callback `contact_ajax_contact_site_form_ajax_callback`, effect `fade`). The callback builds an
`AjaxResponse`:
- No custom `render_selector`: `ReplaceCommand` on `#<element_id>` with the output.
- Custom `render_selector`: `ReplaceCommand('#<element_id>', '')` (remove form) + `HtmlCommand(selector, output)`.
- If Views is enabled, a `ScrollTopCommand` targets the selector.
- On validation errors: the messages plus the re-rendered form are returned inline.

## Set it with Drush / config

```bash
ddev drush cset contact.form.feedback third_party_settings.contact_ajax.enabled true -y
ddev drush cset contact.form.feedback third_party_settings.contact_ajax.confirmation_type 1 -y
ddev drush cr
```

(Replace `feedback` with your contact form id; core ships a `feedback` form.) Recommended companion:
`drupal/contact_storage` to persist submissions.

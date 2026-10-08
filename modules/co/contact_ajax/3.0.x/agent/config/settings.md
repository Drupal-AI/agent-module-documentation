<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Ajax — configuration & AJAX behavior

All logic lives in `contact_ajax.module`. There is no settings form and no config object of the module's own; options are stored as **third-party settings** on each core `contact.form.*` config entity under the `contact_ajax` namespace.

## Install / enable

`drush en contact_ajax`. Requires core `contact`. No install hooks, no permissions of its own — administering forms uses core's `administer contact forms`; submitting uses core's `access site-wide contact form` (or personal contact access).

## Third-party settings (schema: `config/schema/contact_ajax.schema.yml`)

Schema key `contact.form.*.third_party.contact_ajax`:

- `enabled` (boolean) — turn AJAX submit on for this form.
- `confirmation_type` (integer) — what to load after a successful submit; see constants below.
- `load_from_uri` (integer) — node id to render when type = node content.
- `load_from_message` (text_format) — custom message (`value` + `format`) when type = custom message.
- `prefix_id` (string) — custom wrapper HTML id (advanced).
- `render_selector` (string) — CSS selector of a different element to render the response into (advanced).

Confirmation-type constants:

- `CONTACT_AJAX_LOAD_DEFAULT_MESSAGE` = 1 — status messages only.
- `CONTACT_AJAX_LOAD_FROM_URI` = 2 — render the configured node ('full' view mode).
- `CONTACT_AJAX_LOAD_FROM_MESSAGE` = 3 — render the custom formatted message.
- `CONTACT_AJAX_LOAD_CLEAN_FORM` = 4 — status messages plus a freshly rebuilt empty form.

## Admin form (`contact_ajax_form_contact_form_form_alter`)

Adds a `contact_ajax` fieldset to the contact-form edit form with:
- `contact_ajax_enabled` checkbox.
- `contact_ajax_confirmation_type` select (options map to the constants above; note the admin UI lists Default message, Default message + empty form, Node content, Custom message).
- `contact_ajax_load_from_uri` entity_autocomplete (node), visible only for the Node-content type.
- `contact_ajax_load_from_message` text_format, visible only for the Custom-message type; default format comes from `FilterFormatRepositoryInterface::getDefaultFormat()`.
- `advanced` details with `contact_ajax_prefix_id` and `contact_ajax_render_selector` textfields.
`#states` show/hide fields based on the enabled checkbox and selected confirmation type. An `#entity_builders` entry (`contact_ajax_contact_form_form_builder`) persists the values via `ContactFormInterface::setThirdPartySetting()`.

## Front-end alter (`contact_ajax_form_contact_message_form_alter`)

Runs on the `contact_message` form. If the bundle's contact form has `enabled` set, it:
- Wraps the form: `#prefix`/`#suffix` `<div id="…">` using `prefix_id` or `CONTACT_AJAX_PREFIX . $form_id`.
- Adds `#ajax` to `actions.submit` (callback `contact_ajax_contact_site_form_ajax_callback`, `wrapper` = element id, `effect` => fade).
- If Views is enabled, attaches the `views/views.ajax` library.

The submit button's `#ajax` runs the callback **after** the standard core validate/submit handlers, so core's contact access checks and flood control are unchanged — only the page reload is replaced.

## AJAX callback (`contact_ajax_contact_site_form_ajax_callback`)

Returns an `AjaxResponse`. It resolves the contact form via the message bundle, reads `confirmation_type`, and builds a container keyed by the element id. `StatusMessages::renderMessages(NULL)` collects Drupal messages; `#prefix`/`#suffix` are unset to avoid duplicated wrappers.

- On validation errors: appends status messages and the re-rendered `$form` (inline errors).
- On success, by type:
  - Node content: `Node::load()` the numeric `load_from_uri`, render it with the node view builder in 'full' mode into `#markup`.
  - Custom message: output the stored `load_from_message['value']` as `#markup`.
  - Clean form: append messages, create a new `contact_message` entity, set it on the form object, strip user input (keeping clean value keys + `ajax_page_state`), `setRebuild()`, clear storage, and rebuild the form via `form_builder`.
  - Default: append status messages only.

Rendering target: `render_selector` (if set) vs the `#`+element-id wrapper. When a custom selector differs from the wrapper, it issues a `ReplaceCommand($wrapper, '')` (hide the form in place) plus `HtmlCommand($selector, $output)`; otherwise a single `ReplaceCommand($wrapper, $output)`. When Views is enabled it also adds a `ScrollTopCommand($selector)`.

## Operating notes

- Configure per form at `admin/structure/contact/manage/<id>` → "Contact ajax" fieldset; there is no global settings page.
- The Node-content and Custom-message options are set by administrators (`administer contact forms`); the node is rendered in 'full' view mode after submit.
- For persisted submissions add contact_storage; for spam control add honeypot — both are independent of this module.

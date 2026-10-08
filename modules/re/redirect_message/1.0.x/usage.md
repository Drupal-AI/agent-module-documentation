<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect Message lets you attach a message to any Redirect (from the contrib Redirect module) entity that is shown to the visitor once they land after the redirect — useful for telling people a page has moved, been renamed, or replaced.

The module adds two base fields to the `redirect` entity via `hook_entity_base_field_info()`: a `message` (formatted `text_long`) and a `message_type` (`list_string`: status, warning, or error). An event subscriber on `KernelEvents::RESPONSE` (priority 33) inspects outgoing `RedirectResponse` objects: when the response carries an `X-Redirect-ID` header (set by the Redirect module), it loads that redirect and, if both `message` and `message_type` are set, runs the message through `check_markup()` with its configured text format and pushes it to Drupal's Messenger as a status/warning/error.

Operational/security notes: message content is authored by whoever can edit redirects and is rendered through `check_markup()` honouring the field's text format, so XSS exposure is bounded by that format's filters — grant redirect-edit access only to trusted roles and avoid a full-HTML format for untrusted authors. The subscriber only acts on responses that already carry the Redirect module's `X-Redirect-ID` header. No routes or permissions of its own.
---
Show a configurable status/warning/error message to the user after a Redirect-module redirect fires.
---
- Add a "page has moved" message to a redirect entity.
- Choose the message type: status, warning or error.
- Display the message automatically after the redirect resolves.
- Format the message using a text format (formatted long text field).
- Tell users a URL changed after a content migration.
- Warn visitors that a resource was deprecated via a redirect.
- Surface an error-styled notice on certain legacy URLs.
- Author messages on the standard redirect add/edit form.
- Reuse existing Redirect module redirects, just with a message.
- Localise the message per redirect entity.
- Leave the message blank to keep a silent redirect.
- Rely on the `X-Redirect-ID` header to target the right message.
- Keep messages safe by using a restricted text format.
- Restrict redirect-edit access to trusted roles (message is markup).
- Communicate maintenance or rebrand notices through redirects.
- Combine status messages with SEO-friendly 301 redirects.
- Show a friendlier explanation than a bare redirect.
- Push the message through Drupal's standard Messenger service.

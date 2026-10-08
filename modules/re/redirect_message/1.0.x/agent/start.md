<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Message (redirect_message) — agent index

**Adds a message (status/warning/error) to Redirect entities, shown via Messenger after the redirect fires.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11 (deps: redirect, options, text)
- **Fields:** `hook_entity_base_field_info()` adds `message` (text_long) + `message_type` (list_string: status/warning/error) to the `redirect` entity
- **Service:** `RedirectResponseSubscriber` on `KernelEvents::RESPONSE` (priority 33); acts when a `RedirectResponse` carries an `X-Redirect-ID` header, loads the redirect and pushes `check_markup(message, format)` to Messenger
- **No routes or permissions of its own.**

**Security:** message content is authored by users who can edit redirects and is rendered with `check_markup()` honouring the field's text format (`src/EventSubscriber/RedirectResponseSubscriber.php:753`), so output safety follows that format's filters — restrict redirect-edit access and avoid full-HTML formats for untrusted authors. No anonymous input path. No findings.

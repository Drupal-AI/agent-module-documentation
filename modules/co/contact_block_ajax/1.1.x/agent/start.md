<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Block AJAX (contact_block_ajax) — agent index

info.yml name **"Contact Block AJAX"**, version **1.1.0**. Provides a **block that lazy-loads a core
Contact form via AJAX**: the form markup is not rendered with the page but fetched over an AJAX endpoint
when the block scrolls into view (Intersection Observer), and it submits via AJAX without a full reload.
Purpose is page-load performance. Depends on core `block` + `contact`. Core `^10 || ^11`. Package
`Contact`. Maintainer stf54. `configure:` → the rate-limit settings form.

## What it actually does (read from source)

- **Block plugin** `ContactBlockAjax` (`@Block` id `contact_block_ajax`, category "Contact Block").
  Config: `contact_form` (which core contact form), `form_display` (form mode), `wrapper_id`. `build()`
  renders only a placeholder `<div>` (theme `contact_block_ajax` → `templates/contact-block-ajax.html.twig`)
  carrying a `data-ajax-url` pointing at the load route; it attaches the `contact_block_ajax/contact_block_ajax`
  library and `drupalSettings.contactBlockAjax` (wrapperSelector, threshold 0.1, rootMargin '50px 0px').
  Cache context `user.permissions`. `blockAccess()` denies if the form was deleted, and checks personal
  vs. site-wide access.
- **JS** `js/contact-block-ajax.js` (Drupal behavior `contactBlockAjax`): on intersection it fires a
  `Drupal.ajax({url: data-ajax-url})` request; falls back to immediate load if no IntersectionObserver.
  Shows a spinner, and generic error text (specific text only for HTTP 429 rate-limit). Uses `textContent`.
- **Load endpoint** route `contact_block_ajax.load_form` → `ContactBlockAjaxController::loadForm`
  (`/contact-block-ajax/{contact_form}`, `_format: ajax`, `no_cache`). Pipeline: require XHR → rate-limit
  (flood) → validate `wrapper_id`/`display` query params → build a `contact_message` entity and **check
  access** → `entity.form_builder` builds the form in the chosen display → returns an `AjaxResponse`
  (`HtmlCommand` + `InvokeCommand`s toggling loading classes, `X-Robots-Tag: noindex`, max-age 0).
- **Submission wiring** (`contact_block_ajax.module`): `hook_form_contact_message_form_alter` attaches an
  `#ajax` submit callback (`contact_block_ajax_contact_site_form_ajax_callback`) that returns messages
  (and, on error, the re-rendered form) via `ReplaceCommand`; also removes the preview button and clears
  `#action`. Skips its own callback if `contact_ajax`'s "Ajax Form" is enabled for that form (integration).
  `hook_entity_type_alter` registers every contact_message form mode as a usable form class.
- **Rate limiting** `RateLimitForm` at `/admin/config/people/contact-block-ajax-rate-limit`
  (permission `administer form load rate limit`). Config `contact_block_ajax.form_load_rate_limit`:
  `enabled` (default false), `limit` (default 30), `interval` seconds (default 300). Enforced in the
  controller with the Flood API, event `contact_block_ajax.form_load`, keyed by client IP; over-limit →
  HTTP 429 with `Retry-After`.
- **Personal contact forms** are supported: when the selected form is personal the block/controller read
  the `user` route/query param and gate on core `access_check.contact_personal`.

## Security posture (plain mechanism)

Access is checked **per contact form inside the controller** for every load — site-wide forms via the
contact-form entity `view` access, personal forms via core's personal-contact access check — so the
`_access: 'TRUE'` route is not an open door. Request parameters are sanitized (`wrapper_id` via
`Html::getId()`, `display` validated against the allowed form-mode list, `user` numeric + entity-loaded).
Output goes through the render API / AJAX commands and Twig auto-escaping; the JS uses `textContent`.
Form submission keeps core Form-API CSRF; IP-based flood rate limiting is available for the load endpoint.

## Files
- `data.json` — metadata.
- `usage.md` — one-liner + mechanism + use-case bullets.
- `../human-docs/` — human setup guide (install, place block, rate limiting).

No agent subdocs: the module is a single block + one AJAX controller + one settings form; the above
covers it. Full API surface is the block config, the theme hook variables, and the rate-limit config keys.

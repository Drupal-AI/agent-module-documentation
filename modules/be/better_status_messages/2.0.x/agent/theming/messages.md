<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Status Messages — rendering pipeline

All hooks live in `better_status_messages.module`; the template, JS and CSS live in `templates/`, `js/`, `css/`.

## Theme hook registration
`better_status_messages_theme()` registers one hook:
```
status_messages__better:
  variables: { status_headings: [], message_list: NULL }
  template: status-messages--better
```
This is a variant of core's `status_messages` hook, rendered by
`templates/status-messages--better.html.twig`.

## When the override applies (front-end only)
`better_status_messages_theme_suggestions_status_messages_alter(&$suggestions, $variables)` appends the
suggestion `status_messages__better` — **but only if `_better_status_messages_is_admin_page()` is FALSE**.
That helper returns TRUE when:
- the current route is an admin route (`router.admin_context` service `isAdminRoute()`), OR
- the route has the option `_node_operation_route`, OR
- (no route object) the current path matches `node/\d+/edit` or `taxonomy/term/\d+/edit`.

So on admin pages and content-edit forms, core's default status-messages rendering is used unchanged; the
restyled/dismissible version appears only on non-admin (front-end) pages.

## Preprocess — inject colors
`better_status_messages_preprocess_status_messages__better(&$variables)` reads
`\Drupal::config('better_status_messages.settings')` and sets `color_status_text`, `color_status_bg`,
`color_close_button`, `color_error_bg`, `color_error_text` (each with a hardcoded `??` default — see
[../config/settings.md](../config/settings.md)).

## Template (`templates/status-messages--better.html.twig`)
- `{{ attach_library('better_status_messages/library') }}` loads the CSS + JS.
- Wraps all messages in `<div class="c-status-message-wrapper" id="js-status-message">` (only when
  `message_list` is not empty).
- Loops `message_list` by `type`; for `type == 'error'` it swaps the color variables to the error colors and
  adds `role="alert"`.
- Each group renders a `<button id="js-close-status-message">` with an inline close-X SVG (`fill:` from
  `color_close_button`), a visually-hidden heading (`status_headings[type]`), then the message(s): a `<ul>`
  of `<li>{{ message }}</li>` when more than one, else `{{ messages|first }}`.
- The box background/text colors are emitted as an inline `style="background-color: …; color: …;"`.
- Message values (`{{ message }}` / `{{ messages|first }}`) are the core message render arrays / Markup
  objects rendered by Twig as-is — the module does **not** apply `|raw` or otherwise re-escape them.

## JS behavior (`js/better-status-messages.js`)
`Drupal.behaviors.betterStatusMessages.attach()` binds a click handler on `#js-close-status-message` that
calls `$('#js-status-message').remove()` — i.e. clicking any close button removes the **entire** message
wrapper (all groups), not just the clicked group. IDs are duplicated across groups, so behavior targets the
single `#js-status-message` wrapper. Requires `core/jquery` + `core/drupal` (declared in
`better_status_messages.libraries.yml`).

## CSS (`css/better-status-messages.css`, source `.scss`)
Class prefix `c-status-message*`. Messages are `position: relative` inline in normal document flow (not a
fixed/floating toast); text is centered in a `1200px` max-width column; the close button is absolutely
positioned to the right of the box with a hover scale on the SVG. Compiled from the SCSS via the repo's
`gulpfile.js` (dev-only; not needed at runtime).

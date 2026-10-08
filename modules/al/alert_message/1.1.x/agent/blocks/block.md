<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The block: placement, lazy builder, dismiss, caching, templates

The banner appears **only** where you place the block. Go to `/admin/structure/block`, place
**Alert message** (`alert_message`) in a region (e.g. "Highlighted" or content top). Without a placed
block, authored alerts are invisible.

## Block plugin (`src/Plugin/Block/AlertMessage.php`)

A plain `#[Block(id: "alert_message")]`. Its `build()` returns **only** a lazy-builder placeholder — no
content is computed at block-build time:

```php
return [
  '#lazy_builder' => ['alert_message.lazy_builder:build', []],
  '#create_placeholder' => TRUE,
];
```

It also declares the block's cache metadata:
- `getCacheTags()` merges in **`alert_message_list`**.
- `getCacheContexts()` merges in **`cookies:alertMessageClosed`**.

## Lazy builder (`src/LazyBuilder/AlertMessageLazyBuilder.php`)

Registered as service `alert_message.lazy_builder` (autowired; tagged `trusted_runner_callback`,
implements `TrustedCallbackInterface` exposing `build`). `build()`:

1. Loads all alerts with `status = TRUE` (`loadByProperties(['status' => TRUE])`).
2. For each, applies targeting: skip if it has targeted roles and none intersect
   `currentUser->getRoles()`; skip if it has targeted users and the current uid isn't among them.
3. Renders each survivor via the `alert_message` view builder.
4. Returns `#theme 'block__alert_messages'` with `#alert_messages` and `#cache` =
   contexts `['cookies:alertMessageClosed', 'user', 'user.roles']`, tags `['alert_message_list']`.

Because the block is a placeholder, the outer page can cache while the per-user/per-cookie alert list is
computed inside the lazy builder — this is the 1.1.0 change that moved rendering onto the Dynamic Page
Cache and away from bloating the render-cache table.

## Dismiss (client-side only — no server route)

`templates/alert-message.html.twig` renders each alert inside an `<article role="alert" id="alert-message-{id}">`
with a close `<button class="alert-message-close" data-message-id="{id}">`. `js/alert_message_read.js`
(library `alert_message/read`, deps `core/drupal` + `core/once`) attaches on click:

- reads the `alertMessageClosed` cookie (a JSON array), pushes this alert's id,
- writes it back as `alertMessageClosed=<json>; path=/`,
- removes the alert element from the DOM.

On the next request, `template_preprocess_alert_message()` (in `alert_message.module`) reads the cookie,
`Json::decode`s it, and if the alert's id is present sets `message_read = TRUE` and returns early so the
template renders nothing for that alert. **Dismissal is per-browser, not stored server-side; there is no
AJAX/POST dismiss endpoint.** Clearing cookies (or a different browser) brings dismissed alerts back.

## Page-cache interaction (`src/PageCache/AlertMessageDismissedRequestPolicy.php`)

Service `alert_message.page_cache_request_policy.dismissed`, tagged `page_cache_request_policy`. Its
`check()` returns `RequestPolicyInterface::DENY` whenever the request carries the `alertMessageClosed`
cookie. Rationale (from the source comment and project page): for anonymous users the **Internal Page
Cache** would otherwise always serve the same cached HTML and never reflect a dismissal; denying it lets
the **Dynamic Page Cache** serve a per-cookie variant instead. Net effect: pages serve from Varnish /
Internal Page Cache normally, and only *after* a visitor dismisses something do they fall through to the
Dynamic Page Cache — keeping the banner correct without Cumulative Layout Shift.

## Templates (override in your theme)

- `templates/alert-message.html.twig` — one alert: `<article>` + close button. Ships **crude inline
  styles** (`border: 1px solid black`, a floated `&#x2715;` close glyph). Override to restyle. Message
  body prints via `{{- content -}}` (the rendered entity, message filtered by its text format).
- `templates/block--alert-messages.html.twig` — wrapper that loops `alert_messages` and prints each.

Theme hooks are registered in `alert_message_theme()`: `alert_message` (render element `elements`) and
`block__alert_messages` (variable `alert_messages`).

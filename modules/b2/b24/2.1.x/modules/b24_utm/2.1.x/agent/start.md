<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24_utm (b24_utm) — agent index

Submodule of **[b24](../../../../agent/start.md)**. Adds **UTM** attribution to exported
leads. Depends on `b24`. Package `bitrix24`. No configuration, no routes, no config schema.

## What it provides (`b24_utm.module`)

- **`hook_preprocess_page()`** — reads the request query, keeps the keys `utm_source`, `utm_medium`,
  `utm_campaign`, `utm_content`, `utm_term` (via `array_filter(..., ARRAY_FILTER_USE_KEY)`), and
  stores them with `user_cookie_save()` (Drupal `Drupal_visitor_*` cookies).
- **`hook_b24_push_alter(&$fields, $context)`** — on `op == 'insert'` && `entity_name == 'lead'`,
  for each UTM mark present as a `Drupal_visitor_<utm>` cookie, adds `strtoupper($utm)` →
  cookie value to the outbound lead fields.
- **`hook_help()`** — describes the captured marks.

The base module's `RestManager::addEntity()` invokes `hook_b24_push_alter` before every add, so any
lead created by b24_contact / b24_webform / b24_commerce picks up the stored UTM marks.

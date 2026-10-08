<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How notifications fire — hooks, mail keys, cron, gating

All logic is procedural in `simple_content_notifications.module`. No services, no plugins.

## CRUD notifications

`hook_node_insert` / `hook_node_update` / `hook_node_delete` each build a plain-text `$message`
string (bundle, `$node->label()`, acting `$user->getAccountName()`, and for insert/update a
`$base_url/node/{id}` link) and call `simple_content_notifications_prep($node, $key, $message)`
with mail key `create_node` / `update_node` / `delete_node`.

`simple_content_notifications_prep()` reads `simple_content_notifications.settings` and returns
early (optionally logging a warning) unless ALL hold:

1. `simple_content_notifications_active` is truthy.
2. `addresses` and `types` are both non-empty (`!!$x === FALSE` guard).
3. On the live domain — `str_contains($base_url, $live_domain)` — OR `in_dev` is enabled.
4. `in_array($node->bundle(), $types, TRUE)` — bundle is a selected type.
5. After filtering, at least one recipient remains. Recipients come from
   `explode(',', $addresses)` trimmed; any address that is a substring of the current user's email
   (`strpos($user_email, $address) === FALSE` test) is dropped, so the acting editor is not mailed.

It then calls `plugin.manager.mail`→`mail('simple_content_notifications', $key, $to, $langcode,
$params, NULL, TRUE)` with `$to` = the joined remaining addresses (all in one `to`), `langcode`
from `$user->getPreferredLangcode()`, `$params['message']` and `$params['node_title']`.

## `hook_mail` (`simple_content_notifications_mail`)

- `create_node` / `update_node` / `delete_node`: `from` = `system.site` mail; `subject` =
  `t('Website content created/updated/deleted: @title', ['@title' => $params['node_title']])`;
  `body[]` = the prepared plain-text message.
- `review`: `from` = site mail; `subject` = `review_settings.review_notifications_subject`;
  `body[]` = `$params['message']` (rendered HTML); sets
  `headers['Content-Type'] = $params['headers']['content-type']` (the caller passes `text/html`).

## Review digest — `hook_cron`

`simple_content_notifications_cron()` reads `simple_content_notifications.review_settings`; does
nothing unless `review_notifications_active`. It reads State
`simple_content_notifications.review_notifications_next_send` (defaults to +1 day if unset) and only
proceeds when `today > next_send`. When it proceeds it first advances the next-send date by
`review_notifications_delay` (stored back to State), then — if on the live domain or `in_dev` —
calls `simple_content_notifications_check_last_revised()`:

- Runs `\Drupal::entityQuery('node')->accessCheck(FALSE)->exists($field)` (adds
  `->condition('status', 1)` when `review_notifications_published`), loads the nodes, and keeps
  each whose `$field` date value is older than `new DateTime($review_notifications_due)`.
- Each kept record: `nid`, `title`, `created` (Y-m-d), `last` (raw field value), and a human
  "N years M months D days overdue" `diff` string.

If the result is non-empty, cron builds an HTML `#markup` table (Title link + Last Reviewed, plus a
link to `/admin/content/needing_review`), renders it with `renderer->renderInIsolation()`, and mails
it under key `review` to `review_notifications_addresses`. HTML delivery depends on the site's mail
system rendering `text/html` (README suggests Mailgun / an HTML mail formatter).

## Report page

`NeedingReview::reportPage()` (`src/Controller/`) calls the same
`simple_content_notifications_check_last_revised()`, sets `#cache max-age 0`, and returns the
`needs_review_page` theme (template `templates/needs-review-page.html.twig`) — a table of overdue
nodes with view/edit links. Twig auto-escapes the values it prints.

## Notes

- The overdue query uses `accessCheck(FALSE)`; scope is therefore all nodes with the field,
  gated only by the route/recipient configuration — not per-node view access.
- Everything keys off `$base_url` string-matching the configured `live_domain`, so an empty or
  wrong domain value changes whether mail sends.

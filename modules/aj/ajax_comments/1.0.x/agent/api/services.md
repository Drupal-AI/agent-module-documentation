<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, routes & AJAX flow

## Services

| Service id | Class | Purpose |
|---|---|---|
| `ajax_comments.field_settings_helper` | `Drupal\ajax_comments\FieldSettingsHelper` | Resolves the comment field's formatter for an entity/view-mode and reports whether AJAX is enabled. |
| `ajax_comments.temp_store` | `Drupal\ajax_comments\TempStore` | Wraps `tempstore.private` to hold per-request AJAX state (e.g. which comment is being edited). |

`FieldSettingsHelper::isEnabled($formatter)` returns
`$formatter->getThirdPartySetting('ajax_comments', 'enable_ajax_comments', '1')` — this is the
single source of truth for "is AJAX active on this comment field". `getFieldFormatterFromComment()`
loads the right `entity_view_display` and pulls the formatter for the comment's field/view-mode.

## Routes (controller `AjaxCommentsController`)

All under `/ajax_comments/*`; each returns an `AjaxResponse` of Drupal AJAX commands that replace
the comment wrapper:

| Route | Path | Controller method | Access |
|---|---|---|---|
| `ajax_comments.add` | `/ajax_comments/add/{entity_type}/{entity}/{field_name}/{pid}` | `add` | `_access: TRUE` |
| `ajax_comments.reply` | `/ajax_comments/reply/{entity_type}/{entity}/{field_name}/{pid}` | `reply` | `_access: TRUE` |
| `ajax_comments.save_reply` | `/ajax_comments/save_reply/{entity_type}/{entity}/{field_name}/{pid}` | `saveReply` | `_access: TRUE` |
| `ajax_comments.edit` | `/ajax_comments/{comment}/edit` | `edit` | `comment.update` |
| `ajax_comments.save` | `/ajax_comments/{comment}/save` | `save` | `comment.update` |
| `ajax_comments.delete` | `/ajax_comments/{comment}/delete` | `delete` | `comment.delete` |
| `ajax_comments.cancel` | `/ajax_comments/{cid}/cancel` | `cancel` | `_access: TRUE` |

Real access is enforced by core comment entity access on the loaded comment; the module does not
add permissions.

## How AJAX gets attached

- `hook_comment_links_alter()` adds classes (`use-ajax`, `js-use-ajax-comments`,
  `js-ajax-comments-delete-<cid>`, etc.) to comment operation links, but **only** when
  `field_settings_helper->isEnabled()` is true for that field/view-mode. Delete links are wired to
  open in a modal dialog when available.
- The comment form is altered so submit/preview go through the AJAX endpoints.
- The wrapper id an AJAX response targets is computed by `Utility::getWrapperIdFromEntity($entity, $field_name)`.

## Extending / integrating

There is no plugin type or hook API to implement. To change behavior you either flip the
per-field `enable_ajax_comments` third-party setting, toggle the three global options, or
decorate `ajax_comments.field_settings_helper`. `AjaxCommentsScrollToElementCommand` is a custom
AJAX command used when `enable_scroll` is on.

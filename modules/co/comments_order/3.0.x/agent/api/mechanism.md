<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Comments Order reorders comments

The module never stores comments differently; it only rewrites how they are **queried and
paged** at display time, driven by the field's `comments_order` third-party settings.

## 1. Query alter — `comments_order_query_comment_filter_alter()`

Implements `hook_query_TAG_alter()` for the core `comment_filter` tag (the query core uses to
load a comment thread). It reads the field via
`FieldConfig::loadByName($entity_type, $bundle, $field_name)` (the field name/entity come from
the query metadata) and the `order` / `created_order` / `children_natural_order` settings, then:

- **Flat lists** (`order_by['c.cid']` present): if `DESC`, flip `c.cid` to `DESC`; if `created_order`
  is on, drop `c.cid` and order by `c.created` instead (ASC or DESC to match).
- **Threaded lists** (`order_by['torder']` present): to reverse only the top-level threads, it
  rewrites the `torder` expression to sort on the **first thread segment** using
  `SUBSTRING_INDEX(SUBSTRING(c.thread, 1, LENGTH(c.thread)-1), '.', 1)` and sets it `DESC`. Then:
  - `children_natural_order = 1`: adds a secondary `torderchild` expression
    `SUBSTRING(c.thread, 1, LENGTH(c.thread)-1)` sorted `ASC` — parents reversed, children natural.
  - `children_natural_order = 0`: adds `CONCAT(SUBSTRING(c.thread,1,LENGTH-1), '.z')` sorted `DESC`
    — parents and children both reversed. (The `.z` suffix is a heavier-than-any-thread sentinel;
    see the source comment explaining the 64-bit alphadecimal ceiling.)

## 2. Storage handler swap — `comments_order_entity_type_alter()`

Sets the `comment` entity's `storage` handler to
`Drupal\comments_order\CommentsOrderStorage` (extends core `CommentStorage`). It overrides
`getDisplayOrdinal()` so a comment's position (used for "which page is this comment on") counts
neighbours in the **configured** direction: for `DESC` it counts comments with a greater `cid`
(flat) or greater `thread` substring (threaded), the mirror of core's default. This keeps the
comment pager consistent with the reversed display.

## 3. Post-comment redirect — `_comments_order_comment_form_submit()`

Added to the comment form's submit handlers by `comments_order_form_alter()`. When the field's
`order` is `DESC` and the request is not AJAX, it clears the redirect query (page argument) so the
author lands on the **first page** after posting — where their new (newest) comment now appears.

## Notes for agents

- Everything keys off the comment **field**, so behaviour is per bundle/field, not global.
- No cache tags of its own are added; ordering follows the field config, so a config change +
  cache clear is enough to see the new order.
- Depends only on core `comment`. No services, hooks-for-you (`*.api.php`), Drush, or plugins.

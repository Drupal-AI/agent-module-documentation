<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Delete manager service

Deletion is executed by the `comment_delete.manager` service
(`Drupal\comment_delete\CommentDeleteManager`, interface `CommentDeleteManagerInterface`). The
comment delete confirmation form's submit handler calls `->delete($comment, $operation)`.

## Service graph

- `comment_delete.manager` — args: `@database`, `@token`, `@messenger`, `@entity_type.manager`,
  `@entity_field.manager`, `@comment_delete.thread_manager`.
- `comment_delete.thread_manager` (`CommentThreadManager`, arg `@database`) — recalculates the
  `thread` values of a commented entity's comments after structural changes.

## Public methods

```php
$m = \Drupal::service('comment_delete.manager');
$config = $m->getConfig($comment);        // resolves this field's comment_delete third-party settings
                                          // (adds 'commented_entity'); [] when unconfigured
$m->delete($comment, 'soft');             // dispatch: 'hard' | 'hard_partial' | 'soft'
```

`delete($comment, $op)` dispatches:

| $op | Effect |
|---|---|
| `hard` | `hardDelete()` — deletes the comment (core cascades its replies). |
| `hard_partial` | `moveReplies()->hardDelete(TRUE)` — reassigns each immediate reply's `pid` up one level (to the deleted comment's parent, or NULL at top level), deletes the comment, then recalculates threads. |
| `soft` | `softDelete()` — if the comment has no replies it hard-deletes; otherwise, in `unpublished` mode it unpublishes the comment, in `unset` mode it blanks the subject and all non-base fields (and sets author to uid 0 when `anonymize` is on) across every translation. |

After the operation, if the field's `message[$op]` is non-empty it is token-replaced (`comment`
tokens), XSS-admin-filtered, and shown via the messenger.

## When to call it

Only needed if you delete comments programmatically and want the module's reply-handling rules
applied. Normal UI deletes already route through this service via the confirm form. `getConfig()`
is also the canonical way to read a comment field's effective comment_delete settings in code.

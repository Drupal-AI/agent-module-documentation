<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Delete permissions

The module overrides comment `delete` access via `hook_comment_access()` →
`CommentDeleteAccess::access()`. Access is granted if **any** matching permission below holds. It
combines static permissions with **dynamically generated per-field permissions** (via the
`permission_callbacks` entry `CommentDeleteAccess::permissions`).

## Static permissions (`comment_delete.permissions.yml`)

| Permission | Grants |
|---|---|
| `administer comment delete settings` | (restricted) admin flag for the module |
| `delete own comment` | delete comments you authored (respects the time limit) |
| `delete own comment anytime` | delete your own comments, ignoring the time limit |
| `delete any comment` | delete any comment (respects the time limit) |
| `delete any comment anytime` | delete any comment, ignoring the time limit |

## Dynamically generated per-field permissions

For **every** entity-type + bundle + comment field on the site, `CommentDeleteAccess::permissions()`
generates (substitute `<et>`, `<bundle>`, `<field>`, e.g. `node article comment`):

- `delete own <et> <bundle> <field>` / `... anytime` — delete your own comments in this field.
- `delete any <et> <bundle> <field>` / `... anytime` — delete any comment in this field.
- `delete <et> <bundle> <field> replies` / `... anytime` — delete an immediate reply to your own comment.
- `allow <et> <bundle> <field> hard delete`
- `allow <et> <bundle> <field> hard_partial delete`
- `allow <et> <bundle> <field> soft delete`

The `allow ... <op> delete` permissions gate **which operations appear** in the delete confirmation
form: on the confirm form the enabled operations are filtered to those the current user has the
matching `allow` permission for. The `delete ...` permissions gate **whether the user can delete the
comment at all**.

## Access logic notes

- "anytime" variants bypass the field's `time_limit`/`timer`; the non-anytime variants deny once the
  comment is older than `timer` seconds (when `time_limit` is on).
- `replies` permissions apply only when the comment has a parent and the current user owns that
  parent comment.
- Only the default translation of a comment is handled (non-default translations are skipped).

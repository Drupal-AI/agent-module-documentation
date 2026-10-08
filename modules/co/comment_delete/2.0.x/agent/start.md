<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Delete — agent index

Configurable comment deletion with threaded-reply handling. **No settings page / configure route**
(`configure: null`); all config is **third-party settings on each comment field** and it defines a
rich permission scheme. Depends on core `comment`.

- **Per-field settings: operations, visibility, labels, messages, soft mode, time limit — where
  stored and how to set them** → [configure/field-settings.md](configure/field-settings.md)
- **The permission scheme (static + dynamically generated per-field) and delete access override** →
  [permissions/permissions.md](permissions/permissions.md)
- **The delete manager service and what each operation does to replies** →
  [api/manager.md](api/manager.md)

Key facts:
- The three operations are `hard` (delete comment + replies), `hard_partial` (delete comment, move
  replies up one level), `soft` (delete comment, keep replies).
- Config lives on the comment field config's third-party settings:
  `field.field.<entity>.<bundle>.<field>` key `third_party.comment_delete` (operation, visibility,
  label, message, mode, anonymize, default, time_limit, timer).
- Services: `comment_delete.manager`, `comment_delete.thread_manager`.

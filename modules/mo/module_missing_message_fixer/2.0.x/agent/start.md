<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Missing Message Fixer — agent index

Finds and deletes "ghost" module records — `system.schema` entries in the `key_value` table
for modules whose code was removed without a proper uninstall — that cause recurring
"missing module" warnings. Fix them from a UI or via Drush.

- **The Drush commands (`mmmfl` list / `mmmff` fix)** →
  [drush/commands.md](drush/commands.md)
- **The fixer UI, its route/permission, how ghosts are detected, and what "fix" deletes** →
  [configure/fixer.md](configure/fixer.md)

Key facts: ghosts live in `key_value` (collection `system.schema`) — a name whose
`extension.list.module` path no longer resolves. UI at
`/admin/config/system/module-missing-message-fixer` (route `module_missing_message_fixer.form`,
permission `administer module missing message fixer`). Detection service:
`module_missing_message_fixer.fixer` (`ModuleMissingMessageFixer`). No config, no schema, no
plugins.

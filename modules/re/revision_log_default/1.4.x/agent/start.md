<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Log Default — agent index

Auto-generates a revision log message on any revisionable content entity saved with an empty
message. **Zero configuration**: no settings, no `configure` route, no permissions, no Drush, no
plugins, no config schema. Its entire behaviour is one `hook_entity_presave()`.

- **What messages it generates, when it fires, field-diff and moderation rules** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Fires only for `ContentEntityInterface` + `RevisionLogInterface` entities whose
  `getRevisionLogMessage()` is empty. It never overwrites a provided message.
- New entity ⇒ `Created new <bundle label>`; new translation ⇒ `Created <language> translation`;
  update ⇒ `Updated the <Field> field` (list of changed field labels) or `Updated <bundle label>`.
- Also repairs missing/stale revision timestamp and revision author on save.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymous author (anonymous_author) — agent index

**Adds an `anonymous_author` field (name/email/notify) for attaching guest author details to entities.**

- **Version:** 1.3.x (1.3.2), core `^8 || ^9 || ^10 || ^11`, depends on `drupal:field`
- **Field:** type `anonymous_author` (columns `name`, `email`, `notify`) + widget + formatter
- **Permission:** `edit anonymous author fields` (gates the fields on existing entities)
- **Hooks:** `hook_entity_update`/`hook_entity_insert` send notify emails; `anonymous_author_notification[_update|_comment]` alter hooks
- **Security posture:** the stored author is **free-text name/email, not a uid** — no user-account impersonation/ownership reassignment. The module grants no create permission; anonymous content creation is still governed by core entity access. Widget hides fields from non-anonymous users on new entities and requires `edit anonymous author fields` on existing ones. Notify email targets an unvalidated visitor-supplied address (email/spam surface).

See [configure/field.md](configure/field.md)

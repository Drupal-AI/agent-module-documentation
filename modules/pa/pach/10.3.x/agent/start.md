<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pluggable Access Control Handler (pach) — agent index

**Decorates `entity_type.manager` so any entity type's access is handled by pACH's handler, which delegates to tagged access plugins.**

- **Version:** 10.3.x
- **Core:** `^10.3 | ^11`
- **Depends:** none
- **Services:** `pach.entity_type.manager` (decorates `entity_type.manager`, priority 10); `plugin.manager.pach` (plugin manager).
- **Plugin type:** `AccessControlHandler` (Attribute + Annotation), base `AccessControlHandlerBase` with `access()`, `createAccess()`, `fieldAccess()`; example plugins in `pach_examples`.
- **Routes / permissions / config:** none.

**Security:** developer infrastructure with no HTTP surface of its own. Access plugins can both grant and deny access, so a custom plugin can widen access to an entity type — treat plugin code as security-sensitive and review it. See [plugins/access-plugin.md](plugins/access-plugin.md). No module-level findings.

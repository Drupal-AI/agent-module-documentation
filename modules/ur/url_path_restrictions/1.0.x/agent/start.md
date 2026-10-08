<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL Path Restrictions — agent index

**Validates URL paths/aliases against disallowed patterns** — a constraint on the `alias`/`path` fields that
blocks **creating** matching aliases. Depends on core `path_alias`, `pathauto`, `system`. Version
**1.0.0-beta1**. Core `^10||^11`.

**Content-integrity validation, NOT a runtime access gate** — stops alias/path creation, does not 403 visitors.
Use real access control to protect content. No access role.

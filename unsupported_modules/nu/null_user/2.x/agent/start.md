<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Null User (null_user) — agent index

**Provides a `NullUser` null-object class (extends `AnonymousUserSession`) for cleaner user-object comparison in code.**

- **Version:** 2.x
- **Core:** `^8 || ^9 || ^10 || ^11`
- **Class:** `Drupal\null_user\NullUser` — `id()` → NULL, `getRoles()` → [], `hasPermission()` → FALSE.
- **Surface:** none — no routes, permissions, services, forms or config.

**Security:** No attack surface. Despite the name it performs NO anonymisation, deletion or mutation of user accounts — it is a passive value/utility class with no triggers, routes or permissions. Nothing to gate.

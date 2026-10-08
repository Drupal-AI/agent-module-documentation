<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aide (aide) — agent index

**A static utility class (`Drupal\aide\Aide`) of read-only helpers for common lookups inside Drupal hooks.**

- **Version:** 1.0.x (dev-1.0.x checkout)  •  **Core:** ^8.8 || ^9 || ^10 || ^11  •  **Package:** Development
- **API:** static methods — `getCurrentPath()`, `getRequestUri()`, `getCurrentRouteName()`, `getCurrentNode()`, `getCurrentUser()`, image-style / block / user helpers.
- No routes, permissions, services, config, or schema. Pure autoloadable library.

**Security:** no endpoints or permissions; all helpers wrap core APIs read-only. No security-relevant surface. The class recommends dependency injection over static calls inside services.

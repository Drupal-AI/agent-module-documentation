<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mustache Logic-less Templates (mustache_templates) — agent index

**Integrates Mustache.php + Mustache.js into Drupal: a text-format filter, render element, token support, a `MustacheMagic` plugin system, and submodules for tokens, Views, and template sync.**

- **Version:** 2.2.x
- **Core:** ^9 || ^10
- **Depends:** none (bundles Mustache libraries)
- **Submodules:** `mustache_token`, `mustache_views`, `mustache_magic`.
- **Permission:** `view mustache debug messages`.

**Surface:** `mustache` filter plugin, `Mustache` render element, `MustacheMagic` plugin manager + plugins, engine/loader/cache classes. `mustache_magic` adds anonymous route `/m/sync` (`ProxySyncController::get`, `_access: TRUE`).

**Security (reviewed — sound):** `/m/sync` looks up templates by a hash that is salted `sha3-512(values + site hash salt)` (unguessable) and enforces entity `view` access before rendering — a capability token, not an open renderer. The text-format filter is a trusted-format feature; Mustache is logic-less (no PHP eval), so risk is limited to token/data disclosure within the author's access. Assign the filter only to trusted formats.

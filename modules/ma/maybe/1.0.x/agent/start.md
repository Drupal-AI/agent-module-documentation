<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maybe (maybe) — agent index

**A null-safe wrapper class (loose Maybe monad) for chaining method/property/array access across Drupal entities without exceptions.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **API:** `maybe($object)` helper (`.module`) or `new \Drupal\maybe\Maybe($object)`; methods `->return()`, `->property($name)`, `->array($key, ...)`, and any passthrough method via `__call()` (`src/Maybe.php`)
- **Entity special-case:** `get('field')` checks `hasField()` first, returns null instead of throwing
- **Routes / permissions / services / hooks / config:** none

**Security:** Pure PHP developer utility. Method names come from developer code (chained calls), not from user/request input, so there is no injection or web-exposed surface. No routes, permissions, or mutating endpoints.

See [api/maybe.md](api/maybe.md)

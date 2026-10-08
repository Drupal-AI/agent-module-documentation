<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Register (cache_register) — agent index

A developer helper that wraps core's `CacheBackendInterface` with **Drawer / Slot / Register**
objects so you cache arbitrary data without hand-building cids or repeating cache boilerplate.
Package `Custom`. **No dependencies** outside core. Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.1.1.

- **The service, the three object types, every method, and how to operate it** →
  [api/manager.md](api/manager.md)

## What it actually is

- One service: **`cache_register.manager`** → `Drupal\cache_register\Manager` (implements
  `ManagerInterface`), constructed with `@cache.data` (the `cache.data` bin). It is the only
  public entry point.
- Three plain PHP objects under `src/Object/` (never instantiate directly):
  - **`Drawer`** (`DrawerInterface`) — groups related entries under a prefix `implementor_id.drawer_name`
    and tag `drawer:<drawer_id>`. Does **not** itself point at a cache entry.
  - **`Slot`** extends **`SlotBase`** (`SlotInterface` / `SlotBaseInterface`) — an accessor for one
    cache entry with cid `<drawer_id>:<slot_id>`.
  - **`Register`** extends `SlotBase` (`RegisterInterface`) — a special Slot at cid
    `<drawer_id>:register` whose data is a list of Slot IDs opened on the Drawer.
- Two exceptions: `CacheNotSetError` extends `CacheRegisterError` extends `\Error` (`src/Exception/`).
- **No routes, no permissions, no forms, no config, no config schema, no Drush, no hooks, no plugin
  types, no entities.** Install/uninstall does not touch site data (README).

## Mechanism (from source)

- `Manager::openDrawer($implementor_id, $drawer_name, $open_register_if_inactive=FALSE)` builds
  `drawer_id = "$implementor_id.$drawer_name"` (array `$drawer_name` is `implode('.')`-joined) and
  returns `new Drawer($cache, $drawer_id, ...)`. `openSlot(...)` opens the Drawer then its Slot;
  `openRegister(...)` opens the Drawer with the register forced on.
- `SlotBase::constructCacheEntryId()` validates the ID(s) are string/int (or an array of those,
  else `\TypeError`) and joins arrays with `.` → cid `"<drawer_id>:<id>"`.
- `SlotBase::doSetCache()` merges the Drawer's `drawer:<id>` tag onto the caller's tags, writes a
  per-request **static** copy on the Drawer, then `cache->set()`. `Slot::setCache()` also registers
  the Slot; `setCacheStrict()` writes only if not already cached.
- `SlotBase::getCache()` reads the real cache first and falls back to the Drawer static copy
  (handles read-after-write in the same request; documented as a local-dev edge case).
- `Drawer::invalidate()` calls `Cache::invalidateTags(['drawer:<id>'])` and flags each static Slot
  invalidated. `Slot::invalidateCache()` / `deleteCache()` act on the single entry and update the
  Register.
- `Register` keeps `data` as an ID→ID map; `addSlot`/`removeSlot` mutate it and re-`setCache`.

## Notes

- The static cache on `Drawer` is `protected static` — shared across all Drawers in a request; it
  is a read-after-write fallback, not a keyed per-Drawer store.
- To use a non-default bin (e.g. a permanent bin from PCB), define your own Manager service with a
  different backend argument — see [api/manager.md](api/manager.md).
- `Register.php` imports `http\Exception\InvalidArgumentException` (pecl_http), not the SPL class —
  the guard path in `addRemoveSlot()` would fatal if that unusual class is absent, but it is only
  reached on an invalid internal argument that the module never passes.

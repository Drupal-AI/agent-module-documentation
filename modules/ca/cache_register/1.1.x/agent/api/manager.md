<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Register — service & object API

All source under `web/modules/contrib/cache_register/src/`. Cite paths below.

## Install / enable

`drush en cache_register`. No dependencies, no config, no schema. Uninstalling has no data effect
(README). Nothing to configure in the UI — this is a code-only helper.

## The service

`cache_register.services.yml`:

```
services:
  cache_register.manager:
    class: Drupal\cache_register\Manager
    arguments: [ '@cache.data' ]
```

Get it with `\Drupal::service('cache_register.manager')` or inject `@cache_register.manager`.
`Manager` (`src/Manager.php`, implements `ManagerInterface`) holds the injected
`CacheBackendInterface` (`$this->cache`) and creates objects; it stores nothing itself.

### Manager methods (`ManagerInterface`)

- `openDrawer(string $implementor_id, $drawer_name, bool $open_register_if_inactive = FALSE): DrawerInterface`
  — `drawer_id = "$implementor_id.$drawer_name"`; if `$drawer_name` is an array it is joined with
  `.`. Returns `new Drawer(...)`.
- `openSlot(string $implementor_id, $drawer_name, $slot_ids, bool $open_register_if_inactive = FALSE): SlotInterface`
  — opens the Drawer, then `$drawer->openSlot($slot_ids)`.
- `openRegister(string $implementor_id, $drawer_name): RegisterInterface`
  — opens the Drawer with the register forced on, returns `$drawer->getRegister()`.

## Object model (`src/Object/`)

### Drawer (`Drawer.php` / `DrawerInterface`)

Groups related cache entries; **does not point at a cache entry itself**. Constructor takes the
backend, `$drawer_id`, and `$open_register_if_inactive`; it seeds one cache tag `drawer:<drawer_id>`
(`populateCacheTags()`) and opens the Register if one is already active or the flag is TRUE.

- `id(): string` — the drawer id.
- `openSlot($slot_ids): SlotInterface` — `new Slot($this, $slot_ids)` (does **not** write a cache entry).
- `getRegister($allow_invalidated = FALSE): ?RegisterInterface` — Register if active, else NULL.
- `hasActiveRegister(bool $allow_invalidated = FALSE): bool` — `!!cache->get("<id>:register")`.
  (Note: the `$allow_invalidated` param is accepted but not applied in the lookup.)
- `getCacheTags(): array` — `['drawer:<id>']`.
- `getCacheBackend(): CacheBackendInterface`.
- `invalidate($reopen_register = FALSE)` — `Cache::invalidateTags(['drawer:<id>'])`, marks every
  static Slot invalidated, optionally re-opens an empty Register. (README also calls this
  `invalidateSlots()`; the actual method name is `invalidate()`.)
- `getStaticCache(): array` / `setStaticCache(array $cache): void` — access the request-scoped static
  store. **`$staticCache` is `protected static`**, i.e. shared across all Drawer instances in the
  request; it is a read-after-write fallback keyed by slot cid, not a per-Drawer isolated store.

### Slot / SlotBase (`Slot.php`, `SlotBase.php`)

`SlotBase` (abstract, `SlotBaseInterface`) constructs the cid via `constructCacheEntryId($slot_ids)`
→ validates types (string/int or array of those, else throws `\TypeError`), joins arrays with `.`,
producing `"<drawer_id>:<slot_id>"`.

Shared `SlotBase` methods:
- `id(): string`, `getDrawer(): DrawerInterface`, `getRegister(): ?RegisterInterface`,
  `getCacheBackend(): CacheBackendInterface`.
- `isCached(): bool` — `!!cache->get($id)`.
- `getCache(bool $allow_invalid = FALSE): ?object` — reads the **real cache first**; on a miss falls
  back to the Drawer static copy (returns NULL if the static data is NULL or invalidated unless
  `$allow_invalid`). The comment explains the static path only exists for same-request
  read-after-write edge cases seen on local dev.
- `addCacheTags($tags): void` — throws `CacheNotSetError` if the cache is not set; otherwise merges
  `$tags` (string or iterable of strings; asserted) with existing tags via `Cache::mergeTags` and
  re-writes through `doSetCache()`.
- `doSetCache($data, int $expire, array $tags)` (protected) — merges the Drawer tag, updates the
  static copy, then `cache->set($id, $data, $expire, $tags)`.

`Slot` concrete methods (`SlotInterface`):
- `setCache($data, $expire = CacheBackendInterface::CACHE_PERMANENT, $tags = []): void` —
  `addToRegister()` then `doSetCache()`.
- `setCacheStrict($data, int $expire = ..., array $tags = []): void` — sets only if `!isCached()`.
- `getCacheData(bool $allow_invalid = FALSE)` — the `data` payload, or NULL. (Do not use for a
  genuinely NULL value — NULL is ambiguous between "unset" and "value is null".)
- `deleteCache(): void` — `cache->delete($id)`, clears static, removes from Register.
- `invalidateCache(): void` — `cache->invalidate($id)`, flags static invalidated, removes from Register.

### Register (`Register.php` / `RegisterInterface`)

A special Slot at cid `"<drawer_id>:register"`. Constructor seeds an empty list (`setCache([])`) if
not already cached. Its `data` is an ID→ID map of Slots opened on the Drawer.

- `getList(): ?array` — alias of the cached data.
- `addSlot(SlotInterface)` / `removeSlot(SlotInterface)` — mutate the map (`addRemoveSlot()`), then
  re-`setCache()` preserving the register's own expire/tags.

Opening a Register has storage/perf cost (one map entry per Slot); leave `open_register_if_inactive`
FALSE for high-cardinality Drawers (README + interface docs).

## Exceptions (`src/Exception/`)

- `CacheNotSetError` extends `CacheRegisterError` extends `\Error` — thrown by `addCacheTags()` on an
  unset cache.

## Usage patterns

```php
$manager = \Drupal::service('cache_register.manager');

// Cache with expiry + tags, only if empty.
$slot = $manager->openSlot('my_module', 'some_api', $uid);
if (!$slot->isCached()) {
  $slot->setCache($api_data, strtotime('+7 days'), ['user:' . $uid]);
}
$data = $slot->getCacheData();

// Invalidate everything grouped in a drawer.
$manager->openDrawer('my_module', 'some_api')->invalidate();

// Track opened slots via a register.
$list = $manager->openRegister('my_module', 'some_api')->getList();
```

### Using a different cache bin (e.g. PCB permanent bin)

Define your own Manager service with a custom backend and inject it (README):

```yaml
# my_module.services.yml
cache.my_module_pcb:
  class: Drupal\Core\Cache\CacheBackendInterface
  tags:
    - { name: cache.bin, default_backend: cache.backend.permanent_database }
  factory: cache_factory:get
  arguments: [ my_module_pcb ]
my_module.cache_manager:
  class: Drupal\cache_register\Manager
  arguments: [ '@cache.my_module_pcb' ]
```

## Caveats

- `Register.php` imports `http\Exception\InvalidArgumentException` (pecl_http) rather than
  `\InvalidArgumentException`; the guard in `addRemoveSlot()` is only reached on an invalid internal
  `add`/`remove` argument the module never passes, but it would fatal if that class is unavailable.
- `getCacheData()` / `getCache()` return NULL both for "unset" and for a stored NULL value.
- Tests live in `tests/src/Kernel/` (`ManagerTest`, `DrawerTest`, `SlotTest`, `SlotBaseTest`,
  `RegisterTest`) and are the authoritative behavior spec.

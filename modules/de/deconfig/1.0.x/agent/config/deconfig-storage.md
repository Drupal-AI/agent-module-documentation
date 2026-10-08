<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deconfig storage decorator & `_deconfig` YAML syntax

## Install
`drush en deconfig -y`. No configuration UI or settings — enabling registers the service decorator. To exempt config, edit sync YAML (below), then `drush cex`/`drush cim` as usual.

## The decorator
`deconfig.services.yml` declares `deconfig.storage.sync` (class `Drupal\deconfig\DeconfigStorage`) which `decorates: config.storage.sync` at `decoration_priority: 0`, `public: false`. Constructor args: `['@deconfig.storage.sync.inner', '@config.storage.active']` — i.e. the wrapped inner sync storage plus active storage. So every read/write of sync config passes through `DeconfigStorage`.

`DeconfigStorage` implements `StorageInterface` and delegates most methods (`exists`, `rename`, `encode`, `decode`, `listAll`, collections) straight to the inner storage. The `KEY` constant is `_deconfig`.

## `_deconfig` YAML syntax
Add a `_deconfig` entry to a config file in the sync directory whose structure mirrors the config hierarchy; the values are free-text reason strings. Remove the actual values you are exempting from the sync file (they live only in active storage).

Exempt a whole object:
```yaml
_deconfig: 'Hide this configuration'
```
Exempt specific keys (e.g. `system.site.yml`):
```yaml
_deconfig:
  mail: 'Let editor configure site email'
  page:
    front: 'Let editor configure frontpage'
name: 'Le site'
```
Soft mode — prefix the key with `@` (quote it). The default stays in sync and is used only when active storage has no value:
```yaml
_deconfig:
  '@name': 'Let administrator configure site name'
name: 'Default site name'
```

## How read/write behave (`DeconfigStorage`)
- `explode()` splits the `_deconfig`/`@_deconfig` spec off the data and records whether the whole object is lax (`@`).
- `read($name)` calls `doUnhide(..., $throw = TRUE, ...)`: for each spec key it copies the value from **active** storage into the returned data, then re-appends the spec via `implode()`. If a hidden (non-lax) item is actually present in the sync data it throws `FoundHiddenConfigurationError('Hidden config found in sync. Use "drush deconfig-remove-hidden" to fix.')`. This is what makes `drush cim`/`cex` error when drift occurs. `readRaw()` does the same with `$throw = FALSE` (no error).
- `write($name, $data)` calls `doHide()`: it strips the exempted values back out before writing to the inner sync storage (so export never persists them), re-appending only the `_deconfig` spec. For soft (`@`/lax) keys, `doHide` keeps the prior stored value from `$this->deleted[$name]` or inner read rather than deleting.
- `delete($name)` stashes the current data in `$this->deleted[$name]` first, so a delete-then-write during export preserves `@`-soft values.
- `hideKey()` detects the leading `@` (lax). `doHide`/`doUnhide` recurse for nested array specs and unset keys that become empty. `createCollection()` returns a new `DeconfigStorage` wrapping the inner and active collection storages, so exemptions apply per collection (e.g. language overrides).

## `implode()` ordering note
The `_deconfig` entry is appended to the **end** of the config array on purpose: core `StorableConfigBase::castValue()` sorts mapped properties by their data definition and leaves unknown entries at the end, so appending matches that ordering and avoids spurious diffs.

## Operate
1. Declare `_deconfig` in the sync YAML and remove the exempted values.
2. `drush cim` to import (exempted keys are pulled from active, not enforced).
3. Administrators change the exempted settings in the admin UI; those changes live in active storage and are not overwritten on later imports.
4. If `cim`/`cex` throws `FoundHiddenConfigurationError`, a hidden value leaked back into sync — run `drush deconfig-remove-hidden` (see [drush/remove-hidden.md](../drush/remove-hidden.md)).

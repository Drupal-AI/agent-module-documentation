<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backward Compatibility — install, mechanism, and test workflow

Everything the module does lives in `backward_compatibility.module` and
`backward_compatibility.install`. There is no config, no route, no service, no schema.

## Install / enable

```
drush en backward_compatibility -y
```

`backward_compatibility_install()` runs `module_set_weight('backward_compatibility', -1000)` on
install, so the module sorts first and its `hook_system_info_alter()` runs before any other
module's alter. Nothing else happens at install (no config imported, no tables). Confirm with
`drush cget core.extension module.backward_compatibility` → `-1000`.

## Mechanism

`backward_compatibility_system_info_alter(&$info, Extension $file, $type)` (in the `.module`)
sets, for **every** extension Drupal parses:

```php
$info['core_incompatible'] = FALSE;
```

Core's extension list builder normally sets `core_incompatible = TRUE` when a module's
`core_version_requirement` does not satisfy the running core version; the install UI and the
extension installer then refuse it. Because this alter clears the flag unconditionally — no test
of `$file`, `$type`, or the declared requirement — Drupal stops treating any module as
core-incompatible. The early `-1000` weight guarantees the override is applied before other alters
that might re-set the flag.

## What it does NOT do

- No function/class/service is defined or aliased; no deprecated API is re-provided.
- It does not edit any `.info.yml` on disk; the override is purely in-memory per request.
- It does not make an incompatible module *work*. A module that calls a genuinely removed core
  API still fatals at runtime once enabled. The module removes only the install-time refusal.

## Honest agent workflow

1. Enable `backward_compatibility`.
2. Enable the target module Drupal flagged as incompatible.
3. Interpret the result:
   - **Runs** → the module's metadata was merely stale (it just lacked a widened
     `core_version_requirement`); nothing was actually wrong with the code.
   - **Fatals** → real porting work is needed; this module changed nothing but the timing of the
     failure (from install-refusal to runtime crash).
4. Treat it as a temporary upgrade-testing tool. It disables a site-wide guardrail for **all**
   modules at once, so remove it once porting is done rather than keeping it as a production fixture.

## Uninstall

`drush pmu backward_compatibility -y`. The `core_incompatible` overrides vanish immediately (they
were never persisted); any module that was only installable because of this module will again be
reported incompatible on the next extension-list rebuild.

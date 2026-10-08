<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymous session toolkit (anonymoussession) — agent index

Developer toolkit that **forces/ensures a session for anonymous users** so custom code can reliably
use `$_SESSION`, `PrivateTempStore`, and `Drupal::currentRequest()->getSession()`. No UI, routes,
permissions, config, entities, or plugins. Version **1.0.3**, core `^8 || ^9 || ^10 || ^11`, license
GPL-2.0-or-later. `security_advisory_coverage: not-covered`.

## What it provides
- **Service** `anonymoussession` → `Drupal\anonymoussession\Services\AnonymousSessionService`
  (defined in `anonymoussession.services.yml`; args `@session_manager`, `@current_user`).
  One public method `apply()`.

## Dependencies
- Core only (`session_manager`, `current_user`). No composer requirements, no module deps.

## How it works (one method)
`apply()` — on an anonymous request, if `$_SESSION['AnonymousSessionService']` is unset it sets that
flag `TRUE` and calls `SessionManager::start()`. Session IDs/cookies are core's; the module only
decides when to start one. Idempotent (the flag guards re-entry).

## Operational caveat
Anonymous users with a session are **not served Drupal's anonymous page cache**. Call `apply()` only
on paths that genuinely need anonymous state.

## Solution docs
- [agent/api/service.md](api/service.md) — the service, `apply()`, and how to consume it from custom code.

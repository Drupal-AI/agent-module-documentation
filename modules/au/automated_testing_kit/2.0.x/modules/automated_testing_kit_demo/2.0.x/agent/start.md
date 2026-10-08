<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automated Testing Kit Demonstration (automated_testing_kit_demo) — agent index

Submodule of **[Automated Testing Kit](../../../../agent/start.md)**. Scaffolds a runnable
Playwright demo test project when the ATK Demonstration Recipe is applied. Developer/CI tooling —
local/QA only, not production.

- **Version:** 2.0.0 · **Core:** `^11` · **License:** GPL-2.0-or-later
- **Provides:** one event subscriber + an install hook. No routes, permissions, config or plugins.
- Functionally requires the parent `automated_testing_kit` module on disk (it invokes
  `modules/contrib/automated_testing_kit/module_support/atk_setup`).

## What it provides
- **Event subscriber** `RecipeEventSubscriber` (`src/EventSubscriber/RecipeEventSubscriber.php`),
  registered in `automated_testing_kit_demo.services.yml` as
  `automated_testing_kit_demo.recipe_subscriber`. Subscribes to core `RecipeAppliedEvent`; see
  [agent/api/recipe-subscriber.md](api/recipe-subscriber.md).
- **Install hook** `automated_testing_kit_demo_install()` (`.install`) — runs `cron` and logs a
  notice.

## Notes for agents
- `services.yml` passes three constructor arguments (`@logger.factory`, `@cron`, `@messenger`) but
  `RecipeEventSubscriber::__construct()` accepts only two; the `$messenger` property is declared
  but never assigned. Harmless with current PHP container behaviour but worth knowing if editing.

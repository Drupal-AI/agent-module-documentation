<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA for DRD (drd_eca) — agent index

Submodule of **Drupal Remote Dashboard** that surfaces DRD's remote-action lifecycle to the **ECA**
rules engine. Package `ECA`. Core `^10 || ^11`, GPL-2.0-or-later. Depends on `drd` and `eca` (^2).

- **What it provides, the event plugin, tokens, and how to model it** →
  [plugins/eca-events.md](plugins/eca-events.md)

## What it actually is

- One ECA event plugin: `DrdEvent` (`@EcaEvent(id = "drd")`, deriver `DrdEventDeriver`) in
  `src/Plugin/ECA/Event/`. Its `definitions()` declares two derivatives:
  - `drd_eca_action_started` → DRD event `drd.action.started` (`DrdActionStart`).
  - `drd_eca_action_finished` → DRD event `drd.action.finished` (`DrdActionFinish`).
- These map to the base module's `Drupal\drd\Event\DrdEvents` constants, dispatched by
  `Drupal\drd\ActionManager::executeAction()` before/after every remote action.
- `buildEventData()` exposes tokens `drd_action_id` (the plugin id) and `entity` (the target
  host/core/domain), read from the `DrdBase` event via `getAction()` / `getEntity()`.
- No routes, no permissions, no services, no config, no config schema, no Drush. It adds only the
  event plugin; DRD's own Action plugins remain the "actions" ECA can call.

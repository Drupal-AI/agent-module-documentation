<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment Config Split Integration (environment_context_config_split) — agent index

Submodule of **environment_context**. Registers every **Config Split** as an available environment in
Environment Context. Package `Environment`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.0.x (installed `1.0.0-rc2`, pre-release).

Dependencies (`config_split:config_split`, `environment_context:environment_context`). No UI, no routes,
no permissions, no config, no config schema, no Drush, no `.module`. One event subscriber only.

- **The subscriber and how registration works** → [api/integration.md](api/integration.md)

## What it actually is (from source)

- Service `environment_context_config_split.subscriber`, class
  `EventSubscriber\ConfigSplitEnvironmentSubscriber` (arg `@config_split.manager`), tagged
  `event_subscriber`.
- Subscribes to `AvailableEnvironmentsEvent::EVENT_NAME` (`environment_context.available_environments`).
- `onAvailableEnvironments()`: `$splitManager->listAll()` → `loadMultiple()`, then for each split
  `$event->addEnvironment($config->get('id'), $config->get('label'))`.
- Purely additive to the environment list; does not detect/switch the environment or toggle splits.

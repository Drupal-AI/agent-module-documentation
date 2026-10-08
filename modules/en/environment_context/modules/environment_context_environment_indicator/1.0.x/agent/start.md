<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment context environment indicator (environment_context_environment_indicator) — agent index

Submodule of **environment_context**. Registers every **Environment Indicator** config entity as an
available environment in Environment Context. Package `Environment`. Core `^10 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.0.x (installed `1.0.0-rc2`, pre-release).

Dependencies (`environment_indicator:environment_indicator`,
`environment_context:environment_context`). No UI, no routes, no permissions, no config, no config
schema, no Drush, no `.module`. One event subscriber only.

- **The subscriber and how registration works** → [api/integration.md](api/integration.md)

## What it actually is (from source)

- Service `environment_context_environment_indicator.subscriber`, class
  `EventSubscriber\EnvironmentContextEnvironmentIndicatorSubscriber` (arg `@entity_type.manager`),
  tagged `event_subscriber`.
- Subscribes to `AvailableEnvironmentsEvent::EVENT_NAME` (`environment_context.available_environments`).
- `onAvailableEnvironments()`: loads all `environment_indicator` entities via
  `entity_type.manager` storage and for each calls
  `$event->addEnvironment($environment->id(), $environment->label())`.
- Purely additive to the environment list; does not detect or switch the active environment.

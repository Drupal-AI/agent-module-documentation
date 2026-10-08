<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment Indicator → Environment Context integration

## Install / enable

Requires both `environment_indicator` and `environment_context` (declared in
`environment_context_environment_indicator.info.yml`). Enable with
`drush en environment_context_environment_indicator`. No configuration and no UI.

## The subscriber

`environment_context_environment_indicator.services.yml` registers one service:

- `environment_context_environment_indicator.subscriber` →
  `EventSubscriber\EnvironmentContextEnvironmentIndicatorSubscriber`, arg `@entity_type.manager`, tag
  `event_subscriber`.

Behaviour (`EnvironmentContextEnvironmentIndicatorSubscriber`):

- `getSubscribedEvents()` → listens on `AvailableEnvironmentsEvent::EVENT_NAME`
  (`environment_context.available_environments`), method `onAvailableEnvironments`.
- `onAvailableEnvironments(AvailableEnvironmentsEvent $event)`:
  - `$environments = $this->entityTypeManager->getStorage('environment_indicator')->loadMultiple();`
  - `foreach ($environments as $environment)` →
    `$event->addEnvironment($environment->id(), $environment->label());`

Result: every Environment Indicator config entity becomes an available environment (machine name =
entity `id`, label = entity label), so it appears in
`EnvironmentRegistry::getAvailableEnvironments()` / `getEnvironmentOptions()` and in the "Current
environment" condition.

## Scope / limits

- Additive only: it populates the environment *list*. It does not detect or set the active
  environment (that is still `DefaultEnvironmentDetector` / a custom detection subscriber).
- Provides no plugins, permissions, routes or config of its own.
- Pairs the Environment Indicator's visual banner with Environment Context's behavioural/caching logic
  by sharing the same environment names.

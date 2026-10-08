<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Split → Environment Context integration

## Install / enable

Requires both `config_split` and `environment_context` (declared in
`environment_context_config_split.info.yml`). Enable with
`drush en environment_context_config_split`. No configuration and no UI.

## The subscriber

`environment_context_config_split.services.yml` registers one service:

- `environment_context_config_split.subscriber` →
  `EventSubscriber\ConfigSplitEnvironmentSubscriber`, arg `@config_split.manager`, tag
  `event_subscriber`.

Behaviour (`ConfigSplitEnvironmentSubscriber`):

- `getSubscribedEvents()` → listens on `AvailableEnvironmentsEvent::EVENT_NAME`
  (`environment_context.available_environments`), method `onAvailableEnvironments`.
- `onAvailableEnvironments(AvailableEnvironmentsEvent $event)`:
  - `$all = $this->splitManager->listAll();`
  - `foreach ($this->splitManager->loadMultiple($all) as $split_name => $config)` →
    `$event->addEnvironment($config->get('id'), $config->get('label'));`

Result: every Config Split becomes an available environment (machine name = split `id`, label = split
`label`), so it appears in `EnvironmentRegistry::getAvailableEnvironments()` /
`getEnvironmentOptions()` and in the "Current environment" condition.

## Scope / limits

- Additive only: it populates the environment *list*. It does not detect or set the active
  environment (that is still `DefaultEnvironmentDetector` / a custom detection subscriber), and it does
  not activate or deactivate any Config Split.
- Provides no plugins, permissions, routes or config of its own.
- The legacy module name `environment_config_split` is migrated to this module by the parent's
  `environment_context_update_10001()`.

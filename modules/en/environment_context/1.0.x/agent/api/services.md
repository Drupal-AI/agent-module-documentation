<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, detection & events

All services are in `environment_context.services.yml`. No config, no routes, no permissions.

## Install / enable

`composer require drupal/environment_context` then `drush en environment_context`. Nothing to
configure in the UI — it works via APIs and plugins. Set the environment in `settings.php`
(`$settings['environment'] = 'staging';`) or via the `DRUPAL_ENVIRONMENT` env var. With neither set,
the environment is `default`.

## Resolver / context provider

- Service `environment_context.context.environment`, class
  `ContextProvider\EnvironmentContext` (arg `@event_dispatcher`), tagged `context_provider`.
- Implements `ContextProviderInterface` — `getRuntimeContexts()` publishes a Context keyed
  `environment` (definition data-type `environment`) holding the current env string;
  `getAvailableContexts()` advertises it. This is what makes `environment` usable in Block visibility,
  Layout Builder and other context-aware plugins.
- Also implements `EnvironmentResolverInterface` (interface aliased to the same service). Inject the
  interface and call `getCurrentEnvironment(): string`.
- `getCurrentEnvironment()` dispatches `EnvironmentDetectionEvent` **once** (guarded by
  `$eventDispatched`), stores `$event->getEnvironment() ?? 'default'`, and returns the cached value on
  later calls.

```php
public function __construct(
  private EnvironmentResolverInterface $resolver,
) {}
$env = $this->resolver->getCurrentEnvironment(); // e.g. 'production'
```

## Default detection subscriber

- Service `environment_context.subscriber.default_detector`, class
  `EventSubscriber\DefaultEnvironmentDetector` (arg `@request_stack`), tagged `event_subscriber`.
- Subscribes to `EnvironmentDetectionEvent::EVENT_NAME` (`environment_context.detect`).
- `onDetectEnvironment()`: if `Settings::get('environment', NULL)` is set → use it and return; else if
  `getenv('DRUPAL_ENVIRONMENT')` is set → use it. Order = settings.php wins over env var. It reads
  **only server-side configuration** (the injected `request_stack` is not consulted for detection).

## Registry (available environments)

- Service `environment_context.registry`, class `Environment\EnvironmentRegistry`
  (arg `@event_dispatcher`); interface `EnvironmentRegistryInterface` aliased to it.
- Every call dispatches `AvailableEnvironmentsEvent` (`environment_context.available_environments`) and
  returns the collected definitions (not statically cached).
- Methods: `getAvailableEnvironments(): string[]` (machine names),
  `getEnvironmentDefinitions(): array[]` (keyed by machine name, each has at least `label`),
  `getDefinition(string $machine_name): ?array`, `getEnvironmentOptions(): array` (options array
  seeded with `default => t('Default')`).
- `DEFAULT_ENVIRONMENT_KEY = 'default'` is defined on `EnvironmentRegistryInterface`.

## Events (extension points)

- `Event\EnvironmentDetectionEvent` — name `environment_context.detect`. Listener calls
  `setEnvironment(string)`; `getEnvironment(): ?string`. Set it to override detection.
- `Event\AvailableEnvironmentsEvent` — name `environment_context.available_environments`.
  `addEnvironment(string $machine_name, string|array|null $definition = NULL)` (string → `['label' =>
  ...]`, array merged with a fallback `label` = machine name), `getEnvironments()`,
  `getEnvironmentKeys()`, `setEnvironments()`.

```php
// Register an environment.
public function onAvailable(AvailableEnvironmentsEvent $event): void {
  $event->addEnvironment('ci', ['label' => 'CI', 'color' => '#00aaff']);
}
// Override detection.
public function onDetect(EnvironmentDetectionEvent $event): void {
  $event->setEnvironment(getenv('MY_ENV') ?: 'production');
}
```

## Update hook

`environment_context.install` → `environment_context_update_10001()` migrates a legacy
`environment_config_split` module entry to `environment_context_config_split` in `core.extension` and
clears its `system.schema` key. No schema/data changes to content.

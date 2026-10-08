<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context providers and using the API

Two pieces are required: a **Context** (extends `Drupal\contextualized_state\Context\BaseContext`) holding the state values, and a **ContextualizedStateProvider** plugin annotated `@ContextualizedStateProvider` that produces/handles that context.

## Setting context
Dispatch a `ContextEvent`; the `ContextSubscriber` picks the provider. Force a specific provider with `plugin_id`:

```php
$event = ContextEvent::from([
  'plugin_id' => 'soccer_context_provider',
  'type' => 'football',
  'campaign_id' => 21,
  'game_mode' => 'for_prize',
]);
\Drupal::service('event_dispatcher')->dispatch(ContextEvent::ON_SET_CONTEXT, $event);
```

## Reading context
```php
$manager = \Drupal::service('contextualized_state.context_manager.service');
$context = $manager->getContext('soccer_context_provider');
$all   = $context->getAll();
$value = $context->getState('campaign_id')->getValue();
```

Providers are managed by `plugin.manager.contextualized_state_provider`. See the `contextualized_state_examples` submodule (`SoccerContext`, `SoccerContextProvider`, `DispatchExampleForm`) for a complete reference implementation. State is session-scoped, so it is per-user.

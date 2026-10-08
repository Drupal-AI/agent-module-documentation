<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Release header — service, subscriber and state

The whole module is two classes wired in `environment_indicator_header.services.yml`. It reads one
Drupal state value and copies it into a `Release` HTTP response header.

## Install / enable

- `drush en environment_indicator_header -y`. Hard dependency `environment_indicator` (info.yml
  `dependencies: [ environment_indicator:environment_indicator ]`) is enabled automatically.
- Composer: `composer require drupal/environment_indicator_header`. No PHP or library
  requirements; no `composer.json` ships in the module.

## The state key (the source of the value)

- Key: `environment_indicator.current_release` (Drupal `State`, i.e. the `key_value` store — NOT
  config, so it is per-environment and not exported).
- This is the same state the parent `environment_indicator` module reads for its
  `environment_indicator_current_release` version identifier
  (`environment_indicator/src/Service/EnvironmentIndicator.php`,
  `environment_indicator/src/ToolbarHandler.php`).
- Populate it, per environment, from deployment tooling:
  - `drush state:set environment_indicator.current_release v1.2.44`
  - or `\Drupal::state()->set('environment_indicator.current_release', 'v1.2.44');`
- Default is the empty string; when empty, no header is emitted.

## `CurrentReleaseService`

`src/Service/CurrentReleaseService.php`, service id
`environment_indicator_header.current_release_service` (arg `@state`).

- `getCurrentRelease(): string` returns
  `$this->state->get('environment_indicator.current_release', '')` — the stored release, or `''`.

## `ReleaseHeaderSubscriber`

`src/EventSubscriber/ReleaseHeaderSubscriber.php`, service id
`environment_indicator_header.release_header_subscriber`, constructor arg
`@environment_indicator_header.current_release_service`, tag `event_subscriber`.

- `getSubscribedEvents()` registers `onResponse` for `KernelEvents::RESPONSE` (no explicit
  priority).
- `onResponse(ResponseEvent $event)`: gets the response, calls `getCurrentRelease()`, and only if
  the value is truthy runs `$response->headers->set('Release', $current_release)`. So the header
  fires on every response type (page, AJAX, cached, anonymous) whenever the state value is
  non-empty.

## Notes

- The header name (`Release`) and behavior are fixed in code — there is no settings form, config
  object or config schema to change them (`configure` is null; `provides_config_schema` false).
- The header value comes solely from operator-set state, never from request input, so it is fully
  operator-controlled.
- To stop emitting the header: clear the state (`drush state:delete
  environment_indicator.current_release`) or uninstall the module.

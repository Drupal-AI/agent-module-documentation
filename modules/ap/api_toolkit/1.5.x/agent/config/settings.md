<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, services & wiring

## Install / enable

`composer require drupal/api_toolkit` then `drush en api_toolkit`. Core `serialization` is a hard
dependency and is pulled in (update hooks `8002`/`8003` install it for older sites). Requires PHP 8.1,
core `^10 || ^11`. No admin UI, no permissions, no configure route.

## Config object `api_toolkit.settings`

Only two keys (`config/install/api_toolkit.settings.yml`, schema `config/schema/api_toolkit.schema.yml`):

| Key | Type | Install default | Purpose |
|-----|------|-----------------|---------|
| `route_formats` | sequence of strings | `{}` (empty) | The set of route `_format` requirement values that API Toolkit treats as "its" routes. Drives the exception-JSON subscriber and the JSON maintenance-mode subscriber. **Empty by default ⇒ no route is opted in**, so standardised error/maintenance JSON is inactive until you add your format(s). |
| `auto_validate` | boolean | `true` | Global default for whether `ApiRequestResolver` validates request objects after building them. Overridden per route by the `_api_validation` option. |

There is no settings form; edit via config sync, `drush config:set`, or `\Drupal::configFactory()->getEditable('api_toolkit.settings')`.

Update hooks (`api_toolkit.install`): `8001` sets `route_formats: ['json']` on legacy sites for
backwards compatibility; `8002`/`8003` install `serialization`; `8004` sets `auto_validate: false` on
existing sites (so validation is opt-in there, but **default-on for fresh installs**).

## Route options you set on YOUR routes

- `_format: <your_format>` — a requirement; add the same value to `route_formats` to enable error/maintenance JSON.
- `options: { _api_validation: true|false }` — force validation on/off for this route (else `auto_validate`).
- `options: { _api_validation_groups: [group, …] }` — validation groups to run.
- `options: { parameters: { x: { type: entity_uuid:<type> } } }` — upcast a UUID path segment (see
  [../normalizers/cached-normalizer.md](../normalizers/cached-normalizer.md)).

## Services (`api_toolkit.services.yml`)

- `api_toolkit.validator` — the Symfony `ValidatorInterface`, built by
  `Validation\ValidatorFactory::createValidator()` (service `api_toolkit.validator_factory`). Enables
  attribute mapping (`enableAttributeMapping`) and, where available, annotation/Doctrine mapping, using
  Drupal's `ConstraintValidatorFactory` (so constraint validators resolve from the container).
- `api_toolkit.normalizer.api_request` (tagged `normalizer`) — `ApiRequestNormalizer`, wraps
  `api_toolkit.normalizer.object` (`ObjectNormalizer`) + the validator.
- `api_toolkit.argument_resolver.api_request` — `ApiRequestResolver`; **not** tagged, instead unshifted
  into `http_kernel.controller.argument_resolver` by `ApiToolkitServiceProvider::alter()` (removed if
  `serializer` is missing).
- `api_toolkit.cached_normalizer` + `cache.api_toolkit_normalizer` (cache bin) — see the normalizer doc.
- `paramconverter.api_toolkit.entity_uuid` (tagged `paramconverter`) — `EntityUuidConverter`.
- `api_toolkit.exception_json.subscriber`, `api_toolkit.maintenance_mode.subscriber` — the two event
  subscribers (see [../api/responses.md](../api/responses.md)); both take `router.no_access_checks`.
- `ApiToolkitServiceProvider::register()` adds `RegisterSerializationClassesCompilerPass`
  (TYPE_BEFORE_OPTIMIZATION, priority −10) that seeds `CachedNormalizer` with the core serializer's
  normalizers/encoders.

## Operating notes

- The module is inert until you write routes + controllers that use its request/response/normalizer
  classes. It defines no endpoints of its own.
- Access control, entity `access()` checks, CSRF and rate limiting on your endpoints are entirely your
  responsibility — API Toolkit does not add any.
- To exercise it, enable the `api_toolkit_examples` submodule (demonstration only — not for production).

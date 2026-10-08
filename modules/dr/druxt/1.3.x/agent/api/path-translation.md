<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Router path-translation subscribers & CORS

DruxtJS enriches Decoupled Router's `/router/translate-path` response so a Nuxt frontend can turn a
front-end path into Drupal entity/route + JSON:API data. Three subscribers extend
`decoupled_router.router_path_translator.subscriber` (declared in `druxt.services.yml`, all tagged
`event_subscriber`), plus one CORS service modifier. Access to the translate-path endpoint itself is
governed by Decoupled Router, not by these subscribers; each subscriber only shapes the response for
paths it recognises and then `stopPropagation()`.

Shared behaviour (each `onPathTranslation()`): clean the sub-directory from the path, `router->match()`
it; on `ResourceNotFoundException` return a `200 {resolved: <path>}` if the path is external, else
bail; on `MethodNotAllowedException` return `403`.

## `ContactPathTranslatorSubscriber`

Skips unless the `contact` module is enabled. Acts only when the matched route is
`contact.site_page`. Loads the site default contact form (`contact.settings:default_form`) and emits
`resolved`, `isHomePath`, an `entity` block (type/bundle/id/uuid), and — when `jsonapi` is enabled —
a `jsonapi` block (individual URL, `resourceName`, `pathPrefix`/`basePath`, `entryPoint`) built from
`jsonapi.resource_type.repository`, plus a `meta.deprecated` note that `jsonapi.pathPrefix` is
superseded by `basePath`.

## `ViewsPathTranslatorSubscriber`

Skips unless `jsonapi_views` is enabled (a `@TODO` notes this exists pending Decoupled Router support
in JSON:API Views). Acts when the match has a `view_id`. Loads the view, builds an executable for the
`display_id`, emits `resolved`, `isHomePath`, a `view` block (uuid/view_id/display_id), `label`
(executable title), and — when `jsonapi` is on — the same `jsonapi` block/`meta` as above. Then tries
`Url::fromRoute("jsonapi_views.<view_id>.<display_id>")`; on success adds `jsonapi_views` (the endpoint
URL), on `RouteNotFoundException` leaves it out (not every view has a JSON:API Views route).

## `WildcardPathTranslatorSubscriber`

No module guard. For any matched route builds the resolved URL; on
`MissingMandatoryParametersException` returns `500 {message, details}`. Otherwise emits `resolved`,
`isHomePath`, `label`, and `context` (the full `router->match()` result), status `200`. This is the
generic fallback resolver.

## CORS — `DruxtServiceProvider`

`src/DruxtServiceProvider.php` (`ServiceModifierInterface::alter()`): if `cors.config` is **not
already enabled**, sets `enabled = TRUE`, and when empty sets `allowedHeaders = ['*']` and
`allowedMethods = ['*']` (so preflighted requests are not rejected). It does **not** touch
`allowedOrigins`; a site that already enabled CORS is left untouched. Configure allowed origins in
`services.yml`/`settings.php` per your deployment.

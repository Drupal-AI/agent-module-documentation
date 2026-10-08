<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced 403 Redirect — entity, validators, subscriber, routes

No `*.settings` config object and no settings form. All behavior comes from `access_denied_url`
content entities you create in the admin UI.

## Install / enable

`drush en advanced_403_redirect -y` (module dir may report itself as *Advanced 403 Redirect*;
the drupal.org project/README also call it *Flexible 403 Redirect*). The bundled listing is a
View, so keep `views` and `user` enabled — the shipped `config/install/views.view.advanced_403_redirect.yml`
depends on both. `info.yml` declares no hard module dependencies and `composer.json require` is
empty.

## The entity: `access_denied_url`

`src/Entity/AccessDeniedUrl.php` — a `ContentEntityType`:

- `base_table: access_denied_url`, keys `id` / `label` / `uuid`.
- `admin_permission = "administer access denied url"`.
- handlers: list builder `AccessDeniedUrlListBuilder`, form (add/edit) `AccessDeniedUrlForm`,
  delete = core `ContentEntityDeleteForm`, route provider `AdminHtmlRouteProvider`,
  `views_data` = `EntityViewsData`.
- `field_ui_base_route = "entity.access_denied_url.settings"`.

Base fields (`baseFieldDefinitions()`):

| Field | Label | Notes |
|-------|-------|-------|
| `label` | Source Url | required, max 255, constraint **`SourceValidation`** |
| `description` | Destination Url | required, constraint **`DestinationValidation`** |
| `message` | Display user redirect message | optional string shown on redirect |

## Validators (`src/Plugin/Validation/Constraint/`, services in `*.services.yml`)

- **`SourceValidationConstraintValidator`** (service `advanced_403_redirect.source_validator`,
  args `entity_type.manager`, `database`, `router.no_access_checks`, `path_alias.manager`):
  source must start with `/`; must be unique in the `access_denied_url` table; must match a route
  (`router->match()`); the aliased path must resolve to a loadable entity (regex
  `#^/([^/]+)/(\d+)$#`); and that entity **must be unpublished** (`isPublished()` → violation if
  published). Error strings: `invalidUrlSyntax`, `urlAlreadyExist`, `invalidRouteMessage`,
  `invalidEntityMessage`, `sourceUnpublishedMessage`.
- **`DestinationValidationConstraintValidator`** (service
  `advanced_403_redirect.destination_validator`, arg `router.no_access_checks`): destination must
  start with `/` (`invalidUrlSyntax`) and must resolve to a valid route via `router->match()`
  (`invalidRouteMessage`). Destinations are therefore constrained to local, routable paths.

Both constraints run when the entity is validated (the `ContentEntityForm` save path calls
`validate()`).

## The 403 subscriber (`src/EventSubscriber/AccessDeniedRedirectSubscriber.php`)

- Extends `HttpExceptionSubscriberBase`; `getHandledFormats() => ['html']`; service
  `advanced_403_redirect.access_denied_subscriber`, args `messenger`, `current_user`, `database`.
- `on403(ExceptionEvent $event): void`:
  1. If `current_user->getRoles()` contains `administrator`, do nothing (admins still see the
     real 403).
  2. Otherwise read `$request->getPathInfo()` and run a parameterized
     `select('access_denied_url')` where `label` = that path, fetching `description` + `message`.
  3. On a hit: if `message` is non-empty, `messenger->addMessage($message, 'warning')`; then set
     `RedirectResponse($description)` as the event response.

The redirect target is the stored `description` (the admin-configured, route-validated
Destination Url) — it is not built from any request query parameter, referrer or the requested
path.

## Routes & permissions

- Auto entity routes (via `AdminHtmlRouteProvider`), all gated by `administer access denied url`
  (`*.permissions.yml`, `restrict access: true`):
  - collection `/admin/content/access-denied-url`
  - add `/access-denied-url/add`
  - canonical `/access-denied-url/{access_denied_url}`
  - edit `/access-denied-url/{access_denied_url}/edit`
  - delete `/access-denied-url/{access_denied_url}/delete`
- Listing View page `view.advanced_403_redirect.page_1` at `/admin/redirect-403-urls`, access
  permission **`administer views`** (`config/install/views.view.advanced_403_redirect.yml`).
  Menu link `advanced_403_redirect.overview` sits under *Configuration → Search*
  (`system.admin_config_search`); action link `access_denied_url.add_form` appears on the View.
- After a save, `AccessDeniedUrlForm::save()` redirects back to `view.advanced_403_redirect.page_1`
  and logs a notice on the `advanced_403_redirect` logger channel.

## Operate it

1. Unpublish the content you want to divert (source validation rejects published entities).
2. Go to `/admin/redirect-403-urls` → *Add access denied url*.
3. Set **Source Url** (e.g. `/node/123`) and **Destination Url** (e.g. `/archive`), optionally a
   **Message**, and save.
4. A non-administrator hitting the source path now gets redirected to the destination instead of
   the 403 page, with the message flashed if set.

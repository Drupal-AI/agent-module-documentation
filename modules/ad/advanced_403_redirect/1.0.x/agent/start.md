<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced 403 Redirect (advanced_403_redirect) — agent index

Per-path rules that replace the default **403 (access denied)** page with a redirect to an
admin-configured internal destination, plus an optional flash message. Package `Other`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1. No composer or declared module
dependencies (the admin listing is a View, so `views` + `user` must be enabled in practice).

- **Entity, fields, validators, the 403 subscriber, routes, permission and the listing View** →
  [config/settings.md](config/settings.md)

## What it actually is

- One content entity type: `access_denied_url` (`src/Entity/AccessDeniedUrl.php`, extends
  `ContentEntityBase`), base table `access_denied_url`, `admin_permission = "administer access
  denied url"`, route provider `AdminHtmlRouteProvider`, list builder
  `AccessDeniedUrlListBuilder`, form `AccessDeniedUrlForm`.
- Three base fields: `label` = **Source Url** (constraint `SourceValidation`), `description` =
  **Destination Url** (constraint `DestinationValidation`), `message` = optional redirect message.
- One event subscriber: `AccessDeniedRedirectSubscriber` (`src/EventSubscriber/`, extends
  `HttpExceptionSubscriberBase`, `getHandledFormats() => ['html']`). `on403()` fires on 403
  kernel exceptions.
- Two constraint validators (`src/Plugin/Validation/Constraint/`): `SourceValidation…` and
  `DestinationValidation…`, wired as services in `advanced_403_redirect.services.yml`.
- One permission: `administer access denied url` (`*.permissions.yml`, `restrict access: true`).
- One listing View: `views.view.advanced_403_redirect` (`config/install/`), display `page_1` at
  path `admin/redirect-403-urls`, access permission `administer views`. Menu link under
  *Configuration → Search*; add-form action link on the listing.

## Mechanism (from source)

- `on403(ExceptionEvent $event)`: if the current user does **not** have the `administrator` role,
  it reads `$request->getPathInfo()`, runs a parameterized `select('access_denied_url')` for the
  row whose `label` equals that path, and if found sets a `RedirectResponse($row['description'])`
  and (when `message` is non-empty) adds it via `messenger->addMessage(…, 'warning')`.
- No settings/config form is shipped; behavior is driven entirely by the stored entities.
- No config schema files, no Drush commands, no hooks, no plugin types defined by the module.

## Routes & access

- Entity routes (auto): collection `/admin/content/access-denied-url`, add
  `/access-denied-url/add`, canonical/edit/delete under `/access-denied-url/{id}…` — all gated by
  `administer access denied url`.
- Listing View page `/admin/redirect-403-urls` — gated by `administer views`.

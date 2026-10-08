<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Links (jsonapi_links) — agent index

Strips `links` members from Drupal's JSON:API responses to shrink payloads. The entire module is a
single `KernelEvents::RESPONSE` subscriber (`jsonapi_links.subscriber`, priority 112): on any
response whose `Content-Type` is `application/vnd.api+json` and whose body has a top-level `jsonapi`
property, it re-decodes the JSON, recursively `unset()`s `links` (and now-empty `meta.links`) from
every resource, `included` item and relationship, then re-encodes the body. It never adds anything to
the output — it only removes. Behaviour is off until you enable it; the `/jsonapi` root document and
the document-level pager `links` are always preserved.

Configured at one site-global settings page (`/admin/config/services/jsonapi/links`) via two config
keys: `remove_links` (master switch, default `false`) and `ignore_list` (newline-separated PHP
regexes matched against a dotted response path to keep specific `links` subtrees).

- Depends on: `drupal:jsonapi`, `drupal:user` (info.yml). No external libraries, no composer.json.
- Core: `^10.3 || ^11`. Package: `Web services`. Version **1.1.0**.
- Settings page / `configure` route: **yes** — `jsonapi_links.settings`, gated by
  `administer site configuration`. Provides config schema. **No** module permissions, **no** drush,
  **no** plugin types, **no** fields/widgets/formatters.

## What you'd do → where

- **Turn removal on/off, or keep specific links via the ignore-list regexes** →
  [configure/settings.md](configure/settings.md)
- **Understand exactly when the subscriber fires, what it strips vs. keeps, and the ignore-list
  path-matching** → [api/response-subscriber.md](api/response-subscriber.md)

## Key facts (real machine names)

- Route: `jsonapi_links.settings` → `/admin/config/services/jsonapi/links`, requirement
  `_permission: 'administer site configuration'`. Local task title "JSON:API Links" under
  `jsonapi.settings` (`jsonapi_links.links.task.yml`).
- Form: `Drupal\jsonapi_links\Form\SettingsForm` (id `jsonapi_links_settings`, extends
  `ConfigFormBase`).
- Service: `jsonapi_links.subscriber` = `Drupal\jsonapi_links\EventSubscriber\ResponseSubscriber`
  (deps `config.factory`, `current_route_match`; `KernelEvents::RESPONSE` @ priority 112).
- Config object: `jsonapi_links.settings` — keys `remove_links` (boolean, default `false`),
  `ignore_list` (string, default `''`). Schema `FullyValidatable`.
- Exception class: `Drupal\jsonapi_links\Exception\JsonApiLinksException` (thrown on
  header/content/decode/encode failures).
- No new endpoints beyond the admin settings form; the subscriber only removes data from existing
  JSON:API responses.

## What it does NOT do

Removing links is a size/noise optimisation, not a security control — unlinked resources stay
reachable at their canonical JSON:API paths. It is safe for a front end you control; a **generic**
JSON:API client that discovers rather than hard-codes URLs (or relies on the `self` link to re-fetch
a resource) will break. Use `jsonapi_permission` or entity access for the real access boundary.

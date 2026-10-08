<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Page Limit (jsonapi_page_limit) — agent index

Lifts JSON:API's fixed 50-item collection cap for chosen **request paths**, so a client that
explicitly sends `?page[limit]=N` can get up to a per-path maximum. Depends on core `jsonapi`.
Core requirement `^10 || ^11`. No admin UI, routes, permissions, config entity or Drush commands —
configuration is a raw container parameter.

## What you'd do → where

- **Understand the mechanism / real names** → this file, "Key facts" below.
- **Configure per-path limits (the only setup)** → [agent/configuration/services-yml.md](configuration/services-yml.md).
- **See the code** → `src/Controller/EntityResource.php` (`getJsonApiParams()`, private `getMax()`),
  service override in `jsonapi_page_limit.services.yml`.
- **Decide whether to use this vs. an alternative** → README notes `jsonapi_defaults` (in
  `jsonapi_extras`) as the more actively maintained option; it makes the raised number the *default*,
  whereas this module keeps 50 as the default and only honours a larger explicit `page[limit]`.

## Key facts (real names)

- **Service override:** `jsonapi_page_limit.services.yml` re-registers `jsonapi.entity_resource`
  → `Drupal\jsonapi_page_limit\Controller\EntityResource` (subclass of core
  `Drupal\jsonapi\Controller\EntityResource`).
- **Overridden method:** `EntityResource::getJsonApiParams()`. Only when the request carries a
  `page[limit]` (`OffsetPage::KEY_NAME` / `SIZE_KEY`) does it rebuild the `OffsetPage` with size
  `min($requested_limit, $per_path_max)`, bypassing core's clamp to `OffsetPage::SIZE_MAX` (**50**).
- **Config parameter:** `jsonapi_page_limit.size_max` — a map of path patterns → integers, set in a
  custom `services.yml` (e.g. `sites/default/services.yml`). **Empty by default** → module is a no-op
  until configured.
- **Path lookup:** current path via `router.request_context->getPathInfo()`, matched against each
  parameter key with `path.matcher` (`PathMatcherInterface::matchPath`, wildcards allowed). On
  multiple matches, `reset()` picks the **first** array entry; unmatched paths fall back to 50.
- **Default is unchanged:** a raised path still returns 50 unless the client asks for more. It caps,
  never inflates — a request without `page[limit]` is untouched.
- **Requires a container rebuild** (`drush cr`) after editing the parameter.
- **Access control untouched:** every returned entity still passes JSON:API entity access checks; only
  the pagination ceiling moves. The trade-off is performance, not authorization.
- **No config schema, no `config/` directory, no permissions, no plugin types, no libraries.**

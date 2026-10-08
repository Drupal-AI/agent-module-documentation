<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MD Sitemap — configuration, routes, permissions

## Install / enable

`composer require drupal/mdsitemap` then `drush en mdsitemap`. No external module deps
(`info.yml`: `drupal:system (>=10)`; core `^10 || ^11`; PHP `>=8.3`). Install writes
`config/install/mdsitemap.settings.yml` defaults: `url_suffix: '.md'`, `sitemap_path:
'/sitemap-llm'`, `entities: {}` (nothing selected — the sitemap is empty until you pick bundles).

## Config object `mdsitemap.settings`

Schema `config/schema/mdsitemap.schema.yml` (`type: config_object`):

- `url_suffix` (string) — appended to every listed URL. Default `.md`.
- `sitemap_path` (string) — the endpoint path. Default `/sitemap-llm`.
- `entities` (mapping) — per entity type a sequence of bundle machine names to include, e.g.
  `entities: { node: [page, article], taxonomy_term: [tags] }`.

## Settings form `Form\SitemapSettingsForm` (`mdsitemap_settings_form`)

- Route `mdsitemap.settings` at `/admin/config/search/md-sitemap`, permission
  **`administer site configuration`**; menu link under *Configuration → Search and metadata*.
- `buildForm()` renders `url_suffix` (required textfield), `sitemap_path` (required textfield),
  and an **Entity inclusion** `details` group: it iterates `entity_type.manager` definitions and,
  for every type with a `canonical` link template, adds a `checkboxes` element whose options are
  that type's bundles (from `entity_type.bundle.info`). So any content entity with a canonical URL
  (node, taxonomy_term, media, user, commerce_product, custom types…) is selectable.
- `validateForm()` trims `sitemap_path`, forces a leading `/`, strips a trailing `/`, and requires
  it to match `@^/[A-Za-z0-9/_\-]+$@` (letters, digits, `/`, `_`, `-` only) — rejects empty or
  non-string paths.
- `submitForm()` saves `url_suffix`, the normalized `sitemap_path`, and `entities` (rebuilt as
  `entity_type => array_keys(array_filter($bundles))`, i.e. only checked bundles). Then it
  `deleteAll()`s the `cache.mdsitemap` bin and calls `router.builder->rebuild()` so a changed path
  takes effect immediately.

## Route path override `Routing\RouteSubscriber`

`alterRoutes()` looks up `mdsitemap.sitemap`, reads `sitemap_path` from config (falls back to
`/sitemap-llm`), normalizes leading/trailing slashes, and `$route->setPath($path)`. Registered as
an `event_subscriber`; this is why the static `/sitemap-llm` in `routing.yml` is only the default.

## Access model

- The sitemap route is `_access: 'TRUE'` — **served to anonymous by design** (a sitemap). There is
  no per-viewer permission on it. Because the endpoint is public, only content you intend to be
  publicly/AI-discoverable should be selected in *Entity inclusion*.
- The generator only lists **published** entities (`status = 1` where the type has a status key)
  that pass an **access check for the requester** (`accessCheck(TRUE)`), and only those with a
  `canonical` link template.
- The settings form is the only privileged surface (`administer site configuration`).

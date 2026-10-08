<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Ads — install artifacts, config & permissions

## Install (`basic_ads.install`)
`basic_ads_install()` builds everything from code (no config/install entities for the content model except the settings/vocab/node-type/view YAML in `config/install/`):
- **Vocabulary** `basic_ad_placement` with default terms: Header, Sidebar, Footer, Content Top, Content Bottom.
- **Content type** `basic_ad` (`node.type.basic_ad.yml`).
- **Fields on `basic_ad`** (created in `_basic_ads_create_fields()`):
  - `field_ad_image` — image, required, `file_directory: ads/images`, `max_filesize: 2 MB`, `max_resolution: 1920x1080`, alt required.
  - `field_ad_link` — link, optional, title enabled.
  - `field_ad_placement` — entity_reference to `taxonomy_term` (bundle `basic_ad_placement`), required, unlimited cardinality.
  - `field_ad_start_date` / `field_ad_end_date` — datetime (date-only), optional. (`update_9004`/`9007` migrated these from string to datetime.)
  - `field_ad_weight` — integer, range −50..50, default 0 (bounds added by `basic_ads_update_9003`).
- **View** `basic_ads_advertisements` (`views.view.basic_ads_advertisements.yml`) with a `block_1` display.
- **Tables** via `hook_schema()`: `basic_ads_impressions` (id, nid, timestamp, ip_address, user_agent, placement) and `basic_ads_clicks` (…+ referrer).

`hook_uninstall`/update hooks also manage form/view display components. Don't hand-edit the tables; use the services.

## Config object `basic_ads.settings`
- `config/install/basic_ads.settings.yml`: `excluded_roles: []`.
- Schema `config/schema/basic_ads.schema.yml`: `basic_ads.settings` is a `config_object` (`FullyValidatable`) with `excluded_roles` = sequence of role-ID strings (`requiredKey: false`). Also defines `block.settings.basic_ads_advertisement_block` (`ad_placement_term` int nullable, `count` int).

## Settings form
`Form\BasicAdsSettingsForm` (route `basic_ads.settings`, `/admin/config/system/basic-ads`, permission `administer basic ads`). One field: `excluded_roles` checkboxes built from all `user_role` entities. `submitForm()` stores `array_values(array_filter(...))` (a sequence of role IDs). Used by `AdTracker::isUserExcluded()` — if the current user has any excluded role, impressions/clicks are silently not recorded.

## Permissions (`basic_ads.permissions.yml`)
- `administer basic ads` — `restrict access: true`. Gates only the settings form.
- Ad authoring uses **standard core node permissions** for the `basic_ad` bundle (create/edit/delete). The stats dashboard uses core `administer nodes`.

## Menu links (`basic_ads.links.menu.yml`)
- `basic_ads.settings` under System config; `basic_ads.stats` ("Basic Ad Reporting") under Reports.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: credentials, UI settings & field customization

All settings live in the single config object **`collector_systems.settings`** (config schema is
declared — `data.json.provides_config_schema` true; the `.info.yml` lists it under `config:`).

## Main settings form

`Form/CustomApiIntegrationSettingsForm` (`ConfigFormBase`), route
`custom_api_integration.settings_form` → `/admin/collector-systems/custom_api_integration/settings`,
`_permission: administer site configuration`. This is the module's `config/system` menu parent
("Collector Systems", `collector_systems.links.menu.yml`).

**API Integration group:**

| Config key | Widget | Purpose |
|---|---|---|
| `subscription_key` | textfield (required) | Sent as the `Ocp-Apim-Subscription-Key` header on every API call (Azure API Management subscription key). |
| `account_guid` | textfield (required) | The account GUID path segment in every API URL. |
| `subscription_id` | textfield (required) | OData `$filter=SubscriptionId eq …` value. |
| `azure_map_subscription_key` | textarea | Azure Maps client key; injected into `drupalSettings.azure_map.subscription_key` on detail pages when maps are enabled (client-side by design). |

**UI-customization group** (all read back in `hook_preprocess_html` / templates / blocks):
`show_field_labels`, `show_images_on_list_pages` (checkboxes → stored as five booleans
`show_images_objects|groups|collections|exhibitions|artists`), `enable_alphabetical_artists`,
`enable_maps`, `enable_advanced_search` (off by default — gates `AdvancedSearchService`),
`enable_transition`, `center_align_images`, `image_bg_color` (color, default `#ffffff`),
`body_font_size` (default `16px`), `object_detail_page_title_font_size`,
`bold_customized_field_labels`, `underline_all_hyperlinks`, `enable_zoom`, `filter_keywords`
(multi-select whose options are fetched **live** from the API's `AttachmentKeywords` endpoint in
`get_filter_keywords_options()`), `items_per_page` (page size, e.g. 9/15/…/198). When the active
theme is `collectorsystems`, an extra `homepage_image` managed-file field appears.

`hook_preprocess_html` turns several of these into `<body>` classes / `data-*` attributes
(`cs-underline-all-hyperlinks`, `cs-center-align-images`, `cs-enable-transition`, `data-cs-image-bg`,
`data-cs-body-font-size`, …) consumed by the bundled CSS/JS.

## Field-customization forms (which fields render)

Three separate forms drive what the front-end shows, storing selections in DB tables rather than
config:

- `Form/CustomizeObjectListFieldsSettingsForm` → `/admin/collector-systems/customize_object_list_fields/settings`
- `Form/CustomizeObjectDetailFieldsSettingsForm` → `/admin/collector-systems/customize_object_detail_fields/settings`
- `Form/CustomizeArtistDetailFieldsSettingsForm` → `/admin/collector-systems/customize_artist_detail_fields/settings`
  (route `collector_systems.customize_artist_detail_fields`)

All three require `administer site configuration`. They use a two-list "add to selected" pattern
(`collector_systems_form_alter` attaches JS + a custom validator
`collector_systems_custom_validate_allowed_values` that *clears* allowed-value errors so
dynamically-added options pass). Selected object fields are written to
`collector_systems_clsobjects_fields` (columns `fieldname`/`fieldvalue`/`fieldtype`, where
`fieldtype` is `ObjectList` or object-detail); artist fields to
`collector_systems_artists_selected_fields`. `ObjectFieldsService` / `ArtistFieldsService` read
these back.

The full catalogue of ~hundreds of possible Collector Systems field names and their labels/types
lives as constants in `src/Csconstants.php`; `src/Csfieldregistry.php` + `src/Csfieldresolver.php`
map a raw field name to its category (date, boolean, richtext, controlled-vocab, additional-array,
generic…), its display label, its link behaviour, and its **escaped** rendered value
(`Csfieldresolver::getValue()` returns `Html::escape()` for generic values and `Xss::filterAdmin()`
for rich-text — so synced values are sanitized before display).

## API client construction

`CollectorSystemsGetApiData` reads `subscription_key` / `account_guid` / `subscription_id` from
`collector_systems.settings` in its constructor and builds OData URLs against
`Csconstants::Public_API_URL`. Every request pins TLS verification on
(`CURLOPT_SSL_VERIFYPEER = true`, `CURLOPT_SSL_VERIFYHOST = 2`). The subscription key travels only
in the outbound request header — it is **not** emitted into `drupalSettings` or any template. See
[../sync/data-sync.md](../sync/data-sync.md).

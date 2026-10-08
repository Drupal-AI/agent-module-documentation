<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Adobe Analytics

## Install & enable

```bash
composer require drupal/adobe_analytics
drush en adobe_analytics -y
```

Depends on core **`field`** and contrib **`token`** (`drupal/token:^1.0`). No submodules, no Drush.

## Where it hooks in

`adobe_analytics_page_bottom()` (in `adobe_analytics.module`) attaches, on every page, a lazy
builder that renders the tracking markup:

```php
$variables['adobe_analytics'] = [
  '#lazy_builder' => ['adobe_analytics.variable_formatter:renderMarkup', []],
  '#create_placeholder' => TRUE,
  '#cache' => [
    'contexts' => ['user.roles'],
    'tags' => \Drupal::config('adobe_analytics.settings')->getCacheTags(),
  ],
];
```

`hook_theme()` in the same file registers the `analytics_code` theme hook rendered by
`templates/analytics-code.html.twig`, which emits `<script src="{js_file_location}">` plus an inline
`<script>` containing the formatted variables and, optionally, a `<noscript>` tracking image.

## Settings form

Route **`adobe_analytics.settings`** → path **`/admin/config/search/adobeanalytics`**, permission
**`administer adobe analytics configuration`**. Form class
`src/Form/AdobeAnalyticsAdminSettings.php` (`ConfigFormBase`, form id `adobe_analytics_settings`),
menu link `adobe_analytics.admin` (parent `system.admin_config_search`). All values save into the
config object **`adobe_analytics.settings`**.

| Config key | Form field | Meaning |
|---|---|---|
| `js_file_location` | Complete path to Adobe Analytics JavaScript file (**required**) | URL of the hosted AppMeasurement / `s_code` JS. Empty ⇒ module treated as unconfigured (no output). |
| `version` | Adobe Analytics version (**required**) | Reporting version string; shown in the template comment (install default `H.20.3.`). Empty ⇒ unconfigured. |
| `image_file_location` | Complete path to Adobe Analytics Image file | Optional `<noscript>` 1×1 tracking image URL. |
| `token_cache_lifetime` | Token cache lifetime | Seconds the token cache stays valid; cleared on cron after that or on form save. |
| `role_tracking_type` | Add tracking for specific roles | `inclusive` (track only selected roles) or `exclusive` (track all except selected). Install default `exclusive`. |
| `track_roles` | (checkboxes of roles) | The selected role ids used by `role_tracking_type`. |
| `extra_variables` | Custom Variables table | Sequence of `{name, value}` pairs. `value` supports tokens. |
| `codesnippet` | Advanced → JavaScript Code | Free-form JS run on every tracked page; supports tokens. |

Config schema is in `config/schema/adobe_analytics.schema.yml` (`adobe_analytics.settings` is a
`config_object`; each `extra_variables` entry is an `adobe_analytics.variable` with `name`/`value`;
plus `field.value.adobe_analytics`). Install defaults are in
`config/install/adobe_analytics.settings.yml`.

Variable **names** are validated by `validateVariableName()` against
`/^[A-Za-z_$]{1}\S*$/` (must start with a letter/`$`/`_`, no spaces) and capped at 40 chars. The
"Add variable" button is AJAX (`addVariable` / `addVariableCallback`); empty name+value rows are
dropped on submit (`submitForm()`).

### Example config export

```yaml
# adobe_analytics.settings
js_file_location: 'https://assets.adobedtm.com/launch-EN.min.js'
version: 'H.20.3.'
image_file_location: ''
token_cache_lifetime: 0
role_tracking_type: exclusive
track_roles:
  administrator: administrator
extra_variables:
  - name: prop9
    value: '[current-page:title]'
  - name: eVar1
    value: '[current-user:uid]'
codesnippet: 's.pageType="";'
```

## How the payload is built

Service graph (`adobe_analytics.services.yml`):

- **`adobe_analytics.variables_factory`** → `VariablesFactory::load()` reads
  `adobe_analytics.settings`. If `js_file_location` or `version` is empty it returns a
  `ModuleNotConfiguredVariables` null-object (which also logs a warning) and nothing is output.
  Otherwise it builds a `Variables` object with the JS URL, version, no-js image, the `codesnippet`,
  every module's `hook_adobe_analytics_variables()` return, and the `extra_variables` list.
- **`adobe_analytics.variable_formatter`** → `VariableFormatter` (a `TrustedCallbackInterface`,
  trusted callback `renderMarkup`). `renderMarkup()`:
  1. returns `[]` if unconfigured or if `access()` is forbidden;
  2. otherwise returns the `analytics_code` render array with `#js_file_location`, `#version`,
     `#image_location`, and `#formatted_vars` (from `getFormattedVariables()`).
- `getFormattedVariables()` assembles, in order: header section variables, the main `codesnippet`,
  the main variables section, the footer section, then any per-entity snippet (see below). Variable
  values go through `renderVariables()` → `tokenReplace()` with `['clear' => TRUE, 'sanitize' => TRUE]`
  and are emitted as `name="value";`. Keys are `htmlspecialchars()`-encoded.

### Tokens

`tokenReplace()` (in `VariableFormatter`) calls the core `token` service. It sniffs the entity type
out of a `[type:...]` token (`getEntityTypeFromText()`, mapping `term` → `taxonomy_term`) and, if the
current routed path carries that entity as a parameter, loads it as token data
(`extractTokenEntityFromPath()`). Modules/tests can also inject token context via
`addTokenContext(ContentEntityInterface, $type)`. Supported token groups advertised in the UI:
`node`, `menu`, `term`, `user`, plus global tokens.

## Which requests get tracked (tracking matchers)

`VariableFormatter::access()` combines every service tagged **`adobe_analytics_tracking_matcher`**
(wired in by `src/AdobeAnalyticsServiceProvider.php`) with OR-logic, but any `forbidden()` wins.
Two ship by default:

- `TrackingMatcher\AdminContext` — returns `forbidden` on admin routes (via core
  `router.admin_context`), so tracking never renders on `/admin/*`.
- `TrackingMatcher\RoleContext` — reads `role_tracking_type` + `track_roles` and the current user's
  roles: `inclusive` allows when there is overlap, `exclusive` allows when there is none, else
  `forbidden`.

Add your own matcher by defining a service implementing
`TrackingMatcher\TrackingMatcherInterface` and tagging it `adobe_analytics_tracking_matcher`.

## Contributing variables from code

Implement `hook_adobe_analytics_variables()` returning an array keyed by section
(`header` / `variables` / `footer`; constants on `VariablesInterface`), each an
`name => value` map. Example (`tests/adobe_analytics_test/adobe_analytics_test.module`):

```php
function mymodule_adobe_analytics_variables() {
  return [
    'header'    => ['date'  => date('Ymd')],
    'variables' => ['prop1' => 'value'],
    'footer'    => ['eVar5' => 'value'],
  ];
}
```

## Per-entity override (the `adobe_analytics` field)

Attach a field of type **`adobe_analytics`** (`src/Plugin/Field/FieldType/AdobeAnalyticsItem.php`,
cardinality 1) to any bundle. Its widget (`AdobeAnalyticsWidget`) shows an *Adobe Analytics* details
group on the entity edit form with three properties:

- `include_custom_variables` (checkbox) — include the global header/main/footer variables;
- `include_main_codesnippet` (checkbox) — include the global `codesnippet`;
- `codesnippet` (textarea) — an entity-specific JS snippet (tokens supported).

When such an entity is the routed object, `VariableFormatter::extractEntityOverrides()` finds the
field via `entity_field.manager` `getFieldMapByFieldType('adobe_analytics')`, reads the first item's
values, toggles the two include flags, and appends the entity `codesnippet` after the global payload.
The default field formatter (`AdobeAnalyticsFormatter`) renders nothing on the entity display — the
snippet only affects the page-bottom tracking output.

## Operating notes

- Nothing renders until both `js_file_location` and `version` are set; until then a warning is
  logged on each request (`ModuleNotConfiguredVariables`).
- Output is cached per `user.roles` and invalidated by the settings config's cache tags, so saving
  the form refreshes tracking for all users.
- The module makes **no server-side HTTP request**; the AppMeasurement file is fetched by the
  browser from `js_file_location`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Entity Field Fetch field type, widget & formatter

## Install & enable

```bash
composer require drupal/entity_field_fetch
drush en entity_field_fetch -y
```

No dependencies, no submodules, no permissions, no Drush commands, **no settings page**.
Everything is configured **per field**.

## Field type — `EntityFieldFetchItem`

`src/Plugin/Field/FieldType/EntityFieldFetchItem.php`, `@FieldType(id = "entity_field_fetch",
label = "Entity Field Fetch field", default_widget = "entity_field_fetch_widget",
default_formatter = "entity_field_fetch")`, extends `FieldItemBase` implements
`CacheableDependencyInterface`.

- **`schema()`** returns a single `value` column (`int`, `size tiny`, "Not needed but required by
  Drupal"). The field intentionally stores nothing meaningful; all data is computed.
- **`propertyDefinitions()`** — one internal `value` (boolean, "unused value") plus five computed,
  non-internal properties: `target_type` (string), `target_id` (string), `target_field` (string),
  `fetched_bundle` (string), and `fetched` (`any`). `mainPropertyName()` = **`fetched`**.
- **`isEmpty()`** always returns FALSE (values are always computed).
- **`__construct()`** grabs `entity_field_fetch.fetcher` from `\Drupal::service()` (create()/DI does
  not fire for field items) and calls `$fetcher->setFieldDefinition(...)`.
- **`setValue()`** populates the computed values from the Fetcher: `target_type`
  (`getTargetEntityType()`), `target_id` (`getTargetId()`), `target_field`
  (`getTargetFieldName()`), `fetched_bundle` (`getFetchedBundle()`), `fetched`
  (`getEntityData()`); then `parent::setValue($values, FALSE)`.
- **Caching** delegates to the Fetcher: `getCacheContexts()`, `getCacheTags()`,
  `getCacheMaxAge()` returns **5000** seconds.

### Field settings (`defaultFieldSettings()` / `fieldSettingsForm()`)

| Setting | Form element | Required | Meaning |
|---|---|---|---|
| `target_entity_type` | select (`node` / `term`) | no | Source entity type. |
| `target_entity_id` | number (min 1) | **yes** | Source nid or tid. |
| `field_to_fetch` | textfield (maxlength 32) | **yes** | Machine name of the source field to pull. |
| `target_paragraph_uuid` | textfield (maxlength 36) | no | Optional paragraph id or UUID on the source; when set, that paragraph is the target and `field_to_fetch` is ignored. |

Config schema for these lives in `config/schema/entity_field_fetch.schema.yml` under
`field.field_settings.entity_field_fetch` (keys `target_type`, `target_uuid`, `target_field` —
note the schema key names predate the current setting names above but validate the stored mapping).

## Widget — `EntityFieldFetchWidget`

`src/Plugin/Field/FieldWidget/EntityFieldFetchWidget.php`, `@FieldWidget(id =
"entity_field_fetch_widget")`. On the edit form (`formElement()`) it loads the configured source
and renders a **preview** of the target field (`$entity->$field_to_fetch->view('full')`) or, when a
paragraph id/UUID is configured, the paragraph via the paragraph view builder. If the field is not
yet configured it shows `[ No preview exists yet as the field is not configured. ]`. The stored
`value` element is a disabled hidden `0` (schema parity only).

### Widget settings (`defaultSettings()` / `settingsForm()`)

| Setting | Default | Effect |
|---|---|---|
| `show_field_label` | TRUE | Show/hide the form field label (`#title_display` before/invisible). |
| `show_link_to_source` | FALSE | Append a `<div class="data-source data-link">` link to the source entity's canonical URL. |
| `show_source_updated_date` | FALSE | Append the source's `getChangedTime()` formatted `short`. |

With both link + date on, a single "Updated: …" link is emitted. Schema:
`field.widget.settings.entity_field_fetch` (three `checkbox` keys). A cache clear is required after
changing widget settings.

## Formatter — `EntityFieldFetchFormatter`

`src/Plugin/Field/FieldFormatter/EntityFieldFetchFormatter.php`, `@FieldFormatter(id =
"entity_field_fetch", field_types = {"entity_field_fetch"})`, injects `entity_type.manager`,
`entity.repository`, `entity_field_fetch.fetcher`.

- **`viewElement()`** reads the field settings, loads the source via
  `entityTypeManager->getStorage($target_entity_type)->load($target_entity_id)`. If the type/id are
  missing or the entity can't load, it renders a `#markup` diagnostic (e.g. "The field … could not
  load a … with an id of …").
- With a `target_paragraph_uuid`: loads the paragraph (by UUID via
  `entityRepository->loadEntityByUuid('paragraph', …)` for backward compat, else
  `getCanonical('paragraph', …)`) and renders it with the paragraph **view builder** in the current
  view mode; otherwise renders `$entity->$target_fieldname->view($this->viewMode)`.
- Sets `#cache` from the Fetcher (`getCacheContexts()`, `getCacheKeys(['formatter'])`,
  `getCacheTags()`). If the source entity is unpublished it wraps output in
  `<div class="node--unpublished">`.
- `settingsSummary()` = "Displays the fetched field/paragraph." (no formatter settings).

## Install / update

`entity_field_fetch.install` — `entity_field_fetch_update_8001()` calls
`_entity_field_fetch_update_schema()` to migrate legacy storage: drops old `target_type` /
`target_field` / `target_uuid` columns from `{entity}__{field}` and `..._revision__{field}` tables,
adds the tiny-int `value` column, and re-saves each field storage/config so the field becomes fully
computed. No `config/install` defaults ship.

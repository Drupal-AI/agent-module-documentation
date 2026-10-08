# Resource overrides

The core feature. Each override is a `jsonapi_resource_config` config entity
(`jsonapi_extras.jsonapi_resource_config.*`). Manage them at
**Resource overrides** tab (`entity.jsonapi_resource_config.collection`): each JSON:API resource
lists an **Overwrite** operation (and **Revert** to return to defaults).

## What you can override
Per resource (`JsonapiResourceConfig`):
- `disabled` (bool) — remove the resource from the API entirely.
- `path` — the URL path for the resource (e.g. `articles`).
- `resourceType` — the public type name (rename `node--article` → `article`).
- `resourceFields[]` — one entry per field:

| Field key | Effect |
|---|---|
| `fieldName` | the internal Drupal field (e.g. `field_body`) |
| `publicName` | the name exposed in the API (e.g. `body`) |
| `disabled` | hide the field from responses |
| `enhancer.id` + `enhancer.settings` | transform the field value (see [../plugins/field-enhancer.md](../plugins/field-enhancer.md)) |

## Config example
```yaml
# jsonapi_extras.jsonapi_resource_config.node--article.yml
id: node--article
disabled: false
path: articles
resourceType: article
resourceFields:
  field_body:
    fieldName: field_body
    publicName: body
    disabled: false
  field_legacy:
    fieldName: field_legacy
    publicName: field_legacy
    disabled: true
```

- Overrides are decorated onto the JSON:API resource-type repository at runtime
  (`ConfigurableResourceTypeRepository`), so no data is copied — responses are reshaped live.
- Configs are exportable; deploy them like any config. The integrity validator
  ([settings.md](settings.md)) guards imports.
- With `default_disabled` on, only resources whose config has `disabled: false` are exposed.

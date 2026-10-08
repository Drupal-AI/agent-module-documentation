# Configure resource defaults

Defaults are stored as **third-party settings** on a JSON:API Extras resource config
(schema `jsonapi_extras.jsonapi_resource_config.*.third_party.jsonapi_defaults`). Edit them on
the resource's **Overwrite** form (Resource overrides tab) once this submodule is enabled — a
"JSON:API Defaults" fieldset appears.

| Setting | Meaning |
|---|---|
| `default_include` | Relationship paths auto-included when the request has no `?include=` (e.g. `uid`, `field_tags.vid`) |
| `default_filter` | Filter conditions applied when the request has no `?filter=` (e.g. `status = 1`) |
| `default_sorting` | Sort applied when the request has no `?sort=` |
| `page_limit` | Default `page[limit]` (records per page) |

Config example (third-party settings on the resource):
```yaml
third_party_settings:
  jsonapi_defaults:
    default_include:
      - uid
      - field_tags
    default_filter:
      filter_status: '1'
    default_sorting:
      - '-created'
    page_limit: 10
```

Behavior:
- A default applies **only when the client omits** the matching parameter; a client-provided
  `include`/`filter`/`sort`/`page[limit]` overrides the default.
- Implemented by overriding JSON:API's `EntityResource` controller
  (`jsonapi_defaults.services.yml`); a `QueryArgsCacheContext` ensures responses cache correctly
  per query arguments.
- Settings export with the resource config for deployment.

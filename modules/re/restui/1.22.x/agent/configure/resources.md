# Configure REST resources

![REST resources list (REST UI)](../../../../../../../screenshots/restui/1.22.x/resources.png)

REST UI adds no config of its own — it edits core's `rest.settings` /
`rest.resource_config.*` entities through a UI. Permission: `administer rest resources`.

## Resource list
`/admin/config/services/rest` (route `restui.list`, controller
`RestUIController::listResources`) lists every REST resource plugin discovered from core
and contrib. Each row shows enabled state with **Enable** / **Disable** / **Edit** actions.
Disable posts to `restui.disable` (CSRF-protected).

## Edit a resource
`/admin/config/services/rest/resource/{resource_id}/edit` (route `restui.edit`, form
`RestUIForm`). For the chosen resource you set, per HTTP **method** (GET/POST/PATCH/DELETE):
- **Accepted request formats** — the serialization formats enabled site-wide
  (`json`, `xml`, `hal_json`, …; the list comes from the container's serialization formats).
- **Authentication providers** — collected from `AuthenticationCollectorInterface`
  (`cookie`, `basic_auth`, and any contrib provider such as OAuth).

Saving writes a `rest.resource_config.{id}` config entity, e.g.:
```yaml
id: entity.node
plugin_id: 'entity:node'
granularity: method
configuration:
  GET:
    supported_formats: [json]
    supported_auth: [cookie, basic_auth]
  POST:
    supported_formats: [json]
    supported_auth: [basic_auth]
```

## Notes
- Enable core's **RESTful Web Services** (`rest`) and a serialization module first.
- Config is standard core config — export/deploy with `drush config:export` / `config:import`.
- REST UI itself defines no permissions, plugins, or schema; it is a management UI only.

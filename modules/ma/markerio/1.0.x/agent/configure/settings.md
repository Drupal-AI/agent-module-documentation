# Configure Marker.io

## Settings form

Route `markerio.settings` → `/admin/config/system/markerio` (permission
`administer markerio configuration`). Fields (`SettingsForm`), stored in config
`markerio.settings` (schema `markerio.schema.yml`):

- `project` (textfield) — your **Marker.io project key**. Required for the widget to load.
- `nid` (checkbox, "Track node ID where possible") — when on, the current node's id is passed to
  the widget on node routes.

Set via Drush/config too:
```
drush config:set markerio.settings project <PROJECT_KEY>
drush config:set markerio.settings nid 1
```

## Permissions (`markerio.permissions.yml`)

- `administer markerio configuration` — access the settings form.
- `access markerio` — actually see/use the widget. Grant to the roles (e.g. staff, QA, or
  anonymous) that should be able to report feedback. Without it, nothing is attached for that user.

## How the widget is attached

- `markerio_page_bottom()` adds `$page_bottom['markerio']` as a `#lazy_builder`
  (`markerio.lazy_builder:build`) with `#create_placeholder = TRUE`, so it renders per-user
  without breaking page cache. `markerio_page_attachments()` adds the
  `config:markerio.settings` cache tag.
- `LazyBuilder::build()` returns an empty render array (only cache metadata) unless
  `current_user` has `access markerio` **and** a project key exists. Otherwise it attaches the
  `markerio/markerio` library and:

```js
drupalSettings.markerio = {
  project:    "<project key>",
  user_email: <authenticated user's email | false>,
  user_name:  <authenticated user's display name | false>,
  nid:        <node id | false>   // only when `nid` setting is on and route has a node
}
```

Cache contexts `user`, `route`; tags `config:markerio.settings`, plus `user:<id>` and
`node:<id>` when applicable. All widget UI, screenshot capture and issue delivery happen in the
Marker.io SaaS using the project key.

# datalayer — agent start

Pushes Drupal page/entity/user metadata into the JS `window.dataLayer` array (for GTM &
analytics). One inline `<script>` per non-admin page, built in a `#lazy_builder`
(cache context `user`). Everything is driven by the `datalayer.settings` config object.
Config UI: **Admin → Config → Search and metadata → Data Layer**
(`/admin/config/search/datalayer`, route `datalayer.settings_form`, permission
`administer site configuration`). No permissions/plugins/drush of its own.

- Settings keys, defaults, output options, key renaming, exposing a field → [configure/settings.md](configure/settings.md)
- Add/read data in code (`datalayer_add`, `datalayer_get_data_from_page`) → [api/api.md](api/api.md)
- Alter or extend the payload via hooks → [hooks/hooks.md](hooks/hooks.md)

# realname — agent start

Replaces a user's displayed name with a name built from a **Token** pattern over `user`
fields. One site-wide pattern in `realname.settings:pattern`; generated names cached in the
`{realname}` DB table. Depends on `token`. Config UI: **Admin → Config → People → Real name**
(`/admin/config/people/realname`, configure route `realname.admin_settings_form`,
permission `administer realname`).

- Set / read the name pattern, rebuild cached names, bulk action → [configure/settings.md](configure/settings.md)
- Generate names in code + alter hooks (`hook_realname_pattern_alter`, `hook_realname_alter`, `hook_realname_update`) → [api/api.md](api/api.md)

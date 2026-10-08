# override_node_options — agent start

Splits the node form's Authoring info + Publishing options into per-permission controls, so
non-admins can set published/promote/sticky/author/date/revision without `administer nodes`.
Pure access layer (field- & form-access alters) — depends only on core `node`. Config UI:
**Admin → Config → Content authoring → Override Node Options** (route
`override_node_options.settings`).

- Toggle general vs per-content-type permissions → [configure/settings.md](configure/settings.md)
- The permissions and what each reveals → [permissions/permissions.md](permissions/permissions.md)

# restui — agent start

UI to enable/configure core REST resources (methods, formats, auth). Writes core
`rest.settings`. Depends on core `rest`. Config UI: **Admin → Config → Web Services → REST**
(`/admin/config/services/rest`, route `restui.list`). Gated by core permission
`administer rest resources`.

- Enable/disable resources, set methods, formats & auth → [configure/resources.md](configure/resources.md)

# smart_date — agent start

Provides a `smartdate` field type (start/end/duration) with app-like widget and compact
display. Depends on core `datetime` + `options`. Reusable **Smart date formats** live at
**Admin → Config → Regional and language → Smart date formats**
(`/admin/config/regional/smart-date`, route `entity.smart_date_format.collection`).
Submodule: `smart_date_recur` (recurring events).

- Field type / widgets / formatters + smart_date_format config → [configure/formats.md](configure/formats.md)
- Format a value in code (`formatSmartDate`, service) → [api/format.md](api/format.md)
- Drush: migrate legacy date fields → [drush/commands.md](drush/commands.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

Submodule docs: **smart_date_recur** → `modules/smart_date_recur/4.2.x/`.

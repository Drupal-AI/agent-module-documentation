# checklistapi — agent start

An API for defining fillable, persistent checklists. A module implements
`hook_checklistapi_checklist_info()` to declare checklists; Checklist API auto-generates a
route and a pair of permissions per checklist, renders grouped items as vertical tabs, and
saves progress (who checked each item, and when) to config or state. No config settings form —
just a **Checklists** report at `/admin/reports/checklistapi` (route `checklistapi.report`).
Core-only deps. Bundled `checklistapiexample` is a working reference.

- Define / alter a checklist and its items → [hooks/checklistapi.md](hooks/checklistapi.md)
- Load a checklist, read progress, storage backends → [api/checklistapi.md](api/checklistapi.md)
- Universal + auto-generated per-checklist permissions → [permissions/checklistapi.md](permissions/checklistapi.md)
- Report page, storage choice, generated routes → [configure/checklistapi.md](configure/checklistapi.md)
- Drush commands (`checklistapi:list`, `checklistapi:info`) → [drush/checklistapi.md](drush/checklistapi.md)

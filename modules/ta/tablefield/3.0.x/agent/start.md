# tablefield — agent start

Defines a `tablefield` field type storing a grid of text cells (rows × columns) plus a
caption and text format, with a table widget (grid inputs + rebuild/add-row/paste/CSV
import) and a "Tabular View" formatter (row/column headers + CSV export). Standard Field
API field, so revisionable, multi-value, and Views-integrable. Depends on core `field`.
Module settings UI: **Admin → Config → Content authoring → Tablefield**
(`/admin/config/content/tablefield`, route `tablefield.admin`).

- Add a Table field, set default rows/cols, CSV separator; widget & formatter options; CSV/paste import & export → [configure/tablefield.md](configure/tablefield.md)
- Permissions gating export / rebuild / import / paste / add-row / config → [permissions/tablefield.md](permissions/tablefield.md)
- Field type plugin ids, render element, and the encodings hook for CSV import → [api/tablefield.md](api/tablefield.md)

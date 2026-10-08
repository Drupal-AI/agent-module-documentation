# webform_views — agent start

Exposes webform **submissions** and their per-element values to Views: field, filter, sort,
and relationship handlers so you can build custom submission listings/reports. Depends on
`views` + `webform` (6.2+). No config UI or permissions of its own — everything is done in
the Views UI. Config schema present for the Views plugins.

- Build a view of webform submissions (base table, relationships, element columns, tabs) → [configure/build-view.md](configure/build-view.md)
- The element→Views-handler system + hook to override it → [extend/element-handlers.md](extend/element-handlers.md)

Bundled `webform_views_example` submodule (sample form + view) is a demo — not separately
documented.

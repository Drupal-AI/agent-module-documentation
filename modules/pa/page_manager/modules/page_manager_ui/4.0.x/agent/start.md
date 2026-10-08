# page_manager_ui — agent start

Admin wizard for **page_manager** (engine has no UI of its own). Mounts the Pages screens at
**Structure → Pages** (`/admin/structure/page_manager`, route `entity.page.collection`).
Depends on `page_manager`; reuses its `administer pages` permission (defines none of its own).

- The wizard: routes, steps, tempstore staging → [configure/wizard.md](configure/wizard.md)

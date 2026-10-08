# layout_builder_modal — agent start

Opens Layout Builder block add/configure forms in a centered modal dialog instead of the
off-canvas tray. Requires core `layout_builder` + `system`. Settings UI: **Admin → Config →
User interface → Layout Builder Modal** (`/admin/config/user-interface/layout-builder-modal`,
route `layout_builder_modal.config`). No per-block config — enabling it changes the UX
globally (via `AjaxResponseSubscriber`).

- Modal width/height/autoresize/theme settings → [configure/settings.md](configure/settings.md)

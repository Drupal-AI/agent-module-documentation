# Modal (modal_page) — agent index

Create configurable dialog/pop-up windows (announcements, notifications, cookie notices,
lightboxes, custom content) targeted by page path, role and language — no code required.
Depends on core `filter` + `datetime`.

- **Modals as config entities, all the entity keys, the global settings object, admin routes** →
  [configure/modals-and-settings.md](configure/modals-and-settings.md)
- **The `administer modal page` permission and what it gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **Drush `modal_page:cron` (the scheduler)** → [drush/commands.md](drush/commands.md)
- **Hooks: `hook_modal_alter`, `hook_modal_ID_alter`, `hook_modal_submit`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts (grounded in `src/Entity/Modal.php`, `*.routing.yml`, config):
- Modal entity type id **`modal`**, config prefix `modal` → config **`modal_page.modal.<id>`**.
  Admin list at `/admin/structure/modal` (`entity.modal.collection`); add form
  `entity.modal.add_form`.
- Global settings: config object **`modal_page.settings`**, form route **`modal_page.settings`**
  (the `configure` route) at `/admin/config/user-interface/modal-page/settings`.
- One permission: **`administer modal page`** (restrict access) — gates every route.
- Drush: **`modal_page:cron`** (alias `modal-page-cron`) runs `ModalPageScheduler`.
- Services: `modal_page.modals` (`ModalPageService`), `modal_page.helper`,
  `modal_page.validators`, `modal_page.scheduler`.

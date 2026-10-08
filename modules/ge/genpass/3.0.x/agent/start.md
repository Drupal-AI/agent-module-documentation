# genpass — agent start

Generates strong passwords for new users and makes the password field optional/hidden on
the admin "Add user" and registration forms. Decorates core's `password_generator` service.
Requires only core `user`. Config lives in **`genpass.settings`** and is edited on the core
Account settings form: **Admin → Config → People → Account settings**
(`/admin/config/people/accounts`, configure route `entity.user.admin_form` — genpass has no
route of its own, it alters `form_user_admin_settings`).

- Settings keys, the admin form, and drush config → [configure/settings.md](configure/settings.md)
- Generate passwords in code, the service decoration, the bulk action, and the alter hooks → [api/password-generator.md](api/password-generator.md)
- Submodule `genpass_batch` (test-support, batch on user insert) → [../../modules/genpass_batch/3.0.x/agent/start.md](../../modules/genpass_batch/3.0.x/agent/start.md)

No permissions, no Drush commands, and no plugin *types* of its own (it provides one Action
plugin and one Validation constraint — see the api doc).

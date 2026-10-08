# view_password — agent start

Adds a client-side "show/hide password" eye toggle button next to password fields on the
forms you select. A `hook_form_alter()` matches configured form IDs, adds the `pwd-see`
class, and attaches `password.js`, which inserts a `<button class="shwpd">` that flips the
input between `password` and `text`. No dependencies outside Drupal core. Config UI:
**Admin → Config → System → View Password Settings** (`/admin/config/system/view-password-settings`);
settings route `password.route`; config object `view_password.settings`.

- Choose which forms get the toggle + custom icons/classes → [configure/view_password.md](configure/view_password.md)
- The `administer view password` permission → [permissions/view_password.md](permissions/view_password.md)
- The JS toggle, CSS classes, icon SVGs and libraries → [theming/view_password.md](theming/view_password.md)

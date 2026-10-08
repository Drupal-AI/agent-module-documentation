Registration Link adds a "Register" menu link to Drupal's user account menu, visible only to anonymous visitors (when registration is open) and to administrators.

---

The module is tiny: it declares a menu link (`registration_link.user_register`) in the `account` menu
pointing at a `/user/register` route it re-declares, and ships a custom access checker
(`RegistrationLinkAccessCheck`, service tagged `access_check` / `_registration_link_custom_access`).
The route requires role `administrator+anonymous` plus the custom check. The access checker allows the
administrator role unconditionally, and otherwise allows the request only if the account is anonymous
**and** core's `user.settings:register` is not `REGISTER_ADMINISTRATORS_ONLY` — i.e. it honours the
site's existing "Who can register accounts" setting and adds a cacheable dependency on that config.
The result is a Register link that appears in the user menu for logged-out visitors (so it sits next to
the default Log in / My account links), disappears once registration is admin-only, and is also shown to
admins for convenience. Like any menu link it can be moved to another menu, re-ordered, or disabled from
*Structure → Menus*. There is no settings form (`configure` null), no permissions of its own, no config
schema, and no Drush commands. Requires only Drupal core.

---

- Add a "Register" link to the user account menu that core omits by default.
- Show the registration link only to anonymous visitors, not to already-logged-in users.
- Automatically hide the link when the site sets registration to "Administrators only".
- Give administrators a quick link to the registration form.
- Place the registration link in the header/account menu next to Log in and My account.
- Move the registration link into any other menu (main, footer, etc.) via Manage links.
- Re-order or rename the registration menu link like any standard menu item.
- Provide a discoverable signup entry point for membership or community sites.
- Keep the registration link's visibility in sync with core's account-settings register mode.
- Avoid writing a custom `hook_menu_links`/menu YAML just to expose `/user/register`.
- Improve conversion by surfacing account creation without a custom block.
- Offer a consistent register CTA across all themes using the account menu.
- Disable the link temporarily by disabling the menu link, without uninstalling the module.
- Benefit from cache correctness: the link's access is cache-tagged to `user.settings`.
- Use on multilingual sites where the menu link title is translatable via menu UI.
- Complement Terms of Use or other registration-gating modules with a visible entry link.
- Lightweight, zero-config way to add a signup link on install.

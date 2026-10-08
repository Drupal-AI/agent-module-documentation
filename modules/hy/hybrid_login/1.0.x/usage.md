<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hybrid Login provides a customizable block for the user login page and a set of form/route alters that let a site present an external login service (typically SAML) alongside — or instead of — the default Drupal login form.

---

Despite the name, the module does **not** authenticate anyone: it contains no credential handling and never calls `user_login_finalize()`. Its `HybridLoginBlock` renders a themed panel (title, description, logo, button text) whose button links to a configurable relative path such as `/saml/login`, and its `hook_form_user_login_form_alter()` optionally hides the Drupal username/password fields, the create-account link and the password-reset link. A `RouteSubscriber` additionally sets `_access: 'FALSE'` on core's `user.pass` and `user.register` routes when the corresponding options are disabled, so those flows can be closed off when only external login should be used. All of this is driven by the `hybrid_login.settings` config edited at `/admin/config/people/hybrid_login`.

Operationally it is admin-configured presentation only. The settings form route is properly gated behind `administer site configuration`, the uploaded logo is a standard `managed_file` marked permanent on save, and there are no anonymous or mutating endpoints. Because the module only shows/hides UI and denies access to core routes, it cannot itself be an authentication-bypass vector — the actual login security lives entirely in whatever external auth module (e.g. SAML Auth) the button points at. The typical setup is: enable the module, place the "Hybrid Login" block on `/user/login`, then configure the button path and which core login elements to hide.

---

- Place a customizable login block on the `/user/login` page
- Show a Drupal login and an external (SAML) login side by side
- Hide the default Drupal username/password fields entirely
- Point the login button at an external auth path such as `/saml/login`
- Set a custom login-page title and description
- Upload a logo for the external login service
- Customise the login button text
- Hide the create-account link on the login page
- Hide the password-reset link on the login page
- Deny access to `/user/register` when self-registration is disabled
- Deny access to `/user/password` when password reset is disabled
- Add instructions to the password-reset page
- Show login instructions or announcements in the block
- Restrict configuration to holders of `administer site configuration`
- Disable the block from the Block layout page when not needed
- Pair with the SAML Auth module (or similar) which performs the actual login
- Understand that this module only themes the login page and never authenticates users

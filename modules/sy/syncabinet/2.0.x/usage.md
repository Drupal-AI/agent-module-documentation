<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Syncabinet is the SynapseF customer "cabinet" layer for a syncart Commerce store: it themes the login/register/password/profile forms and adds logout, confirmation and repeat-order conveniences.

---

Syncabinet is a **vendor-specific (SynapseF) customer-cabinet module**, part of the `syncart` Commerce suite
(it declares a hard dependency on `syncart:syncart`). It does not add new entities, permissions, Drush commands
or configuration forms. Instead it *re-skins and wires up the account area* of a storefront: it alters the core
`user_login_form`, `user_register_form`, `user_pass` and `user_form` forms (adding Russian-language headings,
a "forgot password" link, a registration link and `cabinet-form` styling), ships Twig overrides and a
`syncabinet/base` CSS library, and optionally renders VK (`social_auth_vk`) and Facebook
(`social_auth_facebook`) login buttons when those modules are configured.

It also provides two routes: `/user/submit_result` renders a static registration/password-reset confirmation
page (its text is chosen from the HTTP `referer` route — `user.register` vs `user.pass`), and
`/user/{user}/logout` logs the current session out and redirects to the front page (exposed as a "Logout" tab on
the user canonical route). On install it flips `user.settings.register` to `visitors` and enables
`syncart.settings.registration`, i.e. it turns on open self-registration for the store.

Because it handles **authentication and account flows** and is vendor-specific with minimal public
documentation, review its actual login/registration/session behaviour in context before relying on it. Consult
the vendor's (syncart/SynapseF) documentation for configuration. This new 2.0.x major targets Drupal 11/12 only
and uses attribute-based (`#[Hook]`) class hooks.

---

- Provide a themed customer "cabinet" (личный кабинет) for a syncart store.
- Restyle the core login form (heading, actions group, `cabinet-form` class).
- Restyle the register form and add a post-submit confirmation redirect.
- Restyle the password-reset (`user_pass`) form with helper text.
- Restyle the user edit (`user_form`) profile form and redirect to `user.page` after save.
- Add a "Забыли пароль?" (forgot password) link to the login form.
- Add a "Регистрация" (register) link next to the login actions.
- Render optional VK social-login button when `social_auth_vk` is configured.
- Render optional Facebook social-login button when `social_auth_facebook` is configured.
- Ship a `syncabinet/base` CSS library attached on `page__service`.
- Provide Twig overrides for the login and register form templates.
- Add a "Logout" task tab on the user canonical route.
- Log the current user out via `/user/{user}/logout` and redirect to front.
- Show a registration confirmation page after sign-up.
- Show a password-reset instruction page after requesting a reset.
- Flag Commerce orders with `repeat_order` so the order template can offer re-ordering.
- Enable open self-registration (`user.settings.register = visitors`) on install.
- Enable `syncart.settings.registration` on install.
- Suppress status messages (messenger deleteAll) on profile/registration submit.
- Clean AJAX query args off the login form action to avoid malformed actions.
- Belong to and depend on the syncart Commerce suite.
- Serve a vendor (SynapseF) storefront stack, not general-purpose access control.
- Target Drupal 11 and 12 with attribute-based hooks.

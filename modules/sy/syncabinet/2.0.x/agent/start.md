<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncabinet — agent index

A **vendor-specific (SynapseF) customer-cabinet module** for the `syncart` Commerce suite. Hard dependency on
`syncart:syncart`. Release **2.0.5**, version dir **2.0.x** (new major). Core `^11 || ^12`. Package `SynapseF`.
GPL-2.0-or-later. No composer.json, no config schema, no permissions, no Drush, no plugin types.

## What it does

It does not define entities or settings forms; it decorates the storefront account area:

- **Form alters** (`src/Hook/FormAlter.php`, attribute `#[Hook('form_alter')]`): adds Russian headings,
  `cabinet-form`/`contact-message-form` classes, a forgot-password link and a register link; sets a clean
  `#action` on the login form (stripping AJAX query args); appends submit handlers that clear messages and
  redirect — `user_form` → `user.page`, `user_register_form` → `syncabinet.submit_result`.
- **Theme + templates** (`src/Hook/ThemeHooks.php`, `templates/form--user-{login,register}-form.html.twig`):
  overrides the login/register form templates; they render VK (`/user/login/vkontakte`) and Facebook
  (`/user/login/facebook`) buttons only when `uid == 0` and `social_auth_vk` / `social_auth_facebook` config
  provides a `client_id` / `app_id` (`src/Hook/PreprocessFormUserLoginForm.php`).
- **CSS** (`syncabinet.libraries.yml` → `syncabinet/base`, attached on `page__service`).
- **Commerce** (`src/Hook/PreprocessCommerceOrder.php`): sets `repeat_order = TRUE` on the order template.
- **Install** (`syncabinet.install`): sets `user.settings.register = visitors` and
  `syncart.settings.registration = TRUE` — i.e. enables open self-registration.

## Routes (`syncabinet.routing.yml`)

- `syncabinet.submit_result` — `/user/submit_result`, `_permission: access content`
  (`SubmitPageController::page`): static confirmation markup chosen from the `referer` route
  (`user.register` vs `user.pass`); no user input is reflected.
- `syncabinet.logout` — `/user/{user}/logout`, `_permission: access content`
  (`LogoutController::logout`): logs out the current session (the `{user}` slug is ignored) and redirects to
  `<front>`. Exposed as a "Logout" tab (`syncabinet.links.task.yml`).

## Agent notes

Auth/profile, vendor-specific and lightly documented: **review actual login/registration/session behaviour in
context** before relying on it. Note the install hook silently opens public registration. The module is scoped
to a syncart/SynapseF storefront and provides no general-purpose access-control contract. Documented from
on-disk source; not test-enabled this wave (syncart/Commerce config dependencies absent).

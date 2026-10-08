<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External reset password redirects the Drupal password-reset request page to an administrator-configured external URL.

---

External reset password is a very small module for sites whose password management lives outside Drupal. It adds one setting — an external URL — and a kernel-request event subscriber that watches for the core "Request new password" route (`user.pass`, at `/user/password`). When that route is requested and a URL has been configured, the subscriber redirects the visitor to the external destination instead of showing Drupal's built-in reset form, so users are sent to an identity provider, SSO portal, or custom reset page. The settings live at Configuration → People → External Reset Password (`/admin/config/people/external-reset-password/settings`), guarded by the core "administer site configuration" permission, and are stored as the single `url` key of the `external_reset_password.settings` config object. With no URL configured the module does nothing and Drupal's normal reset form is shown. The module depends only on core's User module and supports Drupal 8.8 through 11.

---

- Send users to an external identity provider when they request a password reset.
- Point the password-reset request page at an SSO or single sign-on portal.
- Redirect password recovery to a custom, off-Drupal reset page.
- Replace Drupal's built-in "Request new password" form with an external flow.
- Centralise password management in an external system for a Drupal site.
- Configure the external reset URL from Configuration → People → External Reset Password.
- Store the reset destination as one config value (`external_reset_password.settings:url`).
- Leave Drupal's default reset form in place simply by clearing the URL.
- Support sites where user credentials are owned by an external service.
- Direct visitors to a corporate login/reset portal on password recovery.
- Integrate a headless or decoupled auth backend's reset page into a Drupal site.
- Route resets to a hosted authentication provider's reset workflow.
- Restrict who can change the external URL to site-configuration administrators.
- Manage the reset destination entirely through configuration (exportable via config sync).
- Apply the same external reset target consistently across environments via config.
- Guide users to a branded external password-recovery experience.
- Avoid maintaining a local reset form when auth is handled elsewhere.
- Set up the redirect on Drupal 8.8, 9, 10, or 11 with only the core User module.
- Enable the module and configure it without adding any third-party libraries.
- Clear the cache after saving so the configured redirect takes effect.

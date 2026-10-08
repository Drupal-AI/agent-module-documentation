<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Modal allows social authentication in a modal window.

---

Social Auth Modal **lets social authentication happen inside a modal window** — so a user can log in with a
Social Auth provider via a pop-up modal rather than a full-page redirect, for a smoother UX. It depends on the
Social Auth module, in the Social package.

Use it to offer modal social login. It is an authentication-UX wrapper: the **actual OAuth flow — provider
redirect, the `state` CSRF check, and token exchange — is still handled by the Social Auth framework/provider**;
this module only changes the presentation (modal vs full page) and completes the flow through Social Auth. So its
security rests on the underlying Social Auth provider being configured correctly (credentials as secrets, HTTPS).
It has no access-control role of its own beyond authentication. Configure it with a Social Auth provider.

---

- Do social login in a modal.
- Avoid a full-page redirect.
- Smooth the login UX.
- Depend on the Social Auth module.
- Serve authentication UX.
- Wrap Social Auth.
- Let Social Auth handle the OAuth flow + state check.
- Only change the presentation (modal).
- Rest security on the underlying provider config.
- Have no access-control role of its own.
- Configure it with a Social Auth provider.
- Handle modal social login.
- Log users in.
- Configure the modal.
- Authenticate in a modal.
- Handle the integration.
- Show the login modal.
- Wrap social auth.
- Secure the provider.
- Provide modal social login.

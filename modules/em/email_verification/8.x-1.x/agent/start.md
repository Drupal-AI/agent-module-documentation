<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Verification — agent orientation

Gates `user_register_form` behind an email-ownership hash link.

- Version 8.x-1.x, core ^8||^9||^10.
- Routes: `/user/emailverify` (anon form), `/admin/config/people/userverify` (settings, `administer users`).
- Token = `md5($salt . $email)`; salt = config `user_email_verification_salt`.
- Logic all in `email_verification.module` (`hook_form_alter`, `hook_mail`).

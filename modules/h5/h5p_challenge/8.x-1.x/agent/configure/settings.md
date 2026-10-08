<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# H5P Challenge — configuration

Route `h5p_challenge.h5p_challenge_config_form` → `/admin/config/system/h5p_challenge`, permission **access administration pages** (`_admin_route`). Form `H5PChallengeConfigForm`, config `h5p_challenge.config`.

Configure: reCAPTCHA site/secret keys (challenge creation is verified server-side against `https://www.google.com/recaptcha/api/siteverify`), challenge durations, and notification/email options. Ensure **cron runs hourly** — cron sends the "challenge ended" notice and performs clean-up.

Optional attachment emails: install `mailsystem` + `mimemail`, set the H5P Challenge mail formatter to *Mime Mail Mailer* (plain text), optionally target the `challenge_ended` mail key.

Reports list of all challenges: `/admin/reports/h5p_challenge` (same permission).

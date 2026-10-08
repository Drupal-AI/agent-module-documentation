<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MTCaptcha — agent index

Integrates the **MTCaptcha** service (privacy-focused CAPTCHA) into Drupal forms for spam/bot
protection — login, registration, password reset, contact, comment, etc. Version **11.0.0**. Core
`^9||^10||^11`. **Requires PHP 8.3.**

Configure site key (public) + private key (server-side verification — store as a secret) at
`mtcaptcha.settings`; pick which forms get challenged. Loads its widget via JS libraries. Provides
admin/exempt permissions.

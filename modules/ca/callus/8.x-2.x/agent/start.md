<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# callus — agent orientation

- Floating "Call Us" phone button + optional social links, injected site-wide via CSS/JS libraries.
- Single admin route `/admin/config/user-interface/call-us` (`callus.form`, `administer site configuration`); config object `callus.settings`.
- No callbacks, webhooks, anonymous routes, or external API calls despite the "callback" concern — purely a config form + rendered button.
- Form validation: phone must be numeric and >=10 chars. Sound; no security surface.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynAjax — agent index

**AJAX-only submission** for contact forms (require JS to submit — blocks bots that POST directly). Config at
`synajax.config`. Version **8.x-1.5**. Core `^8||^9||^10||^11`.

Anti-spam control (one layer). **Caveats:** stops naive bots, not headless/determined; requires JS
(accessibility/no-JS impact) — pair with CAPTCHA/honeypot/flood control. No access role.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# yunke captcha — agent index

Self-hosted **multi-type CAPTCHA** (GD image/text) as `yunke_captcha` **config entities**. Admin CRUD/enable/disable behind `yunke_captcha settings` (+ entity-access + CSRF). Public `/yunke_captcha/...` refresh + image routes use `access content` (anon must fetch the challenge) — render session-bound CAPTCHA, not files. `yunke_captcha exemption` bypasses. Config `yunke_captcha.admin`. Version **8.x-2.4**, core `^9||^10`. Functional module (not a dev tool).
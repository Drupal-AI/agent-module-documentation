<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yandex SmartCaptcha — agent index

Server-verified **Yandex SmartCaptcha** for forms. Verify calls Yandex API over HTTPS (Guzzle) with secret + client IP; **fail-closed** (FALSE on non-200 or status!=ok). Keys from config or env (`YA_CAPTCHA_*`). Own perm `administer yandex_smartcaptcha configuration`; config `yandex_smartcaptcha.settings_form`. Version **1.0.4**, core `^9||^10`. Security-reviewed: sound.
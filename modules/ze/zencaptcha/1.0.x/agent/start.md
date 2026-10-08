<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ZENCAPTCHA — agent index

CAPTCHA type (via `captcha` module) backed by the **Zencaptcha** service; posts solution+secret to `zencaptcha.com/.../siteverify` over HTTPS, optional email validation. Own perm `administer zencaptcha`; config `zencaptcha.admin_settings_form`. Dep `captcha`. Version **1.0.0**, core `^9||^10`. SECURITY: verify **fails open** on empty body / non-200 → CAPTCHA bypass when verify endpoint is unreachable.
<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HeCAPTe CAPTCHA — agent index

**Proof-of-work CAPTCHA challenge** for the CAPTCHA module (external HeCAPTe server). Depends on `captcha`. Version
**1.0.1**. Core `^10||^11||^12`.

Spam-control — **positive**: the solution is **verified server-side** (Drupal calls the HeCAPTe `/verify`, requires
status `ok`; the client can't self-assert). Depends on the external server (egress); ensure it **fails closed** on
verify errors, sensible timeout, HTTPS. No access role.

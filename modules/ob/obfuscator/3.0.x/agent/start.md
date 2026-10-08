<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Obfuscator — agent index

Hardening: removes **Drupal version from HTML + HTTP headers**, strips **asset version strings**, and
(via .htaccess) disables **TRACE/TRACK** — reduces fingerprinting. Config at `obfuscator.admin_settings`.
Version **3.0.0**. Core `^11`.

**Framing: security-through-obscurity — a marginal defense, NOT real protection.** Fixes no
vulnerability; keeping Drupal/modules **patched** remains the essential control. A minor add-on only.

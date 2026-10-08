<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# System Status (system_status) — agent index

Token-guarded **JSON endpoint reporting installed modules/themes/versions** for external monitoring
(`/admin/reports/system_status/{token}`), plus a settings page. Version **dev**.
Core `^10.3 || ^11 || ^12`.

Payload is encrypted for the monitoring client when openssl is available. Settings route requires
`administer site configuration`.
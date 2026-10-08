<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monitoring Endpoint — agent index

JSON status endpoint (`/monitoring/status`) for external monitors — returns **Monitoring sensor + cron
status**, gated by `?token=` matched to `endpoint_key`. Requires PHP 8.1; depends on `monitoring`. Version
**1.0.1**. Core (per project).

Set `endpoint_key` (settings form or `settings.php`) after enabling; a wrong/missing token returns 403.
Serve over HTTPS and treat the token as a secret.

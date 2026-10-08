<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance Mode Redirect — agent index

Redirects visitors to a **configured URL during maintenance mode** (vs the default page), with
allowed-path exceptions. Request subscriber + `TrustedRedirectResponse`; target from config
(`system.site_maintenance_mode`). Version **3.0.1**. Core `^10||^11`.

Redirect destination is **admin-configured** (not user input) — **not** an open redirect. Keep admin/
login paths allowed so you can disable maintenance.

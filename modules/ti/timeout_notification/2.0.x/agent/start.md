<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Timeout Notification — agent index

Warns authenticated users **before session expiry** and lets them **refresh** the session. Version **2.0.0**. Core `^8.8 || ^9 || ^10`.

Settings at `/admin/config/timeout_notification`, gated by permission string `configure_timeout_notification_settings` (verify it is defined/granted to the admin role). JS/CSS library renders the countdown/notification. No public write routes.

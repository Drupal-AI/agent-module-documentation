<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirm Logout — agent index

Adds a **confirmation step before user logout** with a configurable, token-enabled message. Version **1.0.x**.
Core `^9 || ^10`. Depends on `token`. Provides its own permissions.yml.

Config form at `/admin/config/people/confirm-logout` (`administer confirm_logout configuration`). Confirm routes
`/confirm/logout` and `/confirm-logout` are gated by `_user_is_logged_in: TRUE`. Session/UX feature only — no
callbacks, no external I/O; logout itself still goes through core. Low security surface.

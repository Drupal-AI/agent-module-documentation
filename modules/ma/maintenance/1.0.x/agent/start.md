<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance — agent index

Provides **advanced maintenance-mode options** beyond core's (scheduling / richer pages / granular access).
Requires PHP 7.4. Version **1.0.0-beta1**. Core `^9.5||^10||^11`.

Admin — governs maintenance mode. **Note:** it controls **who can access the site during maintenance** —
limit the bypass to the right roles (core's "access site in maintenance mode"), don't leave a bypass open.
Relies on core's maintenance-access model. No other access role.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Deactivation Date — agent index

Blocks user accounts **automatically on a configured deactivation date via cron** (auto-expire temporary/
contractor accounts). Depends on core `datetime`, `user`. Version **1.0.0-alpha3**. Core `^10.1||^11`.

**Security/account-lifecycle-positive** (reduces stale-account risk). Depends on **cron running reliably**;
sets blocked status (setting the date follows user-edit access). No other access role.

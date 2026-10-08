<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login Notification — agent index

**Emails a user when their account logs in**, with a one-time "close all sessions" link (compromise-detection).
Version **1.0.5**. Core `^10.3||^11`.

**Security-positive**, safe (reviewed): alert to the account's **own email**; close-sessions link is an **HMAC
keyed with `hash_salt`**, verified with **`hash_equals()`**. Minor: sent synchronously (no cron); alert has **no
IP/time/location** (a login happened, but no context to judge it). No access role.

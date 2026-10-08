<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ULI Custom Workflow — agent index

Customizes **one-time-login (ULI) link messages** and **allows already-logged-in users to use the links**.
Overrides the `user.reset.login` controller. Requires PHP 8.x. Version **2.0.0**. Core `^10||^11`.

**Security-preserving:** calls `parent::resetPassLogin()` — **core's token validation (hash/timestamp/
expiry) is intact**; this only changes messaging + already-logged-in behaviour (UX/workflow change, not a
weakening).

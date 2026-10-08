<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Message — agent index

An **SMS API module for sending text messages** (used by notifications/OTP/alerts). Depends on core `telephone`.
Provides permissions. Version **1.0.8**. Core `^9||^10||^11||^12`.

Integration/messaging — gateway **credentials** as secrets (env/Key, HTTPS); SMS **costs money + is abusable**
(gate the permission, rate-limit); phone numbers are personal data. No access role beyond permission.

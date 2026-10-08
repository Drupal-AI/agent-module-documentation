<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notifier — agent index

Integrates the **Symfony Notifier component** to send notifications over multiple channels (SMS/chat/email/push).
Requires PHP 8.3. Version **3.0.0-alpha6**. Core `>=10.3`.

Integration/notifications — channels use **transport credentials** (provider API keys/DSNs — store as secrets,
secure DSNs); notifications carry user data. No access role.

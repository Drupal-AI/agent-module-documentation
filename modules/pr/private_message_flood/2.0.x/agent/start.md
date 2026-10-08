<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message Flood — agent index

Adds **role-based flood (rate-limit) protection to the Private Message module** (limit messages per time
window, configurable per role — curb spam). Depends on `private_message`, `duration_field`. Version
**2.0.0-alpha4**. Core `^9||^10||^11`.

**Security/anti-abuse-positive** — per-role flood limits on message sending. No access role of its own.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cryptolog — agent index

**Privacy:** replaces client **IP addresses with ephemeral, non-reversible identifiers** — raw IPs stay
out of logs (GDPR data minimization) while keeping short-term per-visitor correlation. Config at
`cryptolog.settings`. Version **2.2.3**. Core `^10||^11`.

Positive privacy control. **Trade-off:** features needing the true client IP (precise geolocation, IP
allow-lists, forensics) won't see it — configure rotation to match your needs.

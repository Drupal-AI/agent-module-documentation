<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Log — agent index

Logs **user role changes (grants/revokes) to watchdog** — an audit trail of privilege changes (who
gained/lost which role, when). Version **2.0.0**. Core `^9||^10||^11`.

Security/monitoring aid — only writes log entries (changes nothing). Pair with log review/SIEM
forwarding so the trail is watched. No config beyond enabling.

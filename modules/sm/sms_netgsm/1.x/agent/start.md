<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Netgsm (SMS Framework) — agent index

**Allows the SMS Framework to use Netgsm as a gateway**. Depends on `smsframework`. Provides permissions. Version
**1.x** (dev). Core `^9.4||^10||^11`.

SMS/integration — sends **content + recipient phone numbers (PII) to the Netgsm API** (egress — disclose);
**credentials** as secrets (env/Key, HTTPS). No access role beyond permission.

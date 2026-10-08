<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resend API — agent index

**Email sending via the Resend API**. Depends on `mailsystem`. Version **1.0.0-alpha1**. Core `^10||^11`.

Mail/integration — sends **content + recipient PII to the Resend API** (egress); **API key** as a secret (env/Key,
never commit, HTTPS). No access role.

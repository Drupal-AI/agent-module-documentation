<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayU Donations — agent index

**PayU donation block** with signature-verified notify. Version **1.3.0**. Core `^9.5||^10||^11`.

Payment confirmed via notify with **OpenPayU signature verification** (`hasValidSignature` — forged notifies rejected, positive); redirect handler is UX-only. Keys env-backed. Perms: `administer payu_donations configuration`/`payment`.
<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scaleflex DAM (Filerobot) — agent index

**Scaleflex Filerobot DAM integration**. Version **1.1.0**. Core `^10||^11`. Project `filerobot_by_scaleflex`.

**SECURITY (1.1.0):** `/api/filerobot-insert-image` (`administer media`) does `file_get_contents($data['url'])` on a caller URL with no validation → authenticated SSRF/LFI. Validate/allowlist the URL. Credentials env-backed.
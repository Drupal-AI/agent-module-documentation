<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FullStory Integration — agent index

Adds the **FullStory session-recording/analytics JS snippet** (captures clicks/scrolls/navigation + potentially
form input). Config at `fullstory.admin_settings_form`; provides permissions. Version **3.1.0**. Core
`^10||^11`.

**Privacy (key):** session recording can capture **sensitive input** — use FullStory field masking/
exclusions, disclose in the privacy policy, gate behind **cookie/consent** (GDPR/CCPA — third-party tracking).
No access role beyond permission.

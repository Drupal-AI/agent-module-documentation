<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prefer Latest Content (prefer_latest_content) — agent index
**Redirects permitted, non-admin, authenticated users from a published node to its latest draft revision.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Permission:** `prefer latest content` (Force latest if available)
- **Mechanism:** `hook_preprocess_html()` → 302 to `/node/{nid}/latest` when a newer `draft` revision exists (`Utils::getLatestRevisionOnlyIfDraft`)
- **No routes, no services.**

**Security:** No mutating endpoints; only a client-facing redirect gated by a dedicated permission. The target `entity.node.latest_version` route enforces its own core access. Note: hard-coded `en`/`fr` language assumption and tangled route-name conditionals in the `.module` — behavioural bug risk, not an access-control finding.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Invitation (webform_invitation) — agent index

Generates **random codes gating access to a specific webform** — only a valid (single-use) code
submits. Version **dev**. Core `^8 || ^9 || ^10 || ^11`. Depends on Webform.

**Security = the codes:** ensure enough entropy to resist guessing, single-use so a leaked code
can't be replayed, and distribute over a channel matched to what the form protects. A code gate
controls *who submits*, not form confidentiality.
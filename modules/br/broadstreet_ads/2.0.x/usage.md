<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Broadstreet Ads integrates the Broadstreet advertising platform, rendering configured ad zones as Drupal blocks via Broadstreet's `<broadstreet-zone>` web component and loader script.

Admins define ad zones on a settings form as `zoneid|Label` lines; each zone becomes a derivative block (`Plugin/Block/AdBlock` via `Plugin/Derivative/AdBlock`) that outputs `<broadstreet-zone zone-id="NNN">`. The loader library is attached on non-admin pages only when at least one zone is configured (`hook_page_attachments`). The zone id is cast to an integer before output.

Typical setup: enable the module (requires core Block), enter your Broadstreet zone ids and labels at Configuration → Services → Broadstreet Ads, then place the resulting per-zone ad blocks in regions.

---

Short summary: render Broadstreet ad zones as blocks using the platform's web-component loader.

It solves embedding Broadstreet ad units in a Drupal site without hand-coding markup: you register your zones once and get placeable blocks. It works with a config-backed zone list, a block deriver that turns each zone into a block, and a page-attachment that loads Broadstreet's script only where ads exist.

Operationally: configuration requires the custom *administer broadstreet ads* permission; the settings route is an admin route. The block output allows only the `<broadstreet-zone>` tag and integer zone ids. No server-side outbound requests are made by Drupal — ad loading happens client-side via Broadstreet's script.

---

- Enable the module (with core Block) to add Broadstreet ad blocks.
- Register ad zones as `zoneid|Label` lines on the settings form.
- Get one placeable block per configured zone (derivative blocks).
- Place a Broadstreet ad zone block in any theme region.
- Show ads via Broadstreet's `<broadstreet-zone>` web component.
- Load the Broadstreet script only on pages with zones configured.
- Keep ads off admin pages automatically.
- Restrict ad configuration to the *administer broadstreet ads* permission.
- Add or remove ad zones by editing the settings textarea.
- Label zones for easy identification when placing blocks.
- Integrate a Broadstreet publisher account with a Drupal site.
- Use block visibility conditions to target ads to specific pages.
- Cast zone ids to integers to avoid malformed markup.
- Manage multiple ad zones across different regions.
- Disable all ads by clearing the zone list.
- Combine Broadstreet ad blocks with other block-layout tooling.

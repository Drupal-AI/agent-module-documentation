<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Option Premium (nopremium) shows only the teaser of nodes marked premium to users without permission — a display-layer restriction, not access control.

---

Node Option Premium adds a "premium" flag to nodes and shows unprivileged users only the teaser instead of the full content, with a message inviting them to gain access — the pattern behind a soft paywall or members-only teaser. It adds the premium base field, a per-content-type permission to view full premium content, and swaps the view mode to the teaser display for users who lack it. It also adds a Search API processor to keep premium content out of search results.

The essential thing to understand — and the reason it must not be used to protect confidential content — is that **this is a presentation restriction, not access control**. It is implemented with `hook_entity_view_mode_alter()`, which changes which display Drupal themes; it does **not** implement any node-, entity- or field-access hook, so the node stays fully view-accessible and its field values are unchanged. Every path that loads the node and reads its fields therefore returns the full "premium" content. The teaser on the web page is a presentation choice; the data is not protected.

So its honest use is the soft one it names: showing non-subscribers a teaser to encourage sign-up, on a site where the premium content is not actually secret — a marketing gate, not a confidentiality boundary. If the premium content must genuinely be withheld — paid content, private material — this module does not do that, and you need real access control (field/node access) plus disabling or filtering JSON:API/REST for the affected types. Treat the premium flag as a presentation hint and never as protection.

---

- Show a teaser to non-subscribers.
- Build a soft paywall teaser.
- Mark a node as premium.
- Encourage subscription with a teaser.
- Restrict full content display by permission.
- Grant full-premium view per content type.
- Keep premium content out of search.
- Understand it is display-only.
- Never gate secret content with it.
- Use it as a marketing gate.
- Show members-only teasers.
- Add a premium flag to nodes.
- Invite users to gain access.
- Swap to teaser for unprivileged users.
- Know the full body is still returned by JSON:API.
- Use real access control for confidentiality.
- Disable JSON:API for premium types if needed.
- Treat premium as presentation, not protection.
- Tease paid content.
- Avoid a false paywall.
- Show a signup prompt.
- Gate display, not data.
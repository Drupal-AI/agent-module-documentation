<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mailchimp_popup_block — agent start

A block that triggers **Mailchimp's hosted subscriber pop-up**. Two modes via `method`:
- **manual**: renders `mailchimp_popup` twig template — a button with `data-mailchimp-popup-block-*`
  attributes (baseurl/uuid/lid) + description/button text.
- **automatic**: hidden wrapper (`hook_preprocess_block` sets display:none) + settings pushed to
  `drupalSettings.mailchimp_popup_block` (baseurl/uuid/lid + `popup_reappear_offset` seconds).

Both attach `mailchimp_popup_block/mailchimp_popup_block` which loads Mailchimp's pop-up JS. Config is
per-block on the Block layout form (schema in `config/schema`). Depends on core `block`. No permissions.

Security: **no server-side API calls, no API keys/secrets** — only public front-end identifiers
(UUID/list-ID) are used; Twig auto-escapes attributes. Nothing sensitive handled here.

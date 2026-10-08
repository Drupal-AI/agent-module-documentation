<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Status Message displays a configurable banner at the top of every page — for downtime notices, offers, or important news — with an optional link to a page with more detail.

---

The message is emitted by `hook_page_top`: the module reads `site_status_message.settings`, runs the text through `Xss::filter()` and then token replacement, and renders it via the `site_status_message` theme hook. Visibility is decided by `site_status_message_show_message()`, which honours the **Display options** setting — public-facing pages only, admin pages only, or both — and the render array is additionally gated per viewer with `#access` requiring the `access content` permission.

Configuration lives at `/admin/config/system/site-status-message` behind the `administer site status message` permission. Admins set the banner text (token-enabled when the Token module is present, up to 256 chars), optionally enable a "Read more" link that points to an internal node (entity-autocomplete) with custom link text, and choose where the banner appears. A small CSS library styles the banner. Typical setup is enabling the module, writing the message, choosing the display scope, and toggling it on.

---

- Show a site-wide announcement banner at the top of pages
- Warn users about scheduled downtime in advance
- Advertise a promotion or special offer site-wide
- Highlight important news to all visitors
- Add a "Read more" link to a details page after the message
- Point the read-more link to a specific node
- Customise the read-more link text
- Show the banner only on public-facing pages
- Show the banner only on admin pages
- Show the banner on both public and admin pages
- Insert dynamic values into the message using tokens
- Browse available tokens via the token tree link
- Toggle the banner on or off without uninstalling
- Restrict who can edit the banner via a dedicated permission
- Limit banner visibility to users with "access content"
- Style the banner via the module's CSS library
- Review current banner config under `site_status_message.settings`
- Quickly clear the banner by disabling the enable checkbox

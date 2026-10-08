<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Status Message — configure (site_status_message)

**Settings route:** `/admin/config/system/site-status-message`
(`site_status_message.admin_settings`, permission `administer site status message`).

## Fields (`site_status_message.settings`)
- **Enable message** (`enable`) — master toggle.
- **Status message** (`message`, max 256) — the banner text. Supports **tokens** when the
  Token module is installed; a token browser link is shown.
- **Read more page** (`showlink`) + **More information page** (`link`, node
  entity-autocomplete) + **More information link text** (`readmore`) — optional internal
  link appended after the message.
- **Display options** (`display_options`): Public-facing pages (0), Admin pages (1), or
  Both (2) — see `SiteStatusMessageInterface` constants.

## How it renders
`hook_page_top` reads config, `Xss::filter()`s the message, runs `token.replace()`, then
decides visibility via `site_status_message_show_message()` (the public/admin/both logic).
Output uses the `site_status_message` theme hook / `site-status-message.html.twig`
(`message|raw`) and is gated per viewer with `'#access' => hasPermission('access content')`.

## Notes
- The message is stored/rendered with `Xss::filter` applied at build time before `|raw`,
  so only Xss-admissible markup survives; the field is admin-only.
- The "Read More" link is built from the selected node id via `entity.node.canonical`.

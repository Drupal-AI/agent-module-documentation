<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Push Framework Mattermost

## Settings form
Route `mattermost.settings` → `/admin/config/system/push_framework/mattermost`
(permission `administer site configuration`). Fields, saved to `pf_mattermost.settings`:
- **domain** — Mattermost server URL.
- **token** — Mattermost personal access token (stored plaintext in config).
- **channel_id** — target channel id.

## Sending
`Plugin/PushFrameworkChannel/Mattermost::send()` builds a Gnello `Driver` with the domain +
token (empty `guzzle` options, so default TLS verification applies), authenticates, converts the
notification HTML to plain text via Markdownify, and calls `createPost` on the channel.

## Notes
- Generate the token per Mattermost's personal-access-token docs.
- Also ships a DANSE recipient-selection plugin (`Plugin/DanseRecipientSelection/Mattermost`).

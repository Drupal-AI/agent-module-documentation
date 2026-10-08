<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Push Framework Mattermost adds a Mattermost channel to the Push Framework, letting Drupal post notification content to a Mattermost channel via the Mattermost API.

---


A settings form (`/admin/config/system/push_framework/mattermost`, permission `administer site configuration`) stores the Mattermost server domain/URL, a personal access token, and the target channel id in `pf_mattermost.settings`. The channel plugin uses the Gnello Mattermost PHP driver (over Guzzle) to authenticate with the token and create a post, converting the notification HTML to Markdown/plain text. It also provides a DANSE recipient-selection plugin. The token is stored in module config (plaintext), and transport uses the driver's default Guzzle TLS (certificate verification on).

Setup: create a Mattermost personal access token, enter the domain, token, and channel id on the settings form, and enable the channel in Push Framework.
---
- Post Drupal notifications to a Mattermost channel.
- Configure the Mattermost server domain/URL.
- Store a Mattermost personal access token.
- Set the target channel id.
- Authenticate to Mattermost with the token.
- Convert notification HTML to Markdown/plain text.
- Use it as a Push Framework channel.
- Select recipients via the DANSE recipient plugin.
- Alert a team channel on content events.
- Send admin/ops notifications to Mattermost.
- Restrict settings to `administer site configuration`.
- Broadcast site events to a shared channel.
- Test connectivity by sending a message.
- Integrate Drupal alerts with existing Mattermost workflows.
- Route different notifications to a chosen channel.
- Rely on the Gnello driver over Guzzle (TLS verified).
- Generate a token per the linked Mattermost docs.

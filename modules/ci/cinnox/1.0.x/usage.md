<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CINNOX embeds the CINNOX omnichannel engagement widget on your Drupal site by injecting its JavaScript into page attachments.

---
A settings form at `/admin/config/cinnox/settings` (`administer site configuration`) stores the CINNOX identifier/script details in `cinnox.settings`. `cinnox_page_attachments_alter()` then adds the widget script to front-end pages (skipping admin pages and skipping injection when not configured). There are no routes that accept data and no callbacks.

Setup: obtain your CINNOX widget snippet/ID, enter it on the settings form, and the chat launcher appears on public pages. This is a straightforward third-party script embed; keep the widget configuration limited to administrators.
---
- Add the CINNOX chat widget to your site.
- Configure the CINNOX ID at `/admin/config/cinnox/settings`.
- Show a live-chat launcher on public pages.
- Skip the widget on admin pages.
- Disable the widget by clearing configuration.
- Offer omnichannel customer support.
- Route visitor chats to CINNOX agents.
- Restrict widget settings to administrators.
- Provide click-to-call/voice via CINNOX.
- Embed the script only on the front end.
- Toggle the widget per environment via config.
- Support messaging alongside a contact form.
- Localise the widget through CINNOX settings.
- Test the widget on a staging site.
- Remove the widget by disabling the module.

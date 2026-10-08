<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Whatsappshare — agent index

Attaches a **WhatsApp share button** via `hook_preprocess_html`; page URL + admin text/size/location go to JS through `drupalSettings`. Config `/admin/config/whatsappshare` (`access administration pages`). Version **8.x-1.1**, core `^9||^10`. Admin-config only — no untrusted rendering.
<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# twitter_block — agent start

Provides one core Block plugin, `twitter_block` (admin label "Twitter block", category
"Twitter"), that embeds a Twitter/X user timeline. There is **no settings page** and **no
module permission** — you place instances on **Structure → Block layout**
(`/admin/structure/block`) and each is gated by core's `administer blocks` permission.
Depends only on core `block`. Config is stored per block instance in the `block` config
entity under `settings`.

- Place a block, all settings keys, widget types, drush/PHP recipe → [configure/block-settings.md](configure/block-settings.md)
- The `twitter_block` Block plugin (form, build output, data-* attributes, widgets.js) → [plugins/twitter-block-plugin.md](plugins/twitter-block-plugin.md)

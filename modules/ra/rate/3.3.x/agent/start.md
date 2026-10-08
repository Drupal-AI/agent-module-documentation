<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rate — agent index

AJAX voting widgets (fivestar, thumbs, yes/no, emotion, …) attached to node/comment bundles,
storing votes via **VotingAPI**. Each widget is a `rate_widget` config entity. Depends on
`votingapi`, `node`, `views`, `datetime`.

- **Build & configure a widget (the `rate_widget` entity)** → [configure/widgets.md](configure/widgets.md)
- **Global bot-detection settings & permissions** → [configure/settings.md](configure/settings.md)
- **Invited hooks (alter votes/options, custom vote checks, add templates)** →
  [hooks/rate.md](hooks/rate.md)
- **Widget templates, CSS/JS, results summary, Views field, result functions** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Widget config entity: type `rate_widget`, config prefix `rate_widget`
  (config names `rate.rate_widget.<id>`); managed at `/admin/structure/rate_widgets`.
  Fields: `template`, `value_type`, `options[]`, `entity_types[]`, `comment_types[]`,
  `voting{use_deadline,anonymous_window,user_window}`, `display{…}`, `results{…}`.
- Global settings config: `rate.settings` (`bot_minute_threshold`, `bot_hour_threshold`,
  `botscout_key`, `disable_log`). Route `rate.admin_settings` at
  `/admin/config/search/votingapi/rate`.
- Permissions: `administer rate`, `view rate results page`, and dynamic
  `cast rate vote on <entity_type> of <bundle>` per widget-attached bundle.
- Votes live in VotingAPI's `votingapi_vote` table; node results tab at
  `/node/{node}/node-rating`. No Drush commands.

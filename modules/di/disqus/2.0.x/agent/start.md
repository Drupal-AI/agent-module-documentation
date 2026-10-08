<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disqus — agent index

Integrates the hosted **Disqus** commenting service. Set a site **shortname**
(`disqus_domain`), attach a **Disqus comments** field (`disqus_comment`) to a bundle, and each
entity renders a Disqus thread keyed by `entityType/entityId`. Comment data lives on Disqus,
not in Drupal. Config UI: `/admin/config/services/disqus` (route `disqus.settings`).

- **Settings config: shortname, behavior, API keys, SSO — keys & where stored** →
  [configure/settings.md](configure/settings.md)
- **Turn comments on for a bundle (the `disqus_comment` field) + the display blocks** →
  [configure/comments-and-blocks.md](configure/comments-and-blocks.md)
- **Programmatic API: `disqus_api()`, DisqusCommentManager, SSO hook, thread update/delete** →
  [api/api.md](api/api.md)
- **Permissions (4)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- All settings live in the `disqus.settings` config object (schema provided).
- Field type / widget / formatter all share id `disqus_comment`; requires `file` + `field`.
- Blocks: `disqus_recent_comments`, `disqus_popular_threads`, `disqus_top_commenters`,
  `disqus_combination_widget`.
- API features (thread update/close/remove, notifications) require the `disqus/disqus-php`
  library and a user access token; SSO requires public + secret keys.

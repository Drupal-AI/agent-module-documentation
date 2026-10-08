<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Social Share (better_social_share) — agent index

Renders a row of "share this page" buttons for 100+ platforms (Facebook, X/Twitter, LinkedIn,
WhatsApp, Pinterest, Telegram, Reddit, email, SMS, copy-link, …). These are **plain share links**,
not third-party widgets: each button is an `<a>` to a platform sharer URL (e.g.
`facebook.com/sharer.php?u=…`, `twitter.com/intent/tweet?text=…`) opened with `window.open` /
`window.location` on click. The module attaches only its own asset library
`better_social_share/better_social_share.front` (which pulls `core/jquery` + `core/drupal`) — no
vendor scripts, no cookies, no third-party contact before a click, so no GDPR-consent requirement.
The share URL and title come from the current entity/page (`entity_url`, `entity_title`) and are
baked into each button server-side; a shared "More" popup (fetched once from an AJAX route and
appended to `<body>`) exposes the full platform list, filling in the URL/title client-side.

Three ways to place the buttons: (1) the **block** `better_social_share_block`, which carries its own
per-block settings form (platform selection, style, float/position); (2) a **pseudo-field**
`better_social_share` shown on an entity's *Manage display* (enable that entity type in module
settings first); (3) a **Views field** `node_better_social_share`. Site-wide look/behaviour and the
default platform set live in one config object `better_social_share.settings`, edited at
`/admin/config/services/better-social-share`.

- Depends on: `drupal:node`, `drupal:block`. Core: `^9.4 || ^10 || ^11`. Package: `Better Social Share`.
- Settings page: route `better_social_share.admin_settings` (the info.yml `configure` route). One
  permission: `administer better_social_share` (`restrict access: TRUE`).
- No drush commands. No plugin types (no custom plugin manager). Ships config schema — but it is
  **partial** (only 5 of the ~15 written keys are typed); see [configure/settings.md](configure/settings.md).
- Extra surface: a Block plugin, a Views field handler, an entity extra-field, a Twig extension
  (two functions), and a public AJAX route `better_social_share.ajax` (`_access: 'TRUE'`, returns a
  static, input-free popup fragment).

## What you'd do → where

- **Choose default platforms / icon size / "More" button / colours / which entity types show buttons**
  (site-wide settings form + `better_social_share.settings` keys) → [configure/settings.md](configure/settings.md)
- **Place the share block and set its per-instance platforms, style and float position** →
  [configure/block.md](configure/block.md)
- **Show buttons on a node/entity's Manage display, or add them as a Views field** →
  [fields/display.md](fields/display.md)
- **Render buttons from code for an arbitrary URL/title or an entity; the alter hook; the AJAX popup route** →
  [api/functions.md](api/functions.md)
- **Override a platform button, add a new platform, or restyle via templates; theme hooks & suggestions** →
  [hooks/theme.md](hooks/theme.md)

## Key facts (real machine names)

- Routes: `better_social_share.admin_settings` (`/admin/config/services/better-social-share`, form
  `Form\BetterSocialShareSettingsForm`, perm `administer better_social_share`);
  `better_social_share.ajax` (`/better-social-share/get-popup`, `Controller\SocialShareController::ajaxCallback`,
  `_access: 'TRUE'`).
- Permission: `administer better_social_share` (`restrict access: TRUE`).
- Config object: `better_social_share.settings` (install default in `config/install/`). Schema
  `config/schema/better_social_share.schema.yml` (partial). Config-translation enabled.
- Block plugin: id `better_social_share_block` (`Plugin\Block\BetterSocialShareBlock`,
  admin label "Better Social Share Buttons").
- Views field: `node_better_social_share` (`Plugin\views\field\NodeBetterSocialShare`), registered by
  `better_social_share_views_data_alter()` on the `node` table.
- Entity extra-field: pseudo-field `better_social_share` on the *display* of any enabled content
  entity bundle (via `hook_entity_extra_field_info` + `hook_ENTITY_TYPE_view`).
- Service: `better_social_share.twig_extension` (`TwigExtension\FileExistsExtension`) — Twig functions
  `media_file_exists(filename)`, `get_media_file_path(filename)`.
- Theme hooks: `better_social_share_standard` (template `better-social-share-standard.html.twig`) and
  `social_share_popup` (`social-share-popup.html.twig`); suggestion hook
  `better_social_share_theme_suggestions_better_social_share_standard` →
  `better_social_share_standard__<entity_type>__<bundle>`.
- Per-platform partials: `templates/template-parts/<key>.html.twig` (one per platform key).
- Procedural API: `better_social_share_create_data($url, $title, $config)`,
  `better_social_share_create_entity_data(ContentEntityInterface $entity, $config)`,
  `better_social_share_platforms()`, `better_social_share_entity_type_has_bundles($id)`.
- Alter hook: `hook_better_social_share_entity_types_alter(array &$entities)` (invoked in the settings
  form and in `hook_entity_extra_field_info`).
- Asset library: `better_social_share/better_social_share.front` (js `js/better_social_share.js`, css
  `css/better_social_share.css`; deps `core/jquery`, `core/drupal`).
- Config keys (site-wide): `social_share_platforms` (map of `{enabled, weight}` per key),
  `buttons_size`, `more_button`, `custom_more_button`, `more_button_placement`, `btn_type`,
  `btn_bg_color`, `btn_border_round`, `btn_show_label`, `enable_button_spacing`, `buttons_label`,
  `icon_color_type`, `icon_color`, `entities.<entity_type_id>`.

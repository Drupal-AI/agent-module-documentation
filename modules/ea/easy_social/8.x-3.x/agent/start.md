<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Social (easy_social) — agent index

Adds a configurable set of social **share widgets** (Twitter/X, Facebook, LinkedIn, Pinterest, and a
plain-`mailto:` Email button) to a site. The set is rendered by the theme hook `easy_social`, which is
exposed three ways: as the **block** plugin `easy_social_block`, as an **extra display field**
(`easy_social`) that can be turned on per bundle in "Manage display" of comment/file/node/
taxonomy_term/user, and directly wherever `#theme => 'easy_social'` is built. `easy_social_theme()`
lists which widgets exist; `EasySocialSettingsForm` decides which of them are globally enabled
(`easy_social.settings:global.widgets`), and each network has its own settings form writing its own
config object (`easy_social.twitter`, `.facebook`, `.linkedin`, `.pinterest`, `.email`). Per-network
`hook_preprocess_HOOK` functions in `easy_social.module` translate that config into HTML `data-*`
attributes on each button; the network's own JavaScript (loaded from the asset library) turns those
into live buttons in the browser.

Widgets are pluggable through a **hook API** (not a Drupal plugin type): `hook_easy_social_widget()`
defines a widget (name + optional `js`/`css` library) and `hook_easy_social_widget_alter()` changes
one; the shipped `easy_social_example` submodule is a worked example. The current page URL is the only
page-derived value passed to templates (`$base_url . Url::fromRoute('<current>')`); the intended
"current title" is an unimplemented `@todo`.

- Depends on: nothing (info.yml has no `dependencies`). Core: `^9 || ^10 || ^11`. Package: none set.
- Has a settings page: **yes** — `configure: easy_social.settings` at `/admin/config/services/easy-social`,
  plus one sub-form per network. All six routes require the permission `administer easy_social`
  (`restrict access: TRUE`).
- Provides: config schema (6 config objects), one block plugin, one pseudo-field, a widget hook API.
- Does **not** provide: services, drush commands, a Drupal plugin type, field widgets/formatters, or
  any route that changes state on GET.
- Ships submodule `easy_social_example` (package `Examples`, not enabled by default) — a reference
  `hook_easy_social_widget()` implementation adding an `example` widget with its own settings form at
  `/admin/config/services/easy-social/example`.

## What you'd do → where

- **Choose which networks appear, toggle async JS, and set each network's options (via/hashtags,
  Facebook layout, LinkedIn counter, Pinterest description, Email subject/body)** →
  [configure/settings.md](configure/settings.md)
- **Show the share set — place the block, or enable the `easy_social` display field on a content type** →
  [configure/settings.md](configure/settings.md)
- **Add a custom network widget / alter the bundled ones / extend the entity types the pseudo-field
  attaches to** → [hooks/widgets.md](hooks/widgets.md)

## Key facts (real machine names)

- Routes (all `_permission: administer easy_social`): `easy_social.settings`
  (`/admin/config/services/easy-social`), `easy_social.settings_twitter`, `easy_social.settings_facebook`,
  `easy_social.settings_linkedin`, `easy_social.settings_pinterest`, `easy_social.settings_email`.
- Forms (`Drupal\easy_social\Form\*`): `EasySocialSettingsForm` (id `easy_social_settings`),
  `TwitterSettingsForm` (`easy_social_twitter`), `FacebookSettingsForm` (`easy_social_facebook`),
  `LinkedInSettingsForm` (`easy_social_linkedin`), `PinterestSettingsForm` (`easy_social_pinterest`),
  `EmailSettingsForm` (`easy_social_email`) — all extend `ConfigFormBase`.
- Block plugin id: `easy_social_block` (`Plugin\Block\EasySocialBlock`, admin_label "Easy Social").
- Pseudo-field: extra display component id `easy_social`, added by `easy_social_entity_extra_field_info()`
  to bundles of `comment`, `file`, `node`, `taxonomy_term`, `user`; rendered by `easy_social_entity_view()`.
- Permission: `administer easy_social` (`restrict access: TRUE`).
- Config objects + schema (`config/schema/easy_social.schema.yml`): `easy_social.settings`
  (`global.widgets` sequence, `global.async` bool), `easy_social.twitter` (via, related, dnt, count,
  lang, hashtags, size), `easy_social.facebook` (send, layout, width, show_faces, font, colorscheme,
  action — plus `share` used in code but not in schema), `easy_social.linkedin` (counter, lang),
  `easy_social.pinterest` (config, image, description), `easy_social.email` (button_label, button_title,
  subject, body).
- Theme hooks (`easy_social_theme()`): `easy_social`, `easy_social_twitter`, `easy_social_facebook`,
  `easy_social_linkedin`, `easy_social_pinterest`, `easy_social_email` — templates in `templates/`
  (plus legacy `theme_easy_social_pinterest()` in `easy_social.theme.inc`, unused in D9+).
- Asset libraries (`easy_social.libraries.yml`): `easy_social/twitter` (`js/twitter.js`),
  `easy_social/facebook` (`js/facebook.js`), `easy_social/pinterest` (external
  `//assets.pinterest.com/js/pinit.js`), `easy_social/linkedin` (external `//platform.linkedin.com/in.js`),
  `easy_social/easysocial-css` (`css/easy_social.css`).
- Hook API (see `easy_social.api.php`): `hook_easy_social_widget()`, `hook_easy_social_widget_alter(&$widgets)`,
  and the alter `hook_easy_social_supported_entity_alter(&$entity_types)`. Helper functions:
  `easy_social_get_widgets()`, `easy_social_get_supported_entities()`.
- Menu/task links: menu link `easy_social.overview`; local tasks `easy_social.show_settings` (base) +
  `easy_social.{facebook,twitter,pinterest,linkedin,email}`.
- Exception class: `Drupal\easy_social\EasySocialException` (thrown when an enabled widget has no definition).

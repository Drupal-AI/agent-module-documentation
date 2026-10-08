<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Buttons Configuration (buttons_config) — agent index

Lets an administrator override the text of the **submit ("Save") button** on node (content type),
media type, and comment type add/edit forms, per bundle and per form. Configuration lives in three
admin forms under `/admin/config/content/buttons-config`; each writes its own simple config object
(`buttons_config.node.settings`, `buttons_config.media.settings`, `buttons_config.comment.settings`)
whose single key `form_ids` is a list of `{form_id, form_type, enabled, custom_text}` rows.

The actual relabeling is done by `buttons_config_form_alter()` in `buttons_config.module`: on every
form build it looks at the first segment of the `$form_id` (`node`/`media`/`comment`), loads the
matching config object's `form_ids`, and for each **enabled** row computes a target form id
(`{form_id}_form` for a Save row, `{form_id}_edit_form` for an Edit row); when that equals the current
`$form_id` it sets `$form['actions']['submit']['#value'] = t($custom_text)`. There is no service, no
plugin, no schema — the config objects are untyped (there is no `config/` directory), and the label is
rendered by core as a fully escaped input `value` attribute.

- Depends on: `media`, `node`, `comment` (Drupal core modules; all three required, per `.info.yml`).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Fields`. Version `1.0.9`.
- Settings page: yes — `configure: buttons_config.admin_config_page` (a menu-block landing page); the
  three editable forms hang off it.
- Permissions: one — `admin buttons config` (gates all four routes). No drush. No plugin types.
- No config schema (`config/` directory absent), no services actually used (see Key facts caveat),
  no libraries, no templates.

## What you'd do → where

- **Set/override a submit-button label for a content, media, or comment type** →
  [configure/settings.md](configure/settings.md)
- **Understand exactly which form ids get relabeled and the stored data shape** →
  [hooks/form-alter.md](hooks/form-alter.md)

## Key facts (real machine names)

- Routes: `buttons_config.admin_config_page` (`/admin/config/content/buttons-config`, controller
  `\Drupal\system\Controller\SystemController::systemAdminMenuBlockPage`),
  `buttons_config.config_content_type.form` (`/…/content-type`),
  `buttons_config.config_media_type.form` (`/…/media-type`),
  `buttons_config.config_comment_type.form` (`/…/comment-type`). All require permission
  `admin buttons config`.
- Forms: `\Drupal\buttons_config\Form\ButtonsConfigContentTypeForm` (form id
  `buttons_config_node_settings`), `…\ButtonsConfigMediaTypeForm` (`buttons_config_media.settings`),
  `…\ButtonsConfigCommentTypeForm` (`buttons_config_comment_settings`) — all extend `ConfigFormBase`.
- Config objects (untyped): `buttons_config.node.settings`, `buttons_config.media.settings`,
  `buttons_config.comment.settings`; each has one key `form_ids` = list of rows with keys
  `form_id`, `form_type` (0=Edit, 1=Save), `enabled` (0/1), `custom_text` (string, maxlength 50).
- Permission: `admin buttons config` (`restrict access: false`).
- Hook: `buttons_config_form_alter()` (the relabeling mechanism); `buttons_config_help()`.
- Menu links (`buttons_config.links.menu.yml`): one parent + three children under
  `system.admin_config_content`.
- Caveat: `buttons_config.services.yml` declares a leftover service `gsso.gsso` pointing at a
  non-existent class `\Drupal\buttons_config\Form\ButtonsConfigForm` — it is never referenced, so it
  does nothing, but the definition is dead/broken (copy-paste residue; the `.module` `@file` docblock
  even reads "Group Node Access module file").

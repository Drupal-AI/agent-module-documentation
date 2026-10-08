<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `achievement_entity` config entity, forms & admin config

## The entity

`src/Entity/AchievementEntity.php` — `@ConfigEntityType(id = "achievement_entity")` extending
`ConfigEntityBase`. `config_prefix = "achievement_entity"`, `admin_permission =
"administer site configuration"`. `config_export` / exported properties: `id`, `label`, `uuid`,
`description`, `storage`, `secret`, `invisible`, `manual_only`, `points`, `use_default_image`,
`locked_image_path`, `unlocked_image_path`. Config schema:
`config/schema/achievement_entity.schema.yml` (`achievements.achievement_entity.*`).

Handlers: `view_builder` = `AchievementEntityViewBuilder`, `list_builder` =
`AchievementEntityListBuilder`, forms add/edit = `AchievementEntityForm`, delete =
`AchievementEntityDeleteForm`, `route_provider.html` = `AchievementEntityHtmlRouteProvider`.

Links (admin routes generated from these): `collection` `/admin/structure/achievements`,
`add-form` `/admin/structure/achievement/add`, `edit-form` `/admin/structure/achievement/{id}/edit`,
`delete-form` `/admin/structure/achievement/{id}/delete`, `canonical`
`/admin/structure/{achievement_entity}`. Menu links in `achievements.links.menu.yml`
(`entity.achievement_entity.collection` under *Structure*); action link in
`achievements.links.action.yml` (Add on the collection).

Key methods: `getDescription()`, `getPoints()`, `getStorage()`, `isSecret()`, `isInvisible()`,
`useDefaultImage()`, `getImagePath($type = 'locked', $allow_default = TRUE)` (falls back to the module's
`images/default-{locked,unlocked,secret}-70.jpg`), `getDefaultImagePath($filename)`.

## Add/edit form — `src/Form/AchievementEntityForm.php`

Fields: `label` (textfield, required), `id` (machine_name), `description` (textarea, required),
`storage` (textfield — the storage key shared by progressive achievements), `secret` (checkbox),
`invisible` (checkbox), `points` (number), and an **Images** details group. Images: `use_default_image`
checkbox plus `unlocked_image_path` / `locked_image_path` textfields and two `managed_file` uploads
(`#upload_location => 'public://achievements/'`, extensions `png gif jpg jpeg svg webp`).

- `validateForm()` unsets the path when "use default" is on, and validates any supplied path via
  `validatePath()`.
- `validatePath($path)` rejects absolute local paths (`file_system->realpath($path) == $path`), accepts a
  path that `is_file()`, otherwise prepends `public://` and re-checks. Returns the path or `FALSE`.
- `submitForm()` — on a `managed_file` upload, loads the file, `setPermanent()` + `save()`, and stores
  its `public://` URI in `{type}_image_path`; then normalizes any typed path through `validatePath()`.
- `save()` sets a message and redirects to the collection.

Rendering (`achievements_template_shared_variables()` in `achievements.module`): image URIs are converted
with `file_url_generator` when a valid stream URI, else used as a root-relative path. Secret + not-yet-
unlocked achievements are overridden in-render to `title` "Secret achievement", `points` "???",
description "Continue playing to unlock…", and the secret image. Label/description render through Twig
(`templates/achievement.html.twig`) and are auto-escaped; the achievement title is a `#type => 'link'`
render element.

## Site settings

`achievements.settings` config object — single key `image_hidden` (boolean; install default `null`).
`src/Form/AdminForm.php` (`achievements_admin_form`, `ConfigFormBase`) is a stub that saves nothing
substantive (its submit loops over an empty `$settings` array). Note the `manual_only` entity flag and
the `manually grant achievements` / `grant manual achievements` permissions exist in config/permissions,
but this release ships **no manual-grant route or UI** — granting happens only via the PHP API
(see [../api/achievements-api.md](../api/achievements-api.md)).

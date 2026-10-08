<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Editing Messages — agent start

info.yml name **Content Editing Messages** (`content_editing_message`), version **8.x-1.12**,
core `^8 || ^9 || ^10 || ^11`, requires only Drupal core.

Adds one or more admin-authored messages to **node** and **media** entity add/edit forms. Each
message is a config entity (`content_editing_message`) bound to selected bundles and, optionally,
to specific user roles; it renders as a styled `fieldset` inserted into the form. Implemented via
`hook_form_node_form_alter()` and `hook_form_media_form_alter()` in `content_editing_message.module`,
which loads all enabled message entities and appends the matching ones to the form.

## Configuration & routes (`content_editing_message.routing.yml`)
- List / collection: `/admin/config/content/messages` — route `entity.content_editing_message.collection`
  (`_entity_list`), `configure` target. Permission `administer content editing messages`.
- Add: `/admin/config/content/messages/add` — `_entity_create_access`.
- Edit: `/admin/config/content/messages/manage/{id}` — `_entity_access: update`.
- Delete: `/admin/config/content/messages/manage/{id}/delete` — `_entity_access: delete`.

Menu/action links under **Configuration → Content authoring → Content Editing Messages**.

## The message entity (`src/Entity/ContentEditingMessage.php`, config entity)
Config-exported fields: `id`, `subject` (translatable title), `body` (`text_format`: `value` + `format`,
translatable), `type`, `weight`, `customWeight`, `group`, `bundles`, `roles`, plus `status`.
- **type** — display style: 0 Info, 1 Warning, 2 Error, 3 Plain → CSS class (`css/message.css`,
  library `content_editing_message/content_message`).
- **weight** — placement: 0 Top, 1 Bottom, 2 Custom (`customWeight` numeric).
- **bundles** — node types + media types the message shows on (checkboxes).
- **roles** — if set, message only shows to editors with an intersecting role; empty = all editors.
- **group** — optional field_group machine name (only when `field_group` module is enabled); renders
  the message inside that group.

## Permissions (`content_editing_message.permissions.yml`)
- `administer content editing messages` — create/edit/delete messages; also the entity `admin_permission`
  that gates the add/edit/delete access checks. This is the only permission the module defines.

## Behavior notes
- `content_editing_message_get_messages()` queries all `status == 1` messages (`accessCheck(FALSE)` — just
  loads config to display) and `content_editing_message_display_message()` filters by bundle + role.
- Each matching message is inserted as a styled `fieldset`: the subject becomes the fieldset title and the body becomes its content.
- Add/edit/delete are entity forms (POST + CSRF); delete is a confirm form. No state-changing GET routes.

Docs: human walkthrough in [`../human-docs/`](../human-docs/index.md); `usage.md` for a prose summary.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# webnewsletter_emails entity

The subscriber record. `src/Entity/WebnewsletterEmails.php` defines a `@ContentEntityType`
(`id = "webnewsletter_emails"`) extending `RevisionableContentEntityBase`, using
`EntityChangedTrait` + `EntityOwnerTrait` and implementing `WebnewsletterEmailsInterface`
(`src/WebnewsletterEmailsInterface.php`, an empty marker over `ContentEntityInterface`,
`EntityOwnerInterface`, `EntityChangedInterface`).

- `base_table = webnewsletter_emails`, `revision_table = webnewsletter_emails_revision`, `show_revision_ui = TRUE`.
- `admin_permission = "administer web newsletter emails"`.
- `entity_keys`: id, revision=`revision_id`, label=`email`, uuid, owner=`uid`.
- `field_ui_base_route = entity.webnewsletter_emails.settings` (so Field UI tabs attach to the settings page).
- `route_provider` html = core `AdminHtmlRouteProvider` — the CRUD routes below are auto-generated from `links`, not declared in `webnewsletter.routing.yml`.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `email` | email | required, revisionable, the entity label |
| `name` | string (max 255) | revisionable |
| `status` | boolean | revisionable, default `TRUE` ("active" subscriber) |
| `uid` | entity_reference → user | author/owner; defaults via `getDefaultEntityOwner` |
| `created` | created | subscribed-on timestamp |
| `changed` | changed | last-edited timestamp |

`preSave()` forces `uid = 0` when no owner is set (anonymous subscriptions are owned by the anonymous user).

## Links / routes / paths

`links` in the annotation drive the routes (via `AdminHtmlRouteProvider`):

- collection → `/admin/config/webnewsletter/emails`
- add-form → `/admin/config/webnewsletter/email/add`
- canonical → `/admin/config/webnewsletter/email/{webnewsletter_emails}`
- edit-form → `.../{webnewsletter_emails}/edit`
- delete-form → `.../{webnewsletter_emails}/delete`

Only `entity.webnewsletter_emails.settings` (`/admin/structure/webnewsletter-emails`,
`WebnewsletterEmailsSettingsForm`, `_permission: administer web newsletter emails`) is declared in
`webnewsletter.routing.yml`. Menu/task/action links: collection appears under **Content**
(`system.admin_content`); settings under **Structure** (`system.admin_structure`); local tasks give
View/Edit/Delete/Settings tabs; an action link "Add web newsletter emails" shows on the collection.

## Permissions (`webnewsletter.permissions.yml`)

- `administer web newsletter emails` — `restrict access: true`; grants everything (entity admin permission) and the settings tab.
- `view web newsletter emails`, `create web newsletter emails`, `edit web newsletter emails`, `delete web newsletter emails`.

## Access control (`src/WebnewsletterEmailsAccessControlHandler.php`)

Extends core `EntityAccessControlHandler`:

- **view** → requires `view web newsletter emails`.
- **update** → `edit web newsletter emails` OR `administer web newsletter emails`.
- **delete** → `delete web newsletter emails` OR `administer web newsletter emails`.
- **create** (`checkCreateAccess`) → `create web newsletter emails` OR `administer web newsletter emails`.
- default → neutral.

The collection (subscriber list) route is gated by the entity's `admin_permission`
(`administer web newsletter emails`), so viewing the full list requires the administer permission.
All four generated CRUD routes and the settings route return HTTP 403 to anonymous users.

## List builder (`src/WebnewsletterEmailsListBuilder.php`)

Extends `EntityListBuilder`; injects `date.formatter`. Columns: Email (as a link to the entity),
Name, Status (Active/Inactive from the boolean), Subscribed (formatted `created`). `render()` appends
a `Total subscribers: @total` summary using an entity count query. Cell values render through the core
table theme (Twig-autoescaped); `email` is rendered via `toLink()`.

## Forms

- Add/edit use `src/Form/WebnewsletterEmailsForm.php` (extends `ContentEntityForm`): sets a status
  message + logger notice on save and redirects to the entity canonical page.
- Delete uses core `ContentEntityDeleteForm` (confirm form, CSRF-protected).
- Settings: `WebnewsletterEmailsSettingsForm` — see [../config/install.md](../config/install.md).

![WebNewsletter subscriber admin list](../../../../../../../screenshots/webnewsletter/12.0.x/emails-collection.png)

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebNewsletter (webnewsletter) — agent index

Newsletter-subscription management built on **Webform**. A Webform handler captures submissions
into a stored subscriber entity that staff manage through a permissioned admin UI.

- **Version:** 12.0.1 (dir `12.0.x`). **Core:** `^11.4 || ^12`. **License:** GPL-2.0-or-later.
- **Requires:** `webform:webform` (composer `drupal/webform:~6.3.0`). No other libraries, no config schema, no Drush commands.
- **Package/maintainer:** Webship (web* / UI Suite / Webship suite).

## What it provides

- **Content entity `webnewsletter_emails`** — revisionable, owner-aware subscriber record.
  Base fields: `email` (required), `name`, `status` (bool, default TRUE), `uid` (author), `created`, `changed`.
  `admin_permission = "administer web newsletter emails"`. Handlers: list builder, `EntityViewsData`,
  access control handler, add/edit/delete forms; routes via core `AdminHtmlRouteProvider`.
- **Webform handler plugin** `webnewsletter_subscribe` (`Newsletter Subscribe`) — creates a subscriber
  on submission, de-duped by email.
- **Permissions** (`webnewsletter.permissions.yml`): `administer web newsletter emails` (restricted),
  `view` / `create` / `edit` / `delete web newsletter emails`.
- **Default recipe** (`recipes/default`) — installs Webform + this module and imports the
  `newsletter_subscribe` webform (public form at `/newsletter/subscribe`) with a confirmation-email handler.

## Routes / paths

- `admin/config/webnewsletter/emails` — subscriber list (entity collection; `administer web newsletter emails`).
- `admin/config/webnewsletter/email/add` `.../{id}` `.../{id}/edit` `.../{id}/delete` — entity CRUD.
- `admin/structure/webnewsletter-emails` — `WebnewsletterEmailsSettingsForm` (settings tab + Field UI base route).
- `/newsletter/subscribe` — public webform (from recipe).

## Solution docs

- [agent/api/emails-entity.md](api/emails-entity.md) — the `webnewsletter_emails` entity, fields, routes, permissions, access control, list builder, forms.
- [agent/plugins/subscribe-handler.md](plugins/subscribe-handler.md) — the `webnewsletter_subscribe` Webform handler and the subscribe flow.
- [agent/config/install.md](config/install.md) — install, the default recipe, and the settings form.

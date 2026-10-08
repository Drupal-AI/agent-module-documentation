# Override Media Options — manual setup guide

**Override Media Options** (`override_media_options`) lets non‑administrator
users override the default publishing options for media items they are already
allowed to edit. It is the media equivalent of Drupal core's "override node
options" behavior: normally only administrators can change certain fields in the
**Authoring information** and **Publishing options** field sets on a media edit
form, but this module lets you delegate those individual fields — for example
the published status, the author, or the created date — to specific roles.

Rather than one broad "administer media" switch, the module exposes a separate
permission for each of those fields, so you can grant exactly what a role needs
and nothing more. A user still needs edit access to the media item itself; the
new permissions only unlock the extra authoring/publishing fields on media they
can already edit.

Because granting the "override published status" permission effectively lets
those users publish and unpublish media, treat the permission assignments as a
trust decision: give each field's permission only to roles you intend to have
that control, and confirm the result matches your editorial workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — assign the per‑field permissions and
   choose which options are exposed.

## Where it lives in the admin menu

Once enabled, you work with this module in two places:

- **People → Permissions** (`/admin/people/permissions`) — grant the module's
  per‑field override permissions to the roles that should have them.
- **Configuration → Content authoring → Override Media Options**
  (`/admin/config/content/override-media-options`) — the module's settings form,
  where you fine‑tune which options are available to override.

The effect then shows up on the media edit form: users with the relevant
permission see the previously hidden authoring and publishing fields.

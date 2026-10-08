# LocalGov Alert Banner — manual setup guide

**LocalGov Alert Banner** (`localgov_alert_banner`) provides sitewide emergency
banners for a [LocalGov Drupal](https://localgovdrupal.org/) site — the strip you'd
use to warn residents about severe weather, a major incident or a service
disruption. Banners are a dedicated **content entity** (not nodes) with their own
bundles, a moderation workflow and per-bundle permissions, and they're rendered by a
block that shows the highest-priority published banner wherever you place it.

Each banner carries a short description, an optional call-to-action link, a
**type of alert** (the severity/priority list, which drives ordering), and a
**visibility** setting that can restrict a banner to particular pages or contexts.
The bundle entity (`localgov_alert_banner_type`) lets a site distinguish, say,
routine notices from major incidents, and each type can have its own fields and
template. When several banners are live at once, the block shows the most severe:
banners are ordered by type-of-alert and then by most-recently-changed, and only
banners the visitor is allowed to view appear.

Around that core sits a full editorial stack: a content-moderation workflow so
banners are reviewed before going live, a ready-made **emergency publisher** role
for a comms team, an admin listing at `/admin/content/alert-banners`, revision
history and translation support, plus integration with **Scheduled Transitions**
(publish/unpublish at a set time) and the **Gin** admin theme. Permissions are split
between site-wide ones and per-bundle ones generated for each banner type, so
different teams can manage their own banner types without touching emergency alerts.
The module requires several core modules plus the contributed **Condition Field**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create banners, place the block, add
   banner types, set visibility, permissions, moderation and scheduling.

## Where it lives in the admin menu

- Banners are managed at **Content → Alert banners**
  (`/admin/content/alert-banners`).
- The banner block is placed via **Structure → Block layout**
  (`/admin/structure/block`).
- Banner types (bundles) are managed as configuration entities, gated by the
  restricted *Administer localgov alert banner types* permission.

There is no single "settings" page — the module is administered through its content,
block, workflow and permission screens.

## How to use it

1. Create a banner at **Content → Alert banners → Add**, choosing its type and
   severity and writing the message.
2. Place the **Alert banner** block in a region (typically the header) so banners
   appear site-wide.
3. Make sure the audience can see banners — anonymous visitors need the relevant
   *view* permission, which is the usual reason a published banner is invisible to
   the public.
4. Move the banner through the moderation workflow to publish it (and unpublish to
   take it down instantly).

See [Configuration](configuration/index.md) for the full walkthrough.

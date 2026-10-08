# Configuration

Setting up Alert Types is a short sequence: create a type, place the block, then
add alerts. Priority and visibility are set per alert.

## 1. Create an alert type

Go to **Structure** (`/admin/structure`) and create a new **Alert Type**. Each
type is a fieldable bundle, so once it exists you can add fields to it to carry
extra data (for example a link, an icon, or a category). You can create several
types for different kinds of announcement.

## 2. Place the Alerts block

From **Structure → Block layout**, place the **Alerts** block into the region
where banners should appear (typically near the top of the page). The block
loads active alerts over AJAX from the `/alerts/json` endpoint, so it honours
cache contexts and each alert's per-path visibility.

## 3. Add alerts

Go to **Content → Alerts** (`/admin/content/alerts`) and create an alert of one
of your types. For each alert you can:

- **Restrict visibility** to specific paths, content bundles, or roles.
- **Make it dismissable** — a user dismissing it is remembered in a cookie, so it
  does not reappear for them.
- **Auto-dismiss on a timer** using the Dismiss Timer behavior.
- **Toggle active/inactive** status; only active, published alerts are shown.

Alerts are **revisionable**, so you can view, revert and delete revisions.

## 4. Set priority

On the alerts listing, **drag and drop** to reorder alerts. The order sets each
alert's weight, which is its priority when several are shown at once.

## Permissions

Alert Types provides its own permissions on **People → Permissions**
(`/admin/people/permissions`):

- `administer alert types` and `administer alert entities` — full management.
- `add`, `edit`, `delete alert entities` — per-operation content control.
- `view active alert entities` — what ordinary visitors need to *see* live
  banners.
- `view inactive alert entities` — see alerts that are not currently active.
- Revision permissions for viewing and reverting revisions.

Grant `view active alert entities` broadly enough that your intended audience
can see banners, and keep the `administer` permissions to trusted roles.

## Behaviors and customisation (developers)

Alerts display and dismissal are driven by **behavior plugins**. The module
ships **Dismissable** and **Dismiss Timer**. A behavior has two parts — a Drupal
plugin annotated `@AlertTypeBehavior` and a matching JavaScript plugin/library —
and you attach it to an alert type. See the agent docs'
[behaviors reference](../../agent/plugins/behaviors.md) for how to add your own.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracking mechanism, storage schema & Views integration

Source: `src/EventSubscriber/MediaDownloadTrackerSubscriber.php`, `media_download_tracker.services.yml`,
`media_download_tracker.install`, `media_download_tracker.module`,
`config/install/views.view.media_download_tracker.yml`.

## How a download is captured

`MediaDownloadTrackerSubscriber` (service `media_download_tracker.subscriber`, args `@database`,
`@datetime.time`, `@current_user`) subscribes to `KernelEvents::REQUEST` via
`getSubscribedEvents()` → `['onRequest', 0]` (priority 0).

`onRequest(RequestEvent $event)`:

1. Gets the request and reads `$request->attributes->get('_route')`.
2. Acts **only** when `_route === 'media_entity_download.download'` (the route defined by the
   media_entity_download dependency, path `/media/{media}/download`). All other requests are ignored.
3. Reads the media entity from the route attribute (`$request->attributes->get('media')->id()`),
   the full URI (`$request->getUri()`), the `Referer` header (`$request->headers->get('referer')`,
   may be null), and the client IP (`$request->getClientIp()`).
4. Inserts one row into `media_download_tracker` with the media id, `time->getRequestTime()`,
   `currentUser->id()`, requested URL, referrer, and IP.

Notes for agents:

- It logs **every** matched request, including redirects/HEAD if the route matches; there is no
  dedupe, no throttling, and no success check on the actual file transfer — presence of the route
  match at the REQUEST stage is the trigger.
- The insert uses Drupal's query builder (`$database->insert(...)->fields([...])->execute()`), so
  values (URI, referrer, IP) are bound as parameters, not concatenated into SQL.
- Anonymous downloads store `uid` 0.

## Storage schema (`hook_schema`, table `media_download_tracker`)

| column | type | not null | notes |
|---|---|---|---|
| `id` | serial | yes | primary key |
| `media_id` | int | yes | downloaded media entity id |
| `timestamp` | int | yes | request time (unix) |
| `uid` | int | yes | current user id (0 = anonymous) |
| `requested_url` | varchar(255) | yes | full request URI |
| `referrer` | varchar(255) | no | `Referer` header |
| `ip_address` | varchar(45) | no | client IP (IPv4/IPv6) |

The table is created on install and removed on uninstall by core's schema handling. There is no
update hook.

## Views integration (`hook_views_data`)

Declares `media_download_tracker` as a Views **base table** (`base.field = id`, group "Media
Download Tracker"). Field/filter/relationship handlers:

- `id` — numeric field.
- `media_id` — numeric field + numeric filter; **relationship** to `media_field_data`
  (base field `mid`) → pull media name and any media field.
- `timestamp` — date field (click-sortable, default formatter `timestamp`) + standard sort + date filter.
- `uid` — numeric field + numeric filter; **relationship** to `users_field_data` (base field `uid`)
  → pull username and user fields.
- `requested_url` — standard field + string filter.
- `referrer` — standard field + string filter.
- `ip_address` — standard field + string filter.

## Shipped view (`config/install/views.view.media_download_tracker.yml`)

Installed once at module-enable (`enforced` on media_download_tracker; editable/deletable afterward).
Access = **role**, `administrator` only. Two page displays:

- **`page_1`** — path `/admin/reports/media-entity-downloads`, menu tab under
  `system.admin_reports` titled "Media Download Tracker". Table of Date, media Name (via `media_id`
  relationship), Requested URL, Referrer, IP Address; full pager 50/page; exposed date-range filter
  ("Dates between") on `timestamp`, default sort timestamp desc.
- **`page_2`** — path `/admin/reports/media-entity-downloads/count`, titled "Media Download Tracker
  Count". Uses **Views aggregation** (`group_by: true`): media Name grouped, and `requested_url`
  with `group_type: count` labeled "Downloads" → total downloads per media item.

To build custom reports, add displays on the base table and use the two relationships for
media/user fields; use a Data Export display for CSV. Report access is entirely the view's own
access setting — the module contributes no permission.

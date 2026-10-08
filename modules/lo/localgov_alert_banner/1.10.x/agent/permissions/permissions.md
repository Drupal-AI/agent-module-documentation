<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Global (`localgov_alert_banner.permissions.yml`)

| Permission | `restrict access` | Gates |
|---|---|---|
| `access localgov alert banner listing page` | — | The admin view at `/admin/content/alert-banners` and the entity `collection` route |
| `administer localgov alert banner types` | **true** | Banner **bundle** config (`localgov_alert_banner_type`) |
| `view all localgov alert banner entities` | — | View any banner entity, any bundle |
| `view all localgov alert banner entity pages` | — | View any banner's own page |
| `manage all localgov alert banner entities` | **true** | Full CRUD on every banner — also the entity type's `admin_permission` |

## Per bundle (generated)

`AlertBannerEntityPermissions::alertBannerTypePermissions()` is registered as a
`permission_callbacks` entry and generates three permissions **per banner type**:

```
view localgov alert banner {type_id} entities
view localgov alert banner {type_id} pages
manage localgov alert banner {type_id} entities
```

So adding a `service_notice` bundle immediately yields
`manage localgov alert banner service_notice entities`, letting one team manage their own banner
type without touching emergency alerts.

```bash
drush php:eval '
$storage = \Drupal::entityTypeManager()->getStorage("localgov_alert_banner_type");
foreach ($storage->loadMultiple() as $id => $t) { print "manage localgov alert banner $id entities\n"; }'

drush role:perm:add emergency_publisher 'manage localgov alert banner localgov_alert_banner entities'
drush role:perm:add emergency_publisher 'access localgov alert banner listing page'
```

## The `emergency_publisher` role

`user.role.emergency_publisher.yml` ships with the module — a ready-made role for the
communications team, granted `manage all …`, `view all …` (entities + pages), the listing
permission, both workflow transitions and admin-theme view. Check what it was granted on your site
(config may have been edited since install):

```bash
drush cget user.role.emergency_publisher permissions
```

`localgov_alert_banner_set_default_permissions()` applies the module's default permission set; it
runs on install and grants **anonymous and authenticated** users
`view all localgov alert banner entities` so that published banners are publicly visible (a sitewide
alert must reach every visitor). It also gives `emergency_publisher` access to the content overview
and toolbar where those modules exist. Call it manually after adding a bundle during a config sync:

```bash
drush php:eval 'localgov_alert_banner_set_default_permissions();'
```

## Access checking

- Entity access goes through `AlertBannerEntityAccessControlHandler::checkAccess()`, which for
  `view` allows `view all localgov alert banner entities` or the per-bundle
  `view localgov alert banner {bundle} entities`, and for update/delete/revision operations allows
  `manage all …` or the per-bundle `manage …`.
- A dedicated route access checker,
  `localgov_alert_banner.alert_banner_entity_page_access`
  (`Access\AlertBannerEntityPageAccess`, injecting `current_user` + `current_route_match`), guards
  the banner's own **page** routes (canonical + revision) — that is what the two `… pages`
  permissions are for, as distinct from seeing a banner rendered in the block. It allows
  `view all localgov alert banner entity pages` or the per-bundle
  `view localgov alert banner {bundle} pages`, otherwise forbidden.
- `AlertBannerRouteSubscriber` alters the `entity.localgov_alert_banner.canonical` and
  `.revision` routes to apply that checker.
- The `status_form` route requires the entity `update` operation; the `collection` route requires
  `access localgov alert banner listing page`.

## Practical guidance

- The banner block renders banners the visitor can `view`; anonymous users are granted
  `view all localgov alert banner entities` at install so published banners appear. If a published
  banner is unexpectedly invisible to the public, that permission (or the per-bundle equivalent)
  having been removed is the usual cause.
- `manage all localgov alert banner entities` is the entity type's `admin_permission` and bypasses
  the per-bundle permissions entirely; keep it for site administrators.
- Publishing is additionally governed by the `localgov_alert_banners` content moderation workflow,
  so a role needs both the manage permission **and** the workflow transition to take a banner live.

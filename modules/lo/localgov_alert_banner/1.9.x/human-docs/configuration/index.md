# Configuration

LocalGov Alert Banner has no single settings form — you configure it through its
content, block, permission and workflow screens. This page walks through the pieces
you'll set up.

## Create a banner

1. Go to **Content → Alert banners → Add** (or the entity's own add route).
2. Fill in:
   - **Title** — an internal name for the banner.
   - **Short description** — the message shown to visitors (a formatted-text field).
   - **Link** — an optional call-to-action link.
   - **Type of alert** — the severity/priority (for example a routine notice versus
     a major incident). This value **drives ordering** when several banners are live.
   - **Visibility** — where the banner shows (see below).
3. Save, then move it through the moderation workflow to publish it.

To take a banner down instantly, unpublish it.

## Place the banner block

Banners only appear where you place the block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Alert banner** block in a region — typically the header, so it shows
   site-wide.
3. In the block settings, use the **bundle filter** to choose which banner types the
   block shows. Leave it empty to show all types, or select specific ones.

When more than one banner is live, the block shows the most severe: banners are
ordered by **type of alert** (descending) and then by most-recently-changed. Only
banners the current visitor is allowed to view are considered.

## Visibility conditions

The **visibility** field is a *Condition Field* — it stores core condition plugins
(request path, content type, user role, language, and so on) directly on the banner.
A banner with no conditions shows everywhere; add conditions to restrict it to
particular pages or contexts.

One behaviour worth knowing: the module deliberately loads **every** published banner
before applying the visibility check, so that all candidates contribute their cache
contexts. That means a banner restricted to one path still influences the block's
cache metadata site-wide. This is intentional — it's what keeps the block correctly
cached when visibility varies per page.

## Adding more banner types

The shipped default type is often enough, but you can add your own (for example a
"service notice" type) so different services or teams have their own banners:

1. Manage banner types as `localgov_alert_banner_type` bundle entities (this requires
   the restricted **Administer localgov alert banner types** permission).
2. A new type can have its own fields, form/view displays and a template suggestion,
   so you can style, say, a `major` alert differently from a routine one.

Each new type automatically gains its own set of per-bundle permissions (see below).

## Permissions

Permissions are split between site-wide and per-bundle:

**Global permissions**

| Permission | Restricted | Gates |
|------------|-----------|-------|
| **Access localgov alert banner listing page** | — | The admin listing at `/admin/content/alert-banners` |
| **Administer localgov alert banner types** | Yes | Managing banner **bundles** |
| **View all localgov alert banner entities** | — | Viewing any banner, any type |
| **View all localgov alert banner entity pages** | — | Viewing any banner's own page |
| **Manage all localgov alert banner entities** | Yes | Full create/edit/delete on every banner (the entity type's admin permission — bypasses per-bundle permissions) |

**Per-bundle permissions** are generated automatically for each banner type — three
per type, for example:

```
view localgov alert banner service_notice entities
view localgov alert banner service_notice pages
manage localgov alert banner service_notice entities
```

So one team can manage their own banner type without touching emergency alerts.

The module ships a ready-made **emergency_publisher** role for the comms team. Check
what it was granted on your site (config may have been edited since install):

```bash
drush cget user.role.emergency_publisher permissions
```

> **Common gotcha:** the block only renders banners the visitor can *view*, so
> **anonymous users need** *View all localgov alert banner entities* (or the
> per-bundle equivalent) for banners to appear to the public. A published banner
> that's invisible is almost always this.

## Moderation and scheduling

- **Moderation.** The `localgov_alert_banners` workflow governs draft/published
  states. A role needs both the relevant *manage* permission **and** the workflow
  transition to take a banner live — grant the transitions to your emergency role.
- **Scheduling.** When the **Scheduled Transitions** module is installed, the module
  enables it for the banner entity type so banners can be set to publish and
  unpublish automatically at a chosen time. If you install Scheduled Transitions
  during a config sync, that automatic wiring is skipped — re-run it manually if
  needed:

  ```bash
  drush php:eval 'localgov_alert_banner_configure_scheduled_transitions();'
  ```

## Theming

The module registers a banner template with per-bundle and per-type template
suggestions, so you can style a `major` alert differently from a routine one by
overriding the appropriate template in your theme.

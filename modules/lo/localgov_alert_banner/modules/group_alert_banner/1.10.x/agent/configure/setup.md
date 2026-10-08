<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Group Alert banner

## Install

```bash
composer require drupal/group        # dev/suggested dependency of the parent project
drush en group_alert_banner -y
drush cr
```

Requires the parent `localgov_alert_banner` module and the contrib `group` module.

## Enable the relation on a group type

The relation plugin is `group_localgov_alert_banner`, derived per banner bundle. Install it on the
group type(s) that should carry banners (UI: *Group type → Content → Install* the *Group Alert
banner (<type>)* plugin, or via `group_relationship_type` config). Cardinality is fixed to 1.

## Routes

`RouteSubscriber::alterRoutes()` adds two group-scoped routes bound to the plugin:

| Route name | Path |
|---|---|
| `entity.group_relationship.group_alert_banner_add_banner` | `group/{group}/alert-banner/add` |
| `entity.group_relationship.group_alert_banner_create_banner` | `group/{group}/alert-banner/create` |

*add* relates an existing banner to the group; *create* creates a new banner within it.

## Permissions

- Group permission `access localgov_alert_banner overview` ("Access Alert banner listing page") —
  grant to group admins so they see the per-group *Alert banner* tab
  (`views.view.group_alert_banners`).
- The Group relation's own *Entity: View any alert banner entities* permission should be granted to
  the anonymous and authenticated (outsider/member) roles so published banners render.
- With `localgov_microsites_group` installed these are configured automatically
  (`LocalgovMicrositesHooks`); otherwise set them manually per the submodule README.

## Block placement

With the `localgov_microsites_base` theme, `config/optional/block.block.localgov_alert_banner_microsites_base`
places the banner block in the *Header* region automatically. For other themes, place an *Alert
banner* block near the top of the page as usual.

## Listing

Once installed, each Group page gains an *Alert banner* tab listing that group's banners via the
`group_alert_banners` view.

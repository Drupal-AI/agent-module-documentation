<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Group Media on a group type

There is **no** module settings page (`configure: null`). Group Media is set up per group
type by installing the `group_media` relation plugin, then per relation via its config.

## Enable media as group content (UI)

1. Create a group type (Group module) at `/admin/group/types`.
2. From the group type's dropbutton choose **Set available content**
   (`/admin/group/content/install/<group_type>` overview of relation plugins).
3. Each media type appears as its own plugin **Group media (<Type>)** = `group_media:<bundle>`.
   Install the ones you need. Installing shows a config form with:
   - **Enable media tracking** → stored as `plugin_config.tracking_enabled` (checkbox, default off).
   - **Entity cardinality** — disabled/locked to `1` by the plugin (a media item belongs to one
     group per relation); **Group cardinality** is editable.
   - Optional group creation wizard toggle (from Group core).
4. Set per-group permissions at `/admin/group/types/manage/<group_type>/permissions`
   (create/view/update/delete for each `group_media:<bundle>` plugin, plus
   `access group_media overview`).

Once at least one `group_media:*` plugin is installed and the user has
`access group_media overview`, each group gets a **Media** operation/tab
(route `view.group_media.page_1`, the shipped `group_media` view) with **Relate media**
and **Create media** action links.

## The config that results

Installing the plugin creates a `group_relationship_type` config entity:

```
group.relationship_type.<group_type>-group_media-<bundle>
  content_plugin: group_media:<bundle>
  plugin_config:
    group_cardinality: 0        # 0 = unlimited
    entity_cardinality: 1       # forced to 1
    use_creation_wizard: false
    tracking_enabled: 1         # 1 = auto-attach on, 0 = off
```

## Programmatic setup (drush php:eval)

```php
use Drupal\group\Entity\GroupType;
$gt = GroupType::create(['id' => 'team', 'label' => 'Team'])->save();  // or load existing
\Drupal::entityTypeManager()->getStorage('group_relationship_type')
  ->createFromPlugin(GroupType::load('team'), 'group_media:image', [
    'group_cardinality' => 0,
    'entity_cardinality' => 1,
    'use_creation_wizard' => FALSE,
    'tracking_enabled' => 1,
  ])->save();
```

Read the tracking flag back:

```php
$rt = \Drupal::entityTypeManager()->getStorage('group_relationship_type')
  ->load('team-group_media-image');
$rt->get('plugin_config')['tracking_enabled'];   // 0 or 1
// or: $rt->getPlugin()->isTrackingEnabled();
```

## Automatic tracking

When `tracking_enabled` is on, `groupmedia.attach_group` (service, hooked from
`hook_entity_update`, `hook_group_insert`, `hook_group_relationship_insert`) scans a saved
entity for media via `media_finder` plugins and attaches found media to the group. Manual
relate/create is **not** affected by this flag. Which items count and to which groups can be
altered — see [../hooks/alter-hooks.md](../hooks/alter-hooks.md).

## Permissions

- `administer groupmedia` (global, `restrict access`) — administer group media settings.
- `access group_media overview` (per group type) — see the group Media tab/overview.
- Standard per-plugin group permissions: `create|view|update|delete group_media:<bundle> entity`.

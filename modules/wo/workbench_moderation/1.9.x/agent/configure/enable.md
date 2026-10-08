<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable moderation on a bundle

Moderation is turned on **per content-entity bundle** via a third-party setting on the
bundle's config entity — there is no global on/off. The bundle "Moderation" form
(`BundleModerationConfigurationForm`, reached from a "Moderation" tab the module adds to the
bundle edit page via `EntityTypeModerationRouteProvider`) writes:

```yaml
# node.type.article  (third_party section)
third_party_settings:
  workbench_moderation:
    enabled: true
    allowed_moderation_states:
      - draft
      - needs_review
      - published
      - archived
    default_moderation_state: draft
```

Schema: `node.type.*.third_party.workbench_moderation` (also
`block_content.type.*.third_party.workbench_moderation`, and any bundle whose entity type the
module marks moderatable). Keys:

- `enabled` (bool) — turn moderation on for this bundle. **Enabling forces revisions on** for
  the bundle (a moderated bundle must keep revisions).
- `allowed_moderation_states` (array of state ids) — which states editors may choose here.
- `default_moderation_state` (string) — the state new content starts in (validated to be one
  of the allowed states; default `draft`).

## Set it in code

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('workbench_moderation', 'enabled', TRUE);
$type->setThirdPartySetting('workbench_moderation', 'allowed_moderation_states',
  ['draft', 'needs_review', 'published', 'archived']);
$type->setThirdPartySetting('workbench_moderation', 'default_moderation_state', 'draft');
$type->save();
```

Read back: `$type->getThirdPartySetting('workbench_moderation', 'enabled', FALSE)`.

## Admin overview

- `/admin/structure/workbench-moderation` — overview (route `workbench_moderation.overview`,
  the module's `configure` route, permission `access administration pages`).
- `/admin/structure/workbench-moderation/states` — Moderation states list/add/edit/delete.
- `/admin/structure/workbench-moderation/transitions` — Moderation transitions list/add/edit/delete.

Once enabled, moderated entities gain a `moderation_state` base field and a **"Latest version"**
tab (via `EntityModerationRouteProvider` + `LatestRevisionCheck`) showing the newest forward
revision. State/transition entities themselves: [states-transitions.md](states-transitions.md).

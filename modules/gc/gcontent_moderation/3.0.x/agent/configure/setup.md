<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Group Content Moderation

There is **no settings form** (`configure: null`). Setup is: (1) a content-moderation workflow,
(2) group roles granted the module's group permissions, (3) optionally the shipped view.

## 1. Content moderation workflow

Configure a normal Content Moderation workflow (e.g. core's Editorial) and apply it to the
node types used as group content. See core's content_moderation docs. The module generates a
group permission per transition of **every** `content_moderation` workflow automatically — no
extra config needed for the permissions to appear.

## 2. Grant group permissions

On each Group **type**'s permissions page, grant to the relevant group roles:

- `use <workflow_id> transition <transition_id>` — allows that member to perform that transition
  on their group's content (e.g. `use editorial transition publish`).
- `view latest version` — allows viewing pending/latest (unpublished) revisions of group content
  (the `/…/latest-version` tab and the moderation queue).

These are **group permissions** (not global permissions); they only take effect within a group
the user belongs to.

## 3. The "Moderated group content" view (optional config)

`config/optional/views.view.moderated_group_content.yml` installs a view when
`content_moderation` + `group` are present:

- Page display path **`group/%group/moderated`** (a "Moderated content" tab in the group menu).
- Access is the group permission **`view latest version`**.
- Lists **pending** node revisions (moderation state is NOT the published state).

Per the README, after install verify the exposed **Moderation state** filters match your
workflow (edit the view `moderated_group_content`, display `moderated_content`):
- "Moderation state (exposed): Is one of" → your pending/draft states;
- "Moderation state: Is none of" → your published state.

## 4. Views filter

The module adds a Views filter **`group_content_respect_unpublished`** (on `node_revision`) that
respects a member's own/any unpublished permissions plus "view latest version" for group node
revisions — use it in custom views of group content revisions.

## Read config via drush

```bash
drush cget views.view.moderated_group_content --include-overridden | head
drush pm:list --status=enabled | grep -E 'gcontent_moderation|content_moderation|group'
```

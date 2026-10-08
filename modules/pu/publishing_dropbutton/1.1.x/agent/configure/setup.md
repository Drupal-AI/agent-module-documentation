<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up & behavior

The module has **no settings form** (`configure: null`), no config entities and no schema. "Configuration"
is: enable it, and — only for `content_moderation` — hide the plain Published field on the node form.

## Enable

```bash
drush en publishing_dropbutton -y
```

That is all that is needed for **unmoderated** content types: with the module enabled, any user who has
`administer nodes` sees the dropbutton on the node add/edit form instead of the single **Save** button.
Nothing changes for users without `administer nodes` — they keep the ordinary **Save** button.

## content_moderation content types (extra step)

When a content type uses a Content Moderation workflow, the module automatically switches the
`moderation_state` field's form widget to **`moderation_state_dropbutton`** (via
`hook_entity_base_field_info_alter`). To avoid showing *two* publishing controls, move the node's
**Published** (`status`) field into the **Hidden** region on the content type's *Manage form display*:

- UI: `admin/structure/types/manage/{type}/form-display` → drag **Published** to *Disabled/Hidden*.

After that, the moderation dropbutton offers one **"Save and {transition}"** button per transition the
**current user is allowed to make** (resolved through `content_moderation.state_transition_validation`),
so it never presents a transition the user lacks permission for. Existing translatable nodes get the
label **"Save and {transition} (this translation)"** instead.

> `content_moderation` is a core module (`drush en content_moderation -y`) and must be enabled with a
> workflow assigned to the content type for the moderation widget to appear; otherwise only the plain
> node dropbutton applies.

## Plain-node button labels

For a user with `administer nodes`, `NodePublishingDropbutton::updateActions()`
(`src/NodePublishingDropbutton.php:16`) clones the core Save button into a `publish` and an `unpublish`
button. Labels depend on whether the node is new and its current status:

| Node state | "Publish" button label | "Unpublish" button label | Primary / first |
|---|---|---|---|
| New, default published | Save and publish | Save as unpublished | publish |
| New, default unpublished | Save and publish | Save as unpublished | unpublish |
| Existing, published | Save and keep published | Save and unpublish | publish |
| Existing, unpublished | Save and publish | Save and keep unpublished | unpublish |

The button matching the node's current published state is rendered **primary and first**; the other
loses its `#button_type` and sits in the dropdown (`#dropbutton => 'save'`). The plain `submit` button
is hidden (`#access = FALSE`).

## How the status change is applied

The buttons do not change status by themselves. `updateActions()` tags each button with a
`#published_status` boolean and registers an **entity builder**:

```php
$form['#entity_builders']['update_status'] = [NodePublishingDropbutton::class, 'updateStatus'];
```

At submit, `updateStatus()` (`src/NodePublishingDropbutton.php:78`) reads
`$form_state->getTriggeringElement()['#published_status']` and calls `$node->setPublished()` or
`setUnpublished()` before the node is saved. The moderation widget uses the same pattern with its own
builder `update_moderation_state` → `ModerationStateWidget::updateStatus`, writing
`$entity->moderation_state->value` from the pressed button's `#moderation_state`.

## Notes / limitations

- The module's own code comments flag that this button-cloning makes it **hard for other contrib
  modules to plug into "the Save operation"** — they cannot easily hook the `::submit()` and `::save()`
  steps independently of the pressed button (`src/NodePublishingDropbutton.php:19-22`). Expect friction
  when combining with modules that add their own node-form save actions.
- Presentation only: it never grants publishing rights. The plain-node buttons appear only for
  `administer nodes`, and the moderation buttons are limited to the current user's valid transitions.

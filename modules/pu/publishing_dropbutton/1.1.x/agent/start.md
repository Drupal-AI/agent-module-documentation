<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Publishing Dropbutton (publishing_dropbutton) — agent index

Restores the split **Save and publish / Save as unpublished** dropbutton on the **node form**,
for both plain (unmoderated) nodes and `content_moderation`-moderated nodes. Core 8.3 shipped this
control; core 8.4 replaced it with a Published checkbox plus one Save button, and this module puts
the dropbutton back. It is **presentation only** — the same permissions and the same moderation
transitions decide what an editor may do; it changes how the choice is offered, not who may make it.

- Depends on: core `system (>=8.4)`. Core: `^9.1 || ^10 || ^11`. Package: none.
- **No routes, no permissions, no config entities, no config UI** (`configure: null`), no config schema,
  no drush commands. It works entirely through two hook implementations and one field widget.
- Enable and it works — but for a `content_moderation` workflow you must also move the node's
  `status` (Published) field to the **Hidden** region on *Manage form display*, so the moderation
  dropbutton replaces the plain one. See [configure/setup.md](configure/setup.md).

## How it works (two mechanisms)

1. **Plain node buttons** — `publishing_dropbutton_form_alter()`
   (`publishing_dropbutton.module:17`) fires on any `NodeForm`. For users with **`administer nodes`**
   whose Save button is accessible, `NodePublishingDropbutton::updateActions()` clones the core
   `submit` button into a `publish` and an `unpublish` button (both `#dropbutton => 'save'`), hides
   the plain `submit`, and registers the `update_status` **entity builder**. The builder
   (`NodePublishingDropbutton::updateStatus`) reads the pressed button's `#published_status` flag and
   calls `$node->setPublished()` / `setUnpublished()` before save.
2. **Moderation dropbutton** — `publishing_dropbutton_entity_base_field_info_alter()`
   (`publishing_dropbutton.module:29`) swaps the `moderation_state` field's form widget to
   **`moderation_state_dropbutton`** (`src/Plugin/Field/FieldWidget/ModerationStateWidget.php`), a
   subclass of core `OptionsSelectWidget`. Its `processActions()` adds one **"Save and {transition}"**
   button per *valid transition for the current user* (from
   `content_moderation.state_transition_validation`), clusters them in the `save` dropbutton, and
   hides `submit`/`publish`/`unpublish`.

## What you'd do → where

- **Enable it, set up the content_moderation case, read the button-label matrix and label logic** →
  [configure/setup.md](configure/setup.md)

## Key facts (real names)

- Hooks: `publishing_dropbutton_form_alter` (documented as `hook_form_BASE_FORM_ID_alter`, but it is a
  plain `hook_form_alter` guarded by `instanceof NodeForm`); `publishing_dropbutton_entity_base_field_info_alter`.
- Helper class: `Drupal\publishing_dropbutton\NodePublishingDropbutton` — static
  `updateActions(&$element, $form_state, NodeInterface $node)` and entity builder
  `updateStatus($entity_type_id, NodeInterface $node, $form, $form_state)`.
- Field widget: `moderation_state_dropbutton` (label "Moderation state dropbutton"), field type
  `string`, `isApplicable()` limits it to the `moderation_state` field; entity builder
  `ModerationStateWidget::updateStatus` writes `$entity->moderation_state->value`.
- Gate for the plain-node buttons: `\Drupal::currentUser()->hasPermission('administer nodes')`
  **and** `$form['actions']['submit']['#access']` (`NodePublishingDropbutton.php:23`). Users without
  `administer nodes` keep the ordinary single **Save** button.
- Button ordering: the button matching the node's current published state is **primary and first**;
  the opposite action drops its `#button_type` and sits in the dropdown.
- `test_dependencies: workbench_moderation` reflects lineage from the pre-`content_moderation` era;
  it works with core Content Moderation. Tests:
  `tests/src/Functional/NodeFormButtonsTest.php`, `ModerationFormTest.php`.

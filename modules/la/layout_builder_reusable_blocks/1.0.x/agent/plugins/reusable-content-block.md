<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin — `LayoutBuilderReusableContentBlock`

`src/Plugin/Block/LayoutBuilderReusableContentBlock.php`. Extends core
`Drupal\block_content\Plugin\Block\BlockContentBlock` and implements
`ContainerFactoryPluginInterface`. It has **no `@Block` annotation / attribute of its own** — it is
not a separately-placeable plugin. Instead `hook_block_alter` (see
[../api/block-alter.md](../api/block-alter.md)) swaps this class in as the implementation of **every**
existing `block_content:*` derivative. `create()` adds `config.factory` as `$this->configFactory`.

## In-place editing (only when enabled)

`buildConfigurationForm()` first calls `parent::buildConfigurationForm()`, then detects Layout
Builder context:

```
$is_layout_builder = $form_state->get('layout_builder_tempstore_key')
  || $form_state->get('section_storage')
  || $form_state->getBuildInfo()['base_form_id'] === 'layout_builder_configure_block';
```

If in Layout Builder **and** `$this->getEntity()` exists, it reads
`layout_builder_reusable_blocks.settings`:

- `allow_editing_reusable_blocks` (`?? FALSE`). **All extra behaviour is inside `if ($allow_editing)`
  — when the setting is off (the default) nothing below happens and the block behaves like core's.**
- When on:
  - If `show_warning` (`?? TRUE`), renders a `messages messages--warning` container whose body is
    `#markup => $this->t($warning_text)` (weight -100). `warning_text` default is the standard
    "changes affect all instances" sentence.
  - Sets `$form_state->set('is_layout_builder', TRUE)` and embeds the block's own entity edit form:
    `EntityFormDisplay::collectRenderDisplay($block, 'default')->buildForm($block, $form['block_form'], $form_state)`
    at `#parents => ['settings','block_form']`. Hides the entity `info` and `revision_log` fields
    (`#access = FALSE`) and reweights `admin_label` / `label` / `label_display`.

## Validate / submit

Both short-circuit unless `$form_state->get('is_layout_builder')` is set (i.e. only when the embedded
form was built):

- `validateConfigurationForm()` → `parent::…`, then
  `EntityFormDisplay::collectRenderDisplay(...)->extractFormValues()` + `validateFormValues()` on the
  block entity; stashes `block_form_parents` in a temporary value.
- `submitConfigurationForm()` → `parent::…`, then re-reads the block_form via
  `NestedArray::getValue()`, `extractFormValues()`, and **`$this->getEntity()->save()`** — writing the
  edited content back to the shared `block_content` entity.

## Behaviour to flag

- Saving here writes to a **library (reusable) block**, so the edit propagates to every layout that
  places it. This is the module's headline feature and its main operational risk; the warning message
  exists to surface it. Off by default.
- Because `hook_block_alter` reassigns the class **globally** (not just in Layout Builder), this class
  backs `block_content:*` blocks everywhere, but the added form logic is fully guarded by the
  `$is_layout_builder` + `allow_editing` checks, so outside Layout Builder it is a pass-through to the
  core parent.

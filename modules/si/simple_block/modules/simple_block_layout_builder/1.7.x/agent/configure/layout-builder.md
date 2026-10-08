<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Simple Block in Layout Builder

Enabling this submodule (`drush en simple_block_layout_builder -y`) is the whole setup — it has
no configuration. It requires `layout_builder` and `simple_block`.

## What it adds

1. **"Create simple block"** link in the Layout Builder *Add block* screen. Core's
   `ChooseBlockController` only shows "Add content block"; the event subscriber
   `SimpleBlockAddControllerSubscriber` (listening to `KernelEvents::VIEW` on route
   `layout_builder.choose_block`) appends a link to `simple_block_layout_builder.edit_block`
   (gated by `administer blocks`).
2. A **`layout_builder` form handler** on the `simple_block` entity type
   (`EditSimpleBlockInLayoutBuilderForm`, extends `SimpleBlockEditForm`) — the off-canvas
   create/edit form used inside LB.
3. `hook_contextual_links_alter()` rewrites the **Configure** contextual link of an already
   placed `simple_block` component to open that same form.

## Placing a simple block in a layout (UI)

1. Enable Layout Builder on a display (e.g. content type *Manage display* → *Layout options* →
   "Use Layout Builder").
2. In the layout, click **Add block** in a section → **Create simple block** (to author a new
   one) or pick an existing **Simple block** from the list.
3. Save the layout. The section now holds a component with plugin id `simple_block:<id>`.

## Placing programmatically

A simple block is placed like any block plugin — as a Layout Builder `SectionComponent` whose
configuration `id` is `simple_block:<id>`:

```php
use Drupal\layout_builder\SectionComponent;

$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.<bundle>.default');                 // Layout-Builder-enabled
$section = $display->getSection(0);
$section->appendComponent(new SectionComponent(
  \Drupal::service('uuid')->generate(),
  'content',                                       // region
  ['id' => 'simple_block:<id>'],
));
$display->save();
```

Verify a display's layout contains it by iterating `$display->getSections()` →
`$section->getComponents()` → `$component->getPluginId() === 'simple_block:<id>'`.

## Caveat

Simple blocks created through Layout Builder are **not** automatically deleted when removed from
a layout (see the module's issue #3206910).

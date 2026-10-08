<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-block styles: storage, rendering, and code

## Where a block's styles live

When an editor sets styles on a block in Layout Builder, they are stored on the Layout Builder
`SectionComponent` under the key `bootstrap_styles`, shaped like:

```php
$component->get('bootstrap_styles');
// [
//   'block_style' => [
//     'background'       => ['background_type' => 'color'],
//     'background_color' => ['class' => 'bg-primary'],
//     'spacing'          => [...],   // padding / margin classes, etc.
//     ...
//   ],
// ]
```

The exact sub-keys come from the enabled Bootstrap Styles plugins (`background`, `typography`,
`spacing`, `border`, `shadow`, `animation`). Class-bearing plugins store their chosen CSS class
under a `class` sub-key (e.g. `background_color.class = 'bg-primary'`).

## How the form saves it

`layout_builder_blocks_form_alter()` adds the tabbed UI to the `layout_builder_add_block` /
`layout_builder_update_block` forms and prepends `_layout_builder_blocks_submit_block_form()`,
which calls Bootstrap Styles' `submitStylesFormElements()` and does
`$component->set('bootstrap_styles', ['block_style' => $styles])`. The block's original fields are
moved into the **Content** tab client-side by `Drupal.behaviors.LayoutBuilderBlocksContentTab`.
The Style tab is only added when the block passes the `block_restrictions` check and the route is
not a dashboard route.

## How styles reach the front end

`Drupal\layout_builder_blocks\EventSubscriber\BlockComponentRenderArraySubscriber` subscribes to
`LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY` (priority **50**). In `onBuildRender()`
it reads `bootstrap_styles.block_style` off the component and, if non-empty, calls
`\Drupal::service('plugin.manager.bootstrap_styles_group')->buildStyles($build, $block_style, NULL)`,
which merges the utility classes / wrapper markup into the render array. No styles → render array
untouched.

## Apply styles to a block component in code

```php
use Drupal\layout_builder\Section;
use Drupal\layout_builder\SectionComponent;

// Build (or load) a Layout Builder override on an entity that has LB enabled + overridable.
$section = new Section('layout_onecol');
$component = new SectionComponent(\Drupal::service('uuid')->generate(), 'content', [
  'id' => 'system_powered_by_block',
  'label' => 'Powered by',
  'label_display' => '0',
  'provider' => 'system',
]);
// Attach a Bootstrap Styles background color.
$component->set('bootstrap_styles', [
  'block_style' => [
    'background' => ['background_type' => 'color'],
    'background_color' => ['class' => 'bg-primary'],
  ],
]);
$section->appendComponent($component);
$node->get('layout_builder__layout')->setValue([$section]);
$node->save();
// Rendering $node now emits the block wrapped with the `bg-primary` class.
```

## Read styles back

```php
foreach ($node->get('layout_builder__layout')->getSections() as $section) {
  foreach ($section->getComponents() as $component) {
    $bs = $component->get('bootstrap_styles');
    if (!empty($bs['block_style'])) {
      // Inspect $bs['block_style'] for applied classes.
    }
  }
}
```

The `plugin.manager.bootstrap_styles_group` service (class `StylesGroupManager`) is the key
collaborator: `buildStylesFormElements()` builds the Style tab, `submitStylesFormElements()`
extracts values on submit, and `buildStyles()` applies them at render time.

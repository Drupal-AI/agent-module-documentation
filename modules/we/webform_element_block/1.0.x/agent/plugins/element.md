<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Block Element — element plugin

The module's only capability. `src/Plugin/WebformElement/WebformBlockElement.php`.

- **Plugin id:** `webform_block_element`
- **Label:** "Webform Block Element"
- **Category:** "Custom" (in the Add element selector)
- **Base class:** `Drupal\webform\Plugin\WebformElement\WebformMarkup` — it is a markup/display element, so it collects no submitted value and stores nothing in the submission.

## Adding it
Webform Build tab → Add element → choose "Webform Block Element" (Custom category). Set the one custom property.

## Configuration property
- **Block ID** (`#block_id`, textfield; default `''`) — the machine name of a **block plugin** to render, e.g. `system_powered_by_block`, `system_branding_block`, or a custom block plugin id. Not a block *config entity* id; it is passed straight to the block plugin manager. Defined in `defineDefaultProperties()` (`block_id => ''`) and exposed in `form()`.

## Rendering
`prepare()` (runs when the element is built for display):
```
if (!empty($element['#block_id'])) {
  $plugin_block = $this->blockManager->createInstance($element['#block_id'], []);
  $block_render_array = $plugin_block->build();
  $element['#markup'] = $this->renderer->render($block_render_array);
}
```
The block plugin is instantiated with empty configuration, its `build()` output is rendered to an HTML string, and that string becomes the element `#markup`. If `#block_id` is empty the element renders nothing.

## Notes / limits
- The block plugin is created with no configuration and no context (`createInstance($id, [])`), so plugins that require configuration or context (e.g. some derivative/entity blocks) may render empty or error.
- Rendering happens once at element prepare time; there is no caching integration or configuration form for the block itself.

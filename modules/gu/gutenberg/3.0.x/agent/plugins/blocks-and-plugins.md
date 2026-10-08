# Add editor blocks & JS plugins

Gutenberg has two extension surfaces: a **`MODULE.gutenberg.yml` discovery file** for registering
JS block libraries/blocks (the usual way to add blocks) and a **`@GutenbergPlugin` plugin type**
for editor-side JS plugins.

## Block discovery — `MODULE.gutenberg.yml` (or `THEME.gutenberg.yml`)

Discovered by `GutenbergLibraryManager` / `BlocksLibraryManager`. Sections:

```yaml
# Attach JS/CSS libraries to the editor form and/or the rendered node.
libraries-edit:
  - my_module/blocks
libraries-view:
  - my_module/blocks
# Blocks rendered server-side via a Twig template (see below).
dynamic-blocks:
  my-module/my-dynamic-block: {}
# Custom blocks that can be enabled/disabled per content type, grouped into categories.
custom-blocks:
  categories:
    - reference: media          # the block category to add into
      name: Media
      blocks:
        - id: my-module/card
          name: Card
```

The core/embed block catalogue itself lives in the module's own `gutenberg.blocks.yml`
(categories "Core" and "Core Embed", plus `default_drupal_blocks` and a `blacklist`). Gutenberg's
own `gutenberg.gutenberg.yml` registers the `drupalmedia/drupal-media-entity` dynamic block.

### JS blocks

Register blocks in your library's JS with the WordPress block API
(`registerBlockType('my-module/card', …)`), building with `@wordpress/*` packages. Depend on the
`gutenberg/*` libraries (`gutenberg/react`, `gutenberg/block-editor`, `gutenberg/blocks`,
`gutenberg/components`). A block's metadata can live in a `block.json` (`apiVersion`, `name`,
`title`, `attributes`, `supports`, `styles`, `variations`).

### Dynamic (server-rendered) blocks

Declare the block under `dynamic-blocks` and provide a Twig template named
`gutenberg-block--<module>--<block>.html.twig` (dashes → underscores). Available variables:
`block_name`, `block_content`, `block_attributes`, `attributes`. The `DynamicRenderProcessor`
(and `hook_gutenberg_block_view_alter()`) build the render array.

## Editor JS plugin type — `@GutenbergPlugin`

A real Drupal plugin type: annotation `Drupal\gutenberg\Annotation\GutenbergPlugin`, manager
`plugin.manager.gutenberg.plugin` (`GutenbergPluginManager`), namespace `Plugin/GutenbergPlugin`,
base class `GutenbergPluginBase`, interface `GutenbergPluginInterface`.

```php
namespace Drupal\my_module\Plugin\GutenbergPlugin;

use Drupal\gutenberg\GutenbergPluginBase;
use Drupal\editor\Entity\Editor;

/**
 * @GutenbergPlugin(
 *   id = "myplugin",
 *   label = @Translation("My plugin"),
 *   module = "my_module"
 * )
 */
class MyPlugin extends GutenbergPluginBase {
  public function getFile() { return ''; }                 // FALSE for internal plugins
  public function getLibraries(Editor $editor) { return ['core/drupal.ajax']; }
  public function getConfig(Editor $editor) { return ['myKey' => 'value']; }
}
```

`getLibraries()` are attached to the editor's text_format element; `getConfig()` adds keys to the
editor JS config. See `Drupal\gutenberg\Plugin\GutenbergPlugin\DrupalImage` for a working example.

## Block rendering pipeline (server side)

The `gutenberg` filter runs stored block markup through processors tagged
`gutenberg_block_processor` (service-collected by `gutenberg.block_processor_manager`):
`DrupalBlockProcessor`, `OEmbedProcessor`, `ReusableBlockProcessor`, `ContentBlockProcessor`,
`LayoutProcessor`, `DynamicRenderProcessor`, `FieldMappingProcessor`, `DuotoneProcessor`. Add your
own by tagging a service `gutenberg_block_processor` (implement
`GutenbergBlockProcessorInterface`). Reusable blocks and custom content blocks are stored as
`block_content` entities (type `reusable_block`).

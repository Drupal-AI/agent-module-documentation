# Extending — `LayoutBgTrait`

`\Drupal\layout_bg\LayoutBgTrait` turns any Layout Builder layout plugin into a
background-region layout. Both built-ins are thin: they set a `$baseLayoutTemplate` and `use` the trait.

## Add a background region to your own layout
1. Declare the layout in your module's `*.layouts.yml` with a `background` region, a base region
   (`default_region`), `theme_hook: layout__layout_bg` (to reuse the shared template) or your own,
   and `class: \Drupal\yourmod\Plugin\Layout\MyBgLayout`.
2. Create the plugin class extending a core layout base and mixing in the trait:

```php
use Drupal\Core\Layout\LayoutDefault;
use Drupal\layout_bg\LayoutBgTrait;

class MyBgLayout extends LayoutDefault {
  use LayoutBgTrait;
  // Template used to render the non-background content regions.
  protected $baseLayoutTemplate = 'layout--onecol.html.twig';
}
```

3. Add a schema entry `layout_plugin.settings.<your_layout_id>` mirroring
   `layout_plugin.settings.layout_bg_onecol` so the trait's settings validate.

## What the trait provides
- `defaultConfiguration()` — the nine background/overlay/text defaults.
- `buildConfigurationForm()` / `submitConfigurationForm()` — the section settings form.
- `build($regions)` — calls `parent::build()`, then `processBackground()`, and passes
  `#base_layout_template` through to the template.
- `processBackground($build)` — keeps only the first non-empty background block
  (`processed_background`), suppresses its label, and writes the inline color/overlay/text-color
  styles and positioning classes onto the region/content/overlay attributes.

If you subclass a multi-region base (like `TwoColumnLayout`), override `build()` to re-apply the
base layout's own wrapper classes after `processBackground()`, as `LayoutBgTwoCol` does.

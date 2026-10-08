# How the per-paragraph view mode is chosen and applied

The behavior plugin class is
`Drupal\paragraphs_viewmode\Plugin\paragraphs\Behavior\ParagraphsViewmodeBehavior`
(id `paragraphs_viewmode_behavior`), extending `ParagraphsBehaviorBase` and implementing
`ParagraphsViewmodeBehaviorInterface`.

## Editor choice (per paragraph)

`buildBehaviorForm()` adds a single select, "Select which view mode to use for this paragraph",
whose options are `override_available` intersected with the site's paragraph view modes, defaulting
to `override_default`. `submitBehaviorForm()` saves the pick as a **behavior setting** named
`view_mode` on the paragraph entity:

```php
$paragraph->getBehaviorSetting('paragraphs_viewmode_behavior', 'view_mode', $override_default);
```

This per-paragraph value lives in the paragraph entity's `behavior_settings`, not in config.

## Applying it at render time

`paragraphs_viewmode.module` implements `hook_entity_view_mode_alter(&$view_mode, $entity, $context)`.
For a `ParagraphInterface` entity it loops the paragraph type's enabled behavior plugins and calls
`entityViewModeAlter()`:

```php
public function entityViewModeAlter(&$view_mode, ParagraphInterface $paragraph, array $context) {
  $raw_override_mode = $this->configuration['override_mode'];
  $override_mode = array_search($raw_override_mode, $this->configuration['override_available'], TRUE);
  $new_view_mode = $paragraph->getBehaviorSetting($this->pluginId, 'view_mode', $this->configuration['override_default']);
  if ($view_mode !== $override_mode || $override_mode === $new_view_mode) {
    return;
  }
  $view_mode = $new_view_mode;
}
```

So the swap only happens when the paragraph is being rendered in the configured override target and
the editor's pick differs from it. Stored field data is untouched; only the render view mode changes.

## Interfaces / extension points

- `ParagraphsViewmodeBehaviorInterface::entityViewModeAlter()` is the single public method other
  code could call. There is no plugin manager, service, hook, or Drush command to extend — the
  module is a thin behavior plugin plus one hook implementation.

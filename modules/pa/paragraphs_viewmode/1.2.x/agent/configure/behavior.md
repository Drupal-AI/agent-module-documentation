# Enable the Paragraphs View Mode behavior on a paragraph type

There is **no configure route** and no settings form of its own. You enable the behavior plugin
`paragraphs_viewmode_behavior` on a paragraph type (Structure → Paragraph types → *edit* →
**Behaviors**), or write it directly into the paragraph type config entity.

## Where the settings are stored

Config entity: `paragraphs.paragraphs_type.<type>`
Path within it:

```yaml
behavior_plugins:
  paragraphs_viewmode_behavior:
    enabled: true
    override_mode: default            # which view mode this override targets
    override_available:               # view modes an editor may switch to (map keyed by mode id)
      default: default
      teaser: teaser
      preview: preview
    override_default: teaser          # the default view mode for new paragraphs of this type
```

- `override_mode` — the rendered view mode that triggers the swap. When a paragraph is being
  rendered in this mode, the module replaces it with the editor's per-paragraph choice.
- `override_available` — the allowed set the editor can choose from (a map of `mode_id: mode_id`);
  these are `paragraph` entity view modes (`\Drupal::service('entity_display.repository')
  ->getViewModeOptions('paragraph')`).
- `override_default` — the default choice; it **must** also be present in `override_available`
  (the plugin's `validateConfigurationForm()` enforces this).

## Via drush php:eval (scriptable)

```php
$pt = \Drupal::entityTypeManager()->getStorage('paragraphs_type')->load('my_type');
$pt->set('behavior_plugins', [
  'paragraphs_viewmode_behavior' => [
    'enabled' => TRUE,
    'override_mode' => 'default',
    'override_available' => ['default' => 'default', 'teaser' => 'teaser'],
    'override_default' => 'teaser',
  ],
]);
$pt->save();
```

## Read it back

```bash
drush cget paragraphs.paragraphs_type.my_type behavior_plugins
# look for paragraphs_viewmode_behavior.enabled: true and the override_* keys
```

Or in PHP: `\Drupal\paragraphs\Entity\ParagraphsType::load('my_type')->get('behavior_plugins')`.
The enabled plugin instances are also available via `->getEnabledBehaviorPlugins()`.

## Config schema

The module ships schema `paragraphs.behavior.settings.paragraphs_viewmode_behavior` (extends
`paragraphs.behavior.settings_base`) with `override_mode` (text), `override_available` (sequence),
and `override_default` (text).

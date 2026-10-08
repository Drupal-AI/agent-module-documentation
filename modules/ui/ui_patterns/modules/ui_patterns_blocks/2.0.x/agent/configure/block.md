<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place a UI Patterns component block

Plugin id form: `ui_patterns:<theme_or_module>:<component>` (e.g. `ui_patterns:olivero:teaser`).
List them: `drush php:eval 'foreach(array_keys(\Drupal::service("plugin.manager.block")->getDefinitions()) as $id){ if(strpos($id,"ui_patterns:")===0) print $id."\n"; }'`

Create a placement from code (verified live):
```php
\Drupal\block\Entity\Block::create([
  'id' => 'mycomponentblock',
  'theme' => 'olivero',
  'region' => 'content',
  'plugin' => 'ui_patterns:olivero:teaser',
  'settings' => [
    'id' => 'ui_patterns:olivero:teaser',
    'label' => 'My Teaser', 'label_display' => '0',
    'ui_patterns' => [
      'component_id' => 'olivero:teaser', 'variant_id' => '', 'props' => [],
      'slots' => ['title' => ['sources' => [[
        'source_id' => 'textfield', 'source' => ['value' => 'Hello'], 'value' => 'Hello',
      ]]]],
    ],
  ],
])->save();
```

Read it back: `drush config:get block.block.mycomponentblock`.

- The stored `settings.ui_patterns` array is identical in shape to the field-formatter and
  layout surfaces — see parent `agent/configure/components.md`.
- Use the entity-aware variant to pass the current entity into sources.

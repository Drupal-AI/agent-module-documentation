<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a UI Patterns field formatter

Formatter ids: `ui_patterns_component` and `ui_patterns_component_per_item`.

Set it from code (verified live):
```php
\Drupal::service('entity_display.repository')->getViewDisplay('node','article','default')
  ->setComponent('body', [
    'type' => 'ui_patterns_component_per_item',
    'label' => 'hidden',
    'settings' => ['ui_patterns' => [
      'component_id' => 'olivero:teaser',
      'variant_id'   => '',
      'props'        => [],
      'slots'        => ['content' => ['sources' => [[
        'source_id' => 'textfield', 'source' => ['value' => 'Hi'], 'value' => 'Hi',
      ]]]],
    ]],
  ])->save();
```

Read it back:
```bash
drush php:eval '$d=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default"); print json_encode($d->getComponent("body"));'
```

- `component_id` = `<theme_or_module>:<component>`.
- `props` = map of prop → single source; `slots` = map of slot → list of sources.
- Source ids and the full `ui_patterns` shape are documented in the parent module's
  `agent/configure/components.md` and `agent/plugins/plugin-types.md`.

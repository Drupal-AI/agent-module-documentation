<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Class — enable & use the wrapper-class behavior

The module has **no settings page**. It works entirely through the Paragraphs behavior system.

## 1. Enable the behavior on a Paragraphs type

UI: *Structure → Paragraphs types → (edit a type) → Behaviors* tab → tick **"Paragraphs wrapper
class"** → Save. Because `isApplicable()` returns TRUE, it can be enabled on any Paragraphs type.

Config equivalent — the behavior is stored on the `paragraphs.paragraphs_type.<TYPE>` config entity
under `behavior_plugins`:
```yaml
behavior_plugins:
  paragraphs_class_paragraph_class:
    enabled: true
```
```
drush cget paragraphs.paragraphs_type.<TYPE>
```
Requires the `paragraphs` module and the core "edit behavior plugin settings" permission to see the
Behaviors tab.

## 2. Set the class on a paragraph

When editing content, each paragraph of that type now shows a **"Wrapper class"** text field
(in the paragraph's behaviors area). Type one or more space-separated class names. The value is
saved as the paragraph's behavior setting `wrapper_class`:
```
$paragraph->getBehaviorSetting('paragraphs_class_paragraph_class', 'wrapper_class');
```

## 3. What renders

`ParagraphsClassBehavior::view()` appends the stored value to the paragraph render array:
```php
$build['#attributes']['class'][] = $class;
```
So the class lands on the paragraph's outer wrapper element in the rendered HTML. Drupal's
attribute rendering escapes class values, so it is a styling hook only (not a raw-HTML injection
point). There is no validation or whitelist — supply valid CSS class names.

## Notes / limitations

- Single field, single string — no separate "multiple classes" widget (just type them with spaces).
- `settingsSummary()` shows a static "Wrapper class element" line in the paragraph summary.
- No config schema ships for the `wrapper_class` behavior setting.

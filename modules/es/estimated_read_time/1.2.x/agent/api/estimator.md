<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the read time is computed

## Trigger: `hook_entity_presave`

`estimated_read_time_entity_presave()` runs for every fieldable entity and delegates to the
`estimated_read_time.entity_read_time_estimator` service
(`EntityReadTimeEstimator::setEstimatedReadTime()`).

## `EntityReadTimeEstimator::setEstimatedReadTime()`

For each field of type `estimated_read_time` on the entity:

1. **Skip if manual:** if `$entity->get($name)->auto === 0`, it does nothing (the editor's
   manual minutes/seconds are kept).
2. Reads the field's `view_mode` and `words_per_minute` settings.
3. **Switches to the default front-end theme** (`system.theme:default` via
   `ThemeInitialization` + `ThemeManager::setActiveTheme`) so the measured markup matches what
   readers see, not the admin theme.
4. `doEstimate()` builds the entity in that view mode and renders it with
   `renderer->renderInIsolation()`. For `Node` entities it temporarily sets `in_preview = TRUE`
   to avoid the links field erroring on unsaved nodes, then restores it.
5. The rendered string is passed to `estimated_read_time.read_time_adapter`
   (`ReadTimeAdapter::estimate()`), which wraps the **`mtownsend/read-time`** library:
   `new ReadTime($content, FALSE, FALSE, $wordsPerMinute)` and returns
   `['minutes' => …, 'seconds' => …]`.
6. The result is written back with `auto => 1`:
   `$entity->set($name, $estimation + ['auto' => 1])`.
7. **Translations:** if the field is translatable, every translation with
   `hasTranslationChanges()` (other than the current one) is re-estimated the same way.
8. Restores the original active theme.

## Services

| Service id | Class | Role |
|---|---|---|
| `estimated_read_time.entity_read_time_estimator` | `EntityReadTimeEstimator` | presave orchestration, theme switch, per-field/per-translation estimate |
| `estimated_read_time.read_time_adapter` | `ReadTimeAdapter` | adapter over `mtownsend/read-time`; `estimate(string $content, ?int $wpm): ['minutes','seconds']` |

To estimate programmatically you can call the estimator on an entity before saving, or the
adapter directly on arbitrary text:

```php
$adapter = \Drupal::service('estimated_read_time.read_time_adapter');
$rt = $adapter->estimate($longText, 230);   // ['minutes' => 4, 'seconds' => 12]
```

## Notes for an agent

- The stored value is a side effect of **saving the entity** — there is no cron or queue.
  To force a refresh, resave the entity (with `auto` on).
- `words_per_minute` and `view_mode` live on the **field config**, not a global setting.
- Because measurement renders a full view mode, the estimate reflects everything shown in
  that view mode (body, referenced fields, etc.), themed by the front-end theme.

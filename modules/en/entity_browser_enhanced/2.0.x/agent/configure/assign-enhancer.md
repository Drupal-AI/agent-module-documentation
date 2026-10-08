<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assigning an enhancer to an Entity Browser widget

## Where the choice is stored

A plain (non-entity) config object **per entity browser**:

```yaml
# config name: entity_browser_enhanced.widgets.<entity_browser_id>
# key = the widget's UUID, value = enhancer id or '_none_'
0f1a5f0c-1234-4b7f-9d0d-3f9b0e4b0f11: multiselect
9c2d7f11-abcd-4c22-8f2e-11a2b3c4d5e6: '_none_'
```

Schema: `entity_browser_enhanced.widgets.*` (mapping, `uuid: string`) in
`config/schema/entity_browser_enhanced.schema.yml`.

The widget UUIDs come from the entity browser itself:

```bash
drush config:get entity_browser.browser.<browser_id> widgets
```

Each widget entry has `id` (the widget plugin, e.g. `view`, `upload`), `uuid`, `label`,
`weight`, `settings`.

## Via the UI

1. *Configuration → Content authoring → Entity browsers* (`/admin/config/content/entity_browser`).
2. **Edit** the browser → **Widgets** step.
3. Each **View** widget row now shows a **Select enhancer** dropdown:
   `- None -`, `Enhanced Multiselect`, `Enhanced Autoselect`.
4. Choose one and **Save**. The extra submit handler `entity_browser_enhanced_submit()` writes
   the value into `entity_browser_enhanced.widgets.<browser_id>`.

Only widgets whose plugin instance is `\Drupal\entity_browser\Plugin\EntityBrowser\Widget\View`
get the dropdown — `upload`, `entity_form` and other widget types are skipped.

## Via drush / PHP

```bash
# read
drush config:get entity_browser_enhanced.widgets.my_browser

# set (uuid from `drush config:get entity_browser.browser.my_browser widgets`)
drush config:set entity_browser_enhanced.widgets.my_browser \
  0f1a5f0c-1234-4b7f-9d0d-3f9b0e4b0f11 multiselect -y
```

```php
$browser = \Drupal::entityTypeManager()->getStorage('entity_browser')->load('my_browser');
foreach ($browser->getWidgets() as $uuid => $widget) {
  if ($widget->getPluginId() === 'view') {
    \Drupal::configFactory()
      ->getEditable('entity_browser_enhanced.widgets.' . $browser->id())
      ->set($uuid, 'multiselect')
      ->save();
  }
}
```

> Note: `entity_browser_enhanced_submit()` only writes when the submitted value is non-empty, so
> selecting `- None -` stores the literal string `_none_` rather than removing the key.

## What enabling it does at render time

When an `EntityBrowserForm` is built, `entity_browser_enhanced_form_alter()`:

1. reads `entity_browser_enhanced.widgets.<browser_id>` for every widget UUID (default `_none_`);
2. for a matching enhancer definition, attaches `$form['#attached']['library'][] = <definition library>`;
3. copies the field cardinality (when the browser runs as a field widget, from
   `$form_state->getStorage()['entity_browser']['validators']['cardinality']['cardinality']`) into
   `drupalSettings.entity_browser_enhanced.<enhancer_id>.cardinality`;
4. adds the CSS classes `entity-browser-enhanced` and the definition's `form_extra_class`
   (`multiselect` or `autoselect`) to the form element.

## The two bundled enhancers

| id | label | form_extra_class | library | Behaviour |
|---|---|---|---|---|
| `multiselect` | Enhanced Multiselect | `multiselect` | `entity_browser_enhanced/entity_browser_enhanced.multiselect` | Whole `.views-col` tile is clickable, checkboxes hidden by CSS, selection capped at `cardinality` (`-1` = unlimited, `<=1` = single-select), submit button disabled until ≥1 selected, **double-click selects and submits**, plus a debounced `change` trigger on `.keyup-change` inputs. |
| `autoselect` | Enhanced Autoselect | `autoselect` | `entity_browser_enhanced/entity_browser_enhanced.autoselect` | Clicking `.views-field-entity-browser-select` immediately fires Entity Browser's `add-entities` event on `.entities-list` — requires `drupalSettings.entity_browser_widget.auto_select` (the View widget's *Automatically submit selection* setting). |

The multiselect JS expects a **grid** style view
(`form.entity-browser-enhanced.multiselect .view .view-content .views-view-grid` with
`.views-col` rows) — use a Views *Grid* format in the widget's view display.

## Gotchas

- `drush cr` after changing config so the altered form and libraries are picked up.
- `entity_browser_enhanced_library_info_alter()` **unsets** `lightning_media/browser.styling`
  when Lightning Media is present, to stop competing styles.
- The config object name is derived from `$entity_browser->getName()` (the entity browser's
  machine id); one config object per browser, all widget UUIDs inside it.

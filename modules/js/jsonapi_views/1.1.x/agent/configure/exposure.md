<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Controlling JSON:API exposure per display

The module ships a Views **display extender** to switch a display's JSON:API resource on/off.
There is no module settings page — the toggle lives on each view display.

## The `jsonapi_views` display extender

`src/Plugin/views/display_extender/JsonapiViews.php`
(`@ViewsDisplayExtender(id="jsonapi_views", title="Expose via JSON:API", no_ui=FALSE)`).

- One option: `enabled`, **default TRUE** — so every display is exposed out of the box.
- `isExposed()` returns that option; `ViewsResource::process()` returns 403 when it is FALSE.

Config schema (`views.display_extender.jsonapi_views`): a single boolean `enabled`.

## Where it is stored

In the view config entity, under the display:

```yaml
# views.view.<id>
display:
  <display_id>:
    display_options:
      display_extenders:
        jsonapi_views:
          enabled: false        # false = NOT exposed
```

Read it: `drush cget views.view.frontpage display.page_1.display_options.display_extenders.jsonapi_views`

## Enabling the extender in the UI

Display extenders only render their settings form when enabled site-wide. To see the
"Expose via JSON:API" section in the Views UI:

1. *Structure → Views → Settings* (`/admin/structure/views/settings`) → tick
   **JSON:API Views** under "Display extenders", save.
2. Edit a view → in the display's third column, open **JSON:API → Exposed via JSON:API** and
   uncheck **Expose via JSON:API** to disable, or check it to expose. Save the view.

Because the default is TRUE, a display with no stored extender value is still exposed. To
disable programmatically, set `enabled: false` in the display's `display_extenders` and save
the view.

## Scriptable toggle (drush php:eval)

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('frontpage');
$display = &$view->getDisplay('page_1');
$display['display_options']['display_extenders']['jsonapi_views']['enabled'] = FALSE;
$view->save();
```

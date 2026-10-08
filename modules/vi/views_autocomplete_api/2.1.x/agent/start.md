<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Autocomplete API (views_autocomplete_api) — agent index

Turns a **View into an autocomplete/typeahead endpoint** that returns JSON `{value, label}`
suggestions. You attach it to any Form API textfield with `#autocomplete_route_name` and the module
runs the View per keystroke, using the View's filters, sorts, arguments, result limit, header/footer/
empty areas and **its own access plugin**. Version 2.1.0. Package `Views`. Core `^10.3 || ^11.0`.
Depends only on core **`views`**. Ships one demo submodule.

## Solution docs
- Route, controller, param converter, the multi-View request format → [routes/autocomplete.md](routes/autocomplete.md)
- The manager service: filter injection, field-to-suggestion mapping, highlight, special rows → [api/manager.md](api/manager.md)
- Settings form + config object/schema → [config/settings.md](config/settings.md)
- Demo submodule → [`../../modules/views_autocomplete_api_demo/2.1.x/`](../../modules/views_autocomplete_api_demo/2.1.x/agent/start.md)

## What it actually is (from source)
- **One route** `views_autocomplete_api` at `/admin/view_content/{view_name}/{display_id}/{views_arguments}`
  (`views_autocomplete_api.routing.yml`), `_permission: 'access content'`, defaults `display_id: default`,
  `views_arguments: ''`. Controller `ViewsAutocompleteApiController::getViewsDataJson()` reads `?q=`,
  returns a `JsonResponse`.
- **One param converter** `ViewsConverter` (service `views_autocomplete_api.converter`, tag `paramconverter`,
  type `views-autocomplete-api-views`): explodes `{view_name}` on `,` and `loadMultiple()`s the View
  entities (missing ids kept as empty-string entries).
- **One service** `ViewsAutocompleteApiManager` (`views_autocomplete_api.manager`): executes each View,
  injects the search string into exposed filters, maps rendered fields to `{value,label}`, optionally
  highlights, and renders header/footer/empty "special rows".
- **One settings form** `ViewsAutocompleteApiConfigForm` at `/admin/config/views-autocomplete-api`
  (`_permission: 'administer views autocomplete api'`), editing config object `views_autocomplete_api.settings`
  (single key `highlight`). Note: that permission is **not defined by this module** (no `*.permissions.yml`)
  — see config/settings.md.
- **Two theme hooks** (`views_autocomplete_api.module`): `views_autocomplete_api_highlight`
  (`{{ search_word }}`) and `views_autocomplete_api_special_row` (`{{ row|raw }}`), templates in `templates/`.
- No entities, no plugin types, no permissions.yml, no Drush commands on disk (composer.json advertises a
  `drush.services.yml` that is not shipped), no libraries.

## Attach it (README pattern)
```php
$form['my_field']['#type'] = 'textfield';
$form['my_field']['#autocomplete_route_name'] = 'views_autocomplete_api';
$form['my_field']['#autocomplete_route_parameters'] = ['view_name' => 'my_view1,my_view2'];
```
Last View field → suggestion `label`; second-to-last field → `value` injected on selection.

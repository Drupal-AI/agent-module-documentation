<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Ajax Callback Formatter" formatter

## Install & enable

```bash
composer require drupal/ajax_callback_field_formatter
drush en ajax_callback_field_formatter -y
```

Requires core **`link`** (the plugin subclasses `Drupal\link\Plugin\Field\FieldFormatter\LinkFormatter`).
No sub-modules, no permissions, no routes, no config schema, no Drush commands.

## Enable it on a field

Plugin id **`ajax_callback_field_formatter`**, label *"Ajax Callback Formatter"*,
`field_types = {"link"}` — it applies **only to core Link fields**, not to text, image or custom types.

UI path: add a **Link** field to a bundle, then *Structure → (bundle) → Manage display* → set that
field's format to **Ajax Callback Formatter**. Because it extends `LinkFormatter`, the standard Link
formatter settings (trim length, `rel`, `target`, etc.) still appear on the gear and are honoured by
`parent::viewElements()`.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_my_link.type ajax_callback_field_formatter -y
drush cr
```

## What the formatter renders

`AjaxCallbackFieldFormatter::viewElements(FieldItemListInterface $items, $langcode)`
(`src/Plugin/Field/FieldFormatter/AjaxCallbackFieldFormatter.php`):

1. Calls `parent::viewElements()` to get the normal Link render elements (this resolves each
   `#url` as a `Drupal\Core\Url` and applies inherited Link settings).
2. Builds a base selector id from the host entity:
   `str_replace('_','-', $entity->getEntityTypeId())` + `--` + `$entity->id()` + `--` +
   `str_replace('_','-', $items->getFieldDefinition()->getName())`.
3. Replaces **each** delta's element with:

   ```php
   [
     '#theme' => 'ajax_callback_field_formatter_template',
     '#title_value' => $element['#title'],
     '#element_attributes_url' => $url->toString(),
     '#element_attributes_id' => "$baseSelectorId--$delta",
   ]
   ```

4. Attaches the library
   `ajax_callback_field_formatter/ajax_callback_field_formatter` to the field render array.

The theme hook is declared in `ajax_callback_field_formatter_theme()`
(`ajax_callback_field_formatter.module`) with variables `title_value`, `element_attributes_url`,
`element_attributes_id`. The template
(`templates/ajax-callback-field-formatter-template.html.twig`) is:

```twig
<span data-execute-ajax-callback-field-formatter-url="{{ element_attributes_url }}"
      data-execute-ajax-callback-field-formatter-id="{{ element_attributes_id }}">
    {{ title_value }}
</span>
```

So the anchor becomes a `<span>` whose id follows the pattern
`entity_type--entity_id--field_name--delta` (dashes, not underscores). The link **text part** is the
visible placeholder/fallback; the link **URL part** is the AJAX endpoint.

## The client-side request flow

`js/ajax_callback_field_formatter.js` registers
`Drupal.behaviors.ajax_callback_field_formatter` (library deps `core/drupal`, `core/drupal.ajax`,
`core/once`). On attach it:

1. `once('ajax_callback_field_formatter', '[data-execute-ajax-callback-field-formatter-id]', context)`
   — each span is processed once.
2. Builds `new URL(window.location.origin + <url attribute>)` (the request is forced same-origin —
   the URL attribute is treated as a path off the current origin).
3. Sets query param `ajax_callback_field_formatter_id` to the **CSS selector**
   `[data-execute-ajax-callback-field-formatter-id="…"]` so your controller can target the exact
   element to replace.
4. `Drupal.ajax({ url }).execute()` — the request fires immediately on page load; any AJAX error
   is `console.log`-ged (status + statusText).

There is **no click handler** — the callback runs when the element attaches, i.e. on every render.

## The controller contract (you implement this)

The module provides **no route or controller** — that is intentional (README: *"you juste have to
implement controllers"*). You must:

1. Define a route + controller whose path matches the URL you put in the Link field.
2. Return a `Drupal\Core\Ajax\AjaxResponse` with one or more AJAX commands, e.g.:

   ```php
   public function callback(Request $request): AjaxResponse {
     $selector = $request->query->get('ajax_callback_field_formatter_id');
     $response = new AjaxResponse();
     $response->addCommand(new ReplaceCommand($selector, $build));
     return $response;
   }
   ```

3. Set that route's `_access` / permission requirements yourself, and validate any route
   arguments — the formatter and JS do not add access control; the request runs with the **viewing
   user's** own session and privileges.

## Notes & gotchas

- Multi-value Link fields: each delta gets its own span and its own callback fire.
- The URL is emitted through Twig (`{{ element_attributes_url }}`), so it is HTML-attribute-escaped;
  the id is derived from entity/field metadata, not user free-text.
- Because the JS prefixes `window.location.origin`, an absolute external URL in the link is not
  fetched cross-origin as-is — design callbacks as internal Drupal routes.
- Nothing is cached specially: the callback re-fires on each fresh render of the field.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CustomElement plugin — ViewsElement ("Drupal View")

The module's whole behaviour lives in one class:
`Drupal\site_studio_views_element\Plugin\CustomElement\ViewsElement`
(`src/Plugin/CustomElement/ViewsElement.php`). It extends
`Drupal\cohesion_elements\CustomElementPluginBase` and is annotated:

```php
@CustomElement(
  id = "site_studio_views_element",
  label = @Translation("Drupal View")
)
```

`CustomElement` is a plugin type owned by **cohesion_elements** (Site Studio), not by this module. So
this module registers a plugin *instance* into Site Studio's element palette; it does not define a new
plugin type or manager.

## Dependency injection

`create()` calls the parent, then injects `entity_type.manager` into `$this->entityTypeManager`. That
service is the only dependency; there is no config, state, or request access.

## getFields() — the element settings form

Returns the fields Site Studio shows when the element is configured. There is exactly one:

| key | type | required | source of options |
|-----|------|----------|-------------------|
| `view_id` | `select` | TRUE | every View **block** display, keyed `view_id:display_id` |

How the options are built:

1. Load all `view` config entities: `$this->entityTypeManager->getStorage('view')->loadMultiple()`.
2. For each View, iterate `$view->get('display')`; keep only displays where
   `$display['display_plugin'] == 'block'`. Page, feed, attachment, embed and other display types are
   deliberately skipped, so only Block displays are embeddable.
3. Option key = `view_id . ':' . display_id`. Option label = the View label, the display title (unless
   it is the default "Block"), and the block description (`display_options.block_description`) joined
   with " - ", followed by ` (view_id:display_id)`.
4. `asort($displays, SORT_NATURAL)` sorts the list.

Consequence: to embed a listing, its View must have a **Block** display. A View with only page/feed
displays will not appear in the dropdown.

## render() — building the output

Signature: `render($element_settings, $element_markup, $element_class, $element_context = [])`.

1. If `$element_settings['view_id']` is empty, returns nothing (element renders empty).
2. Splits the stored value on `:` into `$view_id` and `$view_display`.
3. `$view = Views::getView($view_id)`; if it loads, `$view->setDisplay($view_display)`,
   `$view->execute()`, then `$results = $view->buildRenderable($view_display)`.
4. Returns a render array:

```php
[
  '#theme' => 'site_studio_views_element',
  '#template' => 'site-studio-views-element',
  '#elementSettings' => $element_settings,
  '#elementMarkup' => $results,      // the Views render array
  '#elementContext' => $element_context,
  '#elementClass' => $element_class,
]
```

Only `#elementMarkup` (the View) and `#elementClass` are actually printed by the template;
`#elementSettings` and `#elementContext` are passed but unused by the default template.

## Arguments / contextual filters

`buildRenderable($view_display)` is called with **no `$args`**. The element offers no field for
arguments and does not derive any from `$element_context` or the request. A display's contextual
filters therefore resolve only from their own configuration ("Provide default value" / "Display all
results"). Do not expect the element to feed arguments from the URL or the Site Studio context.

## Access control

Although `render()` calls `$view->execute()` directly (which by itself does not check access), the
output is rendered through core's `#type => 'view'` render element that `buildRenderable()` produces.
Its pre-render callback, `Drupal\views\Element\View::preRenderViewElement()`, wraps the build in
`if ($view && $view->access($element['#display_id'])) { ... }`. So the selected display's **access
plugin is enforced at render time** — an editor cannot use this element to bypass a View display's
access requirement; a viewer without access sees empty output. The stray `execute()` before
`buildRenderable()` is redundant work (the display is executed again during pre-render), not an access
hole.

## Editor gating

Configuring the element (and thus which View display it embeds) happens inside the Site Studio builder,
which is gated by Site Studio's own component/template editing permissions. There is no anonymous or
end-user-facing configuration surface in this module.

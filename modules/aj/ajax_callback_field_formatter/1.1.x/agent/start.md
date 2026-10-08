<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Callbacks Field Formatter (ajax_callback_field_formatter) — agent index

A single **field formatter** for core **Link** fields. It renders each link value as a `<span>`
carrying data attributes, and its bundled JS fires an AJAX request to the link's URL on page load,
executing whatever AJAX commands the response returns. You supply the controller/route; the module
supplies only the generic formatter + JS connector.

- **Type:** display formatter module. `package: Custom`, `core_version_requirement: ^9 || ^10 || ^11`.
- **Depends on:** core **`link`** module (the plugin extends `Drupal\link\...\LinkFormatter`).
  No `dependencies:` are declared in the `.info.yml`, but the formatter is inert without `link`.
- **Provides:** one FieldFormatter plugin, one theme hook, one JS library. No routes, permissions,
  services, config schema, `.install`, or Drush commands.

## What it ships

| Thing | Id / name | File |
|---|---|---|
| Field formatter plugin | `ajax_callback_field_formatter` (label "Ajax Callback Formatter"), `field_types = {"link"}` | `src/Plugin/Field/FieldFormatter/AjaxCallbackFieldFormatter.php` |
| Theme hook | `ajax_callback_field_formatter_template` (vars: `title_value`, `element_attributes_url`, `element_attributes_id`) | `ajax_callback_field_formatter.module` + `templates/ajax-callback-field-formatter-template.html.twig` |
| JS library | `ajax_callback_field_formatter/ajax_callback_field_formatter` (deps `core/drupal`, `core/drupal.ajax`, `core/once`) | `ajax_callback_field_formatter.libraries.yml` + `js/ajax_callback_field_formatter.js` |

## How it works (one line each)

1. `AjaxCallbackFieldFormatter::viewElements()` calls `parent::viewElements()` (LinkFormatter),
   then replaces each element with the `ajax_callback_field_formatter_template` theme, passing the
   link title, the resolved URL string, and an id `entity_type--entity_id--field_name--delta`.
2. The Twig template emits `<span data-execute-ajax-callback-field-formatter-url=…
   data-execute-ajax-callback-field-formatter-id=…>title</span>`.
3. `js/ajax_callback_field_formatter.js` (`Drupal.behaviors.ajax_callback_field_formatter`) selects
   those spans with `once`, builds a same-origin URL, appends a CSS-selector query param
   `ajax_callback_field_formatter_id`, and runs `Drupal.ajax({url}).execute()`.

## Solution docs

- [Formatter: rendering & operation](agent/fields/formatter.md) — enable on a field, the attributes
  emitted, the JS request flow, and the controller contract you must implement.

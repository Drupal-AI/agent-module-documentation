<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CustomElement plugin: WebformElement

`src/Plugin/CustomElement/WebformElement.php`. A Site Studio custom element that lets an editor
embed an existing Webform in a component. There is no config UI beyond the builder element itself.

## Install / enable
```
composer require drupal/site_studio_webform_element
drush en site_studio_webform_element -y
```
Requires `cohesion` (Acquia Site Studio) and `webform` already enabled. Then, in Site Studio:
create/edit a Component, add the **Webform** element to the Layout Canvas, pick a form.

## Definition
- Extends `Drupal\cohesion_elements\CustomElementPluginBase`, implements
  `RenderCallbackInterface` (so its static `build()` is a trusted lazy-builder callback), uses
  `StringTranslationTrait`.
- Annotation: `@CustomElement(id = "site_studio_webform_element", label = @Translation("Webform"))`.
- `create()` injects `entity_type.manager` into `$this->entityTypeManager`.

## Builder field — `getFields()`
Returns one field for the element config form:
```php
$webforms = entityTypeManager->getStorage('webform')->loadMultiple();  // all webforms
return [
  'webform_id' => ['title' => 'Webform', 'type' => 'select', 'options' => $forms],
];
```
`$forms` maps each Webform `id() => label()`. The select therefore lists **every** Webform on the
site (open or not); the stored value is a single Webform machine id in `webform_id`.

## Render path — `render()` → `build()`
`render($element_settings, $element_markup, $element_class)` returns a placeholder that defers the
form to a lazy builder, keeping the enclosing component cacheable:
```php
return [
  '#create_placeholder' => TRUE,
  '#lazy_builder' => [static::class . '::build', [$element_settings['webform_id']]],
];
```
The static callback places the form via core's Webform render element:
```php
public static function build(string $webform_id): array {
  return ['webform' => ['#type' => 'webform', '#webform' => Webform::load($webform_id)]];
}
```
`#type => 'webform'` is core Webform's own render element, so the placed form uses **Webform's**
fields, validation, handlers, confirmation, open/closed state and access — this module only records
which form to place. Changing the form's config does not touch the page; moving/removing the
component is the only page-side action.

## Operating notes
- The element stores just a form id; if that Webform is later deleted, `Webform::load()` returns
  null and the render element renders nothing.
- Because output is lazy-built, the form is excluded from the component's cached HTML and rendered
  per-request (this is the intended cacheability behaviour).
- Sibling module: same pattern as Site Studio Views Element, for Webform instead of a View.

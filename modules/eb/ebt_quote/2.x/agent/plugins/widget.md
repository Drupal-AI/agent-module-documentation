# The custom field widget: `ebt_settings_quote` (EbtSettingsQuoteWidget)

This is the module's **only PHP class** and its distinguishing surface. It is a **field widget plugin**
(not a new plugin *type*) for the `ebt_settings` field type, defined in
`src/Plugin/Field/FieldWidget/EbtSettingsQuoteWidget.php`.

```php
/**
 * @FieldWidget(
 *   id = "ebt_settings_quote",
 *   label = @Translation("EBT Quote settings"),
 *   field_types = { "ebt_settings" }
 * )
 */
class EbtSettingsQuoteWidget extends EbtSettingsDefaultWidget { … }
```

It **subclasses** `ebt_core`'s base widget `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`,
so it inherits the whole design-options form (box model, borders, colours, background image/video,
container width — see [../fields/structure.md](../fields/structure.md)) and adds **one thing on top**: a
predefined **quote style** selector.

## `formElement()` — adds the "Quote styles" group

Calls `parent::formElement(...)` first (the full design form), then adds:

- A `details` group `ebt_settings.quote_styles` (title "Quote styles", `#open: TRUE`).
- A `radios` element `ebt_settings.quote_styles.styles` with five fixed options and default from the
  stored value:
  - `persona` → "Persona"
  - `company` → "Company"
  - `persona_with_small_icon` → "Persona with small icon"
  - `with_square_image` → "Width square image"
  - `with_frame_and_background_image` → "With frame and background image"
  - `#default_value` = `$items[$delta]->ebt_settings['styles'] ?? 'persona'`

The element `#description` is built as static help HTML linking five example screenshots under the
module's own `images/help/` directory (path resolved via `extension.path.resolver`). The links are built
with `$this->t(':placeholder', …)` where the placeholders are module-relative file paths — no
request/user input reaches the markup, so the HTML help text is not an injection surface.

## `massageFormValues()` — flattens the stored value

```php
public function massageFormValues(array $values, array $form, FormStateInterface $form_state) {
  // Lift the chosen style out of the 'quote_styles' group into ebt_settings.styles.
  $values[0]['ebt_settings']['styles'] = $values[0]['ebt_settings']['quote_styles']['styles'];
  foreach ($values as &$value) {
    $value += ['ebt_settings' => []];
  }
  return $values;
}
```

Net effect: the selected radio value is persisted at
`field_ebt_settings[0]['ebt_settings']['styles']`. That value is always one of the five known option
keys (radios validate against `#options`). The templates read it back to (a) `attach_library` the
matching CSS component and (b) add the `ebt-quote-<style>` wrapper class — it is **never printed raw**;
in the class list it is escaped by `Attribute::addClass()` at render.

## How the style is consumed at render

`block--block-content--ebt-quote.html.twig` / `block--inline-block--ebt-quote.html.twig` read
`content.field_ebt_settings['#object'].field_ebt_settings.ebt_settings.styles` and branch with
`{% if … == 'persona' %}` … `{% elseif … %}`. See
[../configure/block-type.md](../configure/block-type.md) for the branch/library/class mapping and the
`{{ styles|raw }}` inline-CSS path (which comes from `ebt_core`, not from this widget).

## Notes for agents

- To offer these quote styles on a different `ebt_settings` field, assign widget `ebt_settings_quote`
  (see the code snippet in [../fields/structure.md](../fields/structure.md)).
- The widget has **no widget-level settings** (form display component `settings: {}`), so it needs no
  config schema; `ebt_core` owns the `ebt_settings` field-type schema.
- Design-option validation (numeric box values, hex colours) is inherited unchanged from
  `EbtSettingsDefaultWidget::validateBoxElement` / `validateColorElement`.

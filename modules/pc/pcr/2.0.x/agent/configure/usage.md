# Applying Pretty Checkbox Radio

No admin settings page. You enable it per field (form display) or per exposed filter (BEF).
There is nothing to save globally.

## As a field widget (`options_pretty`)

1. On a bundle's *Manage form display* (`/admin/structure/types/manage/<bundle>/form-display`),
   pick **Pretty Check boxes/radio buttons** as the widget for a field of type
   `boolean`, `list_string`, `list_integer`, `list_float`, or `entity_reference`.
2. Save. Clear cache if the styling does not appear (`drush cr`).

`PrettyOptionsWidget` extends core `OptionsButtonsWidget` and simply sets
`$element['#pretty_option'] = TRUE` on the produced element; it is `multiple_values = TRUE`.

## As a Views exposed filter (BEF)

In a View's exposed filter settings, when Better Exposed Filters is the exposed form, choose
one of these widgets for the filter:

- **Pretty Checkboxes/Radio Buttons** — plugin id `pretty_bef` (`PrettyCheckboxesRadios`,
  extends BEF `RadioButtons`). For multi-option filters.
- **Pretty Single On/Off Checkbox** — plugin id `pretty_single_bef` (`PrettySingleElement`,
  extends BEF `Single`). For a single boolean exposed filter.

Both call `parent::exposedFormAlter()` then set `#pretty_option = TRUE` on the exposed form
element identified by the filter's exposed/grouped identifier.

## What the flag does (mechanism)

`hook_element_info_alter()` appends `\Drupal\pcr\PrettyElement::process` to the render
elements `checkbox`, `radio`, `checkboxes`, `radios`. In `PrettyElement::process`, only
elements carrying `#pretty_option` are transformed (per option child for `checkboxes`/`radios`):

- `#theme` → `elements__pretty_options`
- `#title_display` → `hidden`
- attaches library `pcr/pretty_elements` (`css/pretty_elements.css`, a theme-level CSS file).

Rendering uses two Twig templates — `templates/elements--pretty-options.html.twig` and
`templates/form-element--pretty-element.html.twig` — plus
`hook_theme_suggestions_form_element_alter`, which adds the `form_element__pretty_element`
suggestion when the element's rendered children contain `pretty-element`. The label wraps the
visually hidden input so the whole button is clickable and accessible.

## To customize the look

Override `pcr/pretty_elements` (or the two templates) in your theme. There are no PHP hooks
or settings to change behavior — styling is entirely CSS/Twig.

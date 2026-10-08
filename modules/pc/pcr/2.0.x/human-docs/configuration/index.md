# Configuration

There is no admin settings page. You enable Pretty Checkbox Radio per field or per
exposed filter — nothing to save globally.

## As a field widget

Use this on a content edit form to turn a field's options into pretty buttons.

1. Go to the bundle's **Manage form display** — for a content type that is
   **Structure → Content types → (type) → Manage form display**
   (`/admin/structure/types/manage/<bundle>/form-display`).
2. Find a field of type **boolean**, **list (text)**, **list (integer)**, **list
   (float)**, or **entity reference**, and set its widget to **Pretty Check
   boxes/radio buttons**.
3. Save. If the styling doesn't appear, clear the cache (`drush cr`).

The widget behaves like core's standard options-buttons widget, so a single
boolean becomes a pretty on/off toggle, and a multi-value list becomes a row of
pretty checkbox buttons.

## As a Views exposed filter (Better Exposed Filters)

Use this to give a View's exposed filters the same button look.

1. Edit the View and open the **exposed form** settings, choosing **Better Exposed
   Filters** as the exposed form style.
2. In the BEF settings for a filter, pick one of the pretty widgets:
   - **Pretty Checkboxes/Radio Buttons** — for multi-option filters (radios or
     checkboxes).
   - **Pretty Single On/Off Checkbox** — for a single boolean exposed filter.
3. Save the View.

The exposed filter now renders as pretty buttons instead of the default inputs.

## Customizing the look

The appearance is entirely CSS. The module attaches a lightweight library
(`pcr/pretty_elements`) and two Twig templates
(`elements--pretty-options.html.twig` and `form-element--pretty-element.html.twig`)
only on the elements you have opted in. To restyle the buttons, override that
library or those templates in your own theme — there are no PHP hooks or settings
that change behavior.

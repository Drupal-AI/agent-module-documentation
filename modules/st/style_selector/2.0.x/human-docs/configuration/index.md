# Configuration

Setting up Style Selector happens in three places: the global settings page (where
you attach the CSS that styles your classes), the field's **Manage fields** screen
(where you define the allowed swatches), and the **Manage form display** /
**Manage display** screens (where you choose the widget and formatter).

## Global settings page

Go to **Configuration → User interface → Style Selector**
(`/admin/config/user-interface/style-selector`), which requires **Administer site
configuration**. Here you connect the actual CSS and register any global values.
Remember: the module ships no design CSS itself, so the classes you offer will
have no visual effect until a library here defines them.

- **Shared libraries** — CSS libraries loaded *both* in the admin widget *and* on
  the front end when the field is displayed. Use these for classes you want to
  look the same in the editor and on the live page.
- **Theme libraries** — libraries loaded *only* when a field is rendered with the
  CSS Class formatter on the front end. Use these for styles that belong to the
  public site but should not load in the admin UI.
- **Admin libraries** — libraries loaded *only* when the widget is shown in the
  admin UI, so swatches preview correctly in the edit form without leaking those
  styles onto the front end.
- **Extra CSS classes** — global class options offered to *every* Style list
  field, so you can register your design system's classes in one place.
- **Extra color classes** — the same idea for global color options.

Enter libraries one per line in the form `theme_or_module/library_name`. All input
is sanitised when saved. By default every list is empty.

## Add a field (Manage fields)

On a content type, media type, or other bundle, go to **Manage fields → Add
field** and pick:

- **Style list** (`style_selector_css_class`) — the stored value is a CSS class.
- **Color list** (`style_selector_css_color`) — the stored value is a color
  string (any supported format; hex is normalised to RGB/A).

Then define the field's **allowed values** — a list of value/label pairs, exactly
like a core List field. For a Style list the value is the CSS class; for a Color
list the value is the color. These become the swatches an editor can choose from.

## Widget settings (Manage form display)

On **Manage form display**, pick one of the two widgets and open its settings:

- **Tile widget** (`style_selector_tile_widget`) — large tile/thumbnail swatches.
- **Compact widget** (`style_selector_compact_widget`) — space-efficient radios
  (single value) or checkboxes (multiple).

Common options include:

- **Size** — swatch size (both widgets).
- **Type** — a style variant such as round or square (compact widget only).
- **Advanced settings**:
  - **Color property** — the CSS property previewed for color options.
  - **Extra classes** — extra classes added to the picker container.
  - **Empty option** — the label for the "None" choice (shown on non-required,
    single-value fields).
  - **UI toggles** — show/hide the alpha-channel grid behind translucent swatches,
    the "selected" check icon, the empty-option symbol, and the "T" text-color
    demo glyph.

## Formatter settings (Manage display)

On **Manage display**, choose how the selection is applied to rendered content:

- **CSS Class formatter** (`style_selector_css_class_formatter`) — merges the
  chosen class(es), plus any **extra classes** you configure, into the rendered
  entity's wrapper (`class` attribute).
- **CSS Color formatter** (`style_selector_css_color_formatter`) — writes an
  inline style on the entity wrapper as `<property>: <value> !important`. Set the
  **CSS property** to `color`, `background-color`, or whatever you need; only the
  first selected value is used. You can also add **extra classes**.

Because the class or inline style is applied to the entity *wrapper* (via an
entity-view alter), you can even hide the field itself on display and still get the
visual effect on the entity container. If you only need plain-text output, core's
**List (default)** and **List (key)** formatters also work on these fields.

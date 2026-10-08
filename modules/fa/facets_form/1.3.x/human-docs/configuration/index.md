# Configuration

Facets Form has no settings page. Setup is two steps: point each facet at a Facets Form
widget, then place and configure the "Facet form" block for that facets source.

## 1. Set each facet to a Facets Form widget

A facet only appears in the form if it uses one of Facets Form's widgets. For each facet you
want in the form:

1. Go to the **Facets** admin (**Configuration → Search and metadata → Facets**) and edit the
   facet.
2. Set its **Widget** to one of:
   - **Dropdown (inside form)** (`facets_form_dropdown`)
   - **Checkboxes (inside form)** (`facets_form_checkbox`)
   - (or a submodule widget: date range, extended date range, fulltext)
3. Configure the widget's options (below) and save the facet.

Any facet still using a core Facets widget (link list, etc.) is **not** eligible and won't
show in the form.

### Dropdown (inside form) options

- **Default option label** (`default_option_label`, default *Choose*) — the placeholder option
  shown for single-select facets.
- **Child items prefix** (`child_items_prefix`, one character, default `-`) — repeated once per
  nesting level to indent hierarchical (e.g. taxonomy) options.
- **Disabled on empty** (`disabled_on_empty`, default off) — when on, the dropdown stays
  visible but disabled when there are no results (rather than disappearing).

The widget renders a `<select>`, allowing multiple selections unless the facet is set to "show
only one result".

### Checkboxes (inside form) options

- **Disabled on empty** (`disabled_on_empty`, default off) — as above, keep the widget but
  disable it when there are no results.
- **Indent class** (`indent_class`, default `indented`) — the CSS class wrapped around each
  checkbox once per depth level, so hierarchical options are visually indented.

Both widgets also inherit the standard Facets options such as **show numbers** (the result
count next to each option).

## 2. Place and configure the block

The block is derived per facets source, so there is one per source.

1. Go to **Structure → Block layout** (or open Layout Builder on the relevant page).
2. Place the block **"Facet form: <source>"** (category *Facets*) into a region — usually a
   sidebar next to the search results.
3. In the block's settings:
   - **Limit to facets** — checkboxes listing the source's eligible facets. Tick a subset to
     show only those; leave all unticked to expose every eligible facet.
   - **Submit button** — the label for the apply/search button (required, e.g. *Search*).
   - **Reset button** — the label for the clear button (required, e.g. *Clear*).
4. Save the block.

The block automatically adds configuration dependencies on the facets it exposes.

## How submit and reset behave

- **Submit** turns the selected values into active filters and redirects to the filtered URL.
  If nothing is selected, it redirects to the current URL with the facet filters removed.
- **Reset/Clear** is a link (styled as a button) that returns to the current page with the
  facet filters stripped — while **preserving** other query parameters like paging and sort.

## Theming and extending

Each option label renders through a themeable `facets_form_item` template, with per-widget and
per-source template suggestions, so you can restyle option labels precisely. Developers can
also build their own in-form widget by implementing `FacetsFormWidgetInterface`, and opt the
form into a client-side "widget changed" JS event. Those are covered in the
[`agent/`](../../agent/start.md) docs (`theming/templates.md`, `plugins/widgets.md`,
`hooks/events.md`).

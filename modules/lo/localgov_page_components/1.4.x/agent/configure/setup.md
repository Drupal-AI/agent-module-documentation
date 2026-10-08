# Setup: field, Entity Browser, LinkIt

No global admin form. Setup is: attach the field, choose the Entity Browser widget, and
(optionally) wire LinkIt. All done through core UIs / config.

## The node field
`config/install/field.storage.node.localgov_page_components.yml` creates field storage
`node.localgov_page_components`:
- type `entity_reference`, `target_type: paragraphs_library_item`, `cardinality: -1`,
  `translatable: true`.
Add a *field instance* on any content type (Manage fields) to use it — the module only ships
the storage. LocalGovDrupal attaches it to `localgov_services_page`.

## Recommended widget: Entity Browser
`config/optional/entity_browser.browser.page_components.yml` defines browser `page_components`:
- `display: modal`, link text "Add/Select component".
- widget 1 `view` → view `paragraphs_library_browser` display `entity_browser` ("Available components").
- widget 2 `entity_form` → create a `paragraphs_library_item` inline ("Create component").

On the field's *Manage form display*, set the widget to **Entity browser** and select the
`page_components` browser. (Optional config: only installed if its `views.view.paragraphs_library_browser`
dependency is present.)

## Relabelling constants
`src/Constants.php` holds the strings/route ids used to present the Paragraphs library as
"Page component(s)" — e.g. `PAGE_COMPONENT_LABEL`, `PAGE_COMPONENT_LIST_LABEL`,
`PARAGRAPHS_LIB_ADD_ACTION` (`entity.paragraphs_library_item.add_form`),
`PARAGRAPHS_LIB_LISTING_ROUTE` (`entity.paragraphs_library_item.collection`),
`PAGE_COMPONENT_FIELD_NAME` (`localgov_page_components`).

## LinkIt integration (optional, needs localgov_paragraphs)
At `/admin/config/content/linkit`, edit a profile's matchers, **Add matcher → Page components**,
restrict to the *Link* and *Contact* paragraph bundles, enable *Group by bundle*, and set the
**Substitution Type** to *Page components*. See [../plugins/linkit.md](../plugins/linkit.md).

## Access
No permissions are defined here. Editing/viewing components is gated by Paragraphs library,
Entity Browser and node permissions from those modules.

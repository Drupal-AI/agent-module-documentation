# The `webform_entity_view` element

Class: `Drupal\webform_entity_view\Plugin\WebformElement\WebformEntityView` extends
`Drupal\webform\Plugin\WebformElement\WebformMarkupBase`.

## Add it

Structure → Webforms → (edit) → **Add element** → "Entity View" (under *Entity reference elements*).

## Configured properties (`defineDefaultProperties`)

| Property | Set via | Purpose |
|---|---|---|
| `target_type` | "Type of item to view" select (AJAX) | entity type id to display |
| `target_bundle` | "Bundle" select (AJAX, depends on type) | bundle to restrict the autocomplete to |
| `selected_entity` | "Entity" `entity_autocomplete` | the specific entity id to render |
| `view_mode` | "View mode" select | view mode passed to the view builder |
| `title`, `title_display` | inherited | element title handling |

The markup/`default` value and form-display sub-form are removed (`unset($form['markup'], $form['default'])`,
`$form['form']['#access'] = FALSE`) — this element renders content, it does not collect input.

## Render behavior (`prepare()`)

1. Loads the entity: `entityTypeManager->getStorage($target_type)->load($selected_entity)`.
2. If found, converts the element to a `container`, gets the entity's view builder, computes a langcode
   (submission langcode if the entity has that translation, else the entity's own language), and appends
   `$view_builder->view($entity, $view_mode, $langcode)`.
3. On any `\Exception`: logs via `Error::logException` (channel `webform_entity_view`) and sets `#access = FALSE`
   so nothing renders.

## Access caveat (document, not a vuln)

The rendered entity is chosen by the **form author** at build time; `prepare()` renders it through the view
builder without an explicit per-viewer entity access check. The view builder applies field/formatter rendering
but the element does not itself re-check that the current form viewer may view that specific entity. Treat the
element like an admin-placed block: only reference entities you intend everyone who can reach the form to see —
do not use it to embed unpublished or access-restricted entities into a publicly reachable webform. Configuring
the element requires webform-admin privileges (building/editing the webform).

No config schema ships, so element properties are stored in the webform's own YAML config (`webform.webform.*`).

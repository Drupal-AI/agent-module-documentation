<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget: Autocomplete (with create link)

Source: `src/Plugin/Field/FieldWidget/EntityReferenceAutocompleteCreateLink.php`.
Class `EntityReferenceAutocompleteCreateLink extends EntityReferenceAutocompleteWidget`.

## Plugin definition

```
@FieldWidget(
  id = "entity_reference_field_create_link",
  label = "Autocomplete (with create link)",
  description = "An autocomplete text field with a link to create a new entity.",
  field_types = { "entity_reference" }
)
```

Because it extends the core `EntityReferenceAutocompleteWidget`, it inherits all of that widget's
behaviour and settings (`match_operator`, `match_limit`, `size`, `placeholder`). The module defines
**no** `defaultSettings()`, `settingsForm()`, or `settingsSummary()` overrides and **ships no config
schema**, so there is nothing extra to configure and no new config object.

## Enable / operate

1. Enable the module (`drush en entity_reference_field_create_link`); its only dependency is core
   `field`.
2. Go to *Manage form display* for the bundle that owns the entity-reference field.
3. Set that field's widget to **"Autocomplete (with create link)"** and save.
4. On the entity edit form the field now renders the standard autocomplete input plus one create
   button per allowed target bundle.

## How the create links are built

- `create()` (static factory) injects `entity_type.manager` into `$instance->entityTypeManager`.
- `form(FieldItemListInterface $items, array &$form, FormStateInterface $form_state, $get_delta = NULL)`:
  - `$build = parent::form(...)` — renders the normal autocomplete element.
  - `$build['add_links'] = []`, then iterates `$this->getSelectionHandlerSetting('target_bundles')`.
  - `$entityTypeId = $this->getFieldSetting('target_type')`; `$linkKey = "$entityTypeId__$bundle"`.
  - A `switch ($entityTypeId)` maps type → add route and loads the bundle config entity:

    | target_type    | route                            | route param          | bundle storage       |
    |----------------|----------------------------------|----------------------|----------------------|
    | `node`         | `node.add`                       | `node_type`          | `node_type`          |
    | `taxonomy_term`| `entity.taxonomy_term.add_form`  | `taxonomy_vocabulary`| `taxonomy_vocabulary`|
    | `media`        | `entity.media.add_form`          | `media_type`         | `media_type`         |

  - Any other `target_type` matches no `case`, so **no create link is produced** (comment in source:
    "There is no universal way to get the add route for a given entity type").

- `getAddLink(string $routeName, string $routeParameterName, EntityInterface $bundleObject)`:
  returns `Link::createFromRoute($this->t('Create @name', ['@name' => $bundleObject->label()]),
  $routeName, [$routeParameterName => $bundleObject->id()], ['attributes' => ['class' => ['button',
  'button--action', 'button--small'], 'target' => '_blank']])->toRenderable()`.

## Behaviour notes

- One button per target bundle configured on the field (via the reference field's selection handler
  `target_bundles`). If the field allows all bundles / no explicit list, `getSelectionHandlerSetting('target_bundles')`
  may return null and the loop yields no buttons.
- Buttons open the add form in a **new tab** (`target => _blank`); the current edit form is preserved.
- The link points to the core add form and passes **no `destination`**; the newly created entity is
  not automatically placed in the field — the editor selects it via autocomplete after creating it.
- Access to actually create the entity is enforced by the target core add route
  (`_entity_create_access`), not by this module.
- Supported target types are limited to node, taxonomy_term, and media in this release.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, block and link pipeline

## Install / enable
`drush en createcontentwithcategory`. Requires the contrib **Prepopulate** module
(`prepopulate:prepopulate`, declared in `createcontentwithcategory.info.yml`) — the generated
links rely on Prepopulate to read the field value out of the URL query and seed the node-add form.

## Settings form
- Route `createcontentwithcategory.config` → `/admin/config/content/createcontentwithcategory`,
  form `Drupal\createcontentwithcategory\Form\CcwcSettings` (extends `ConfigFormBase`), permission
  **`administer taxonomy`** (`createcontentwithcategory.routing.yml`). Menu link under
  *Configuration → Content authoring* (`*.links.menu.yml`).
- `gatherNodeTypesWithTermReference()` walks every node type (`node_type_get_names()`) and its field
  definitions (`entity_field.manager`), collecting fields where `getType() === 'entity_reference'`
  and `getSettings()['target_type'] === 'taxonomy_term'`. Each such field is offered as a checkbox
  labelled `<field label> (<vocab machine names>)`, grouped by content type.
- `submitForm()` flattens the checked checkboxes to a simple list of enabled ids and saves them:
  config object **`createcontentwithcategory.settings`**, key **`target_nodes_fields`** = array of
  `content_type__field_name` strings (e.g. `event__field_event_type`). `isTargetNodeField($id)`
  checks membership for the default values. **No config schema** ships (`config/schema/` absent), so
  this config is untyped — a `hook_install`/default config file is likewise absent; the object is
  created on first save.

## Ccwc value object (`src/Ccwc.php`)
Constructed from an id string; `__construct()` splits on `__` and **throws** `\Exception` unless there
are exactly two parts → `content_type` and `field_name`. Methods:
- `getField()` → `FieldConfig::loadByName('node', content_type, field_name)`.
- `getTerms()` → for each vocabulary in the field's
  `getSettings()['handler_settings']['target_bundles']`, loads terms via
  `taxonomy_term` storage `loadByProperties(['vid' => …])`, merged (numeric keys preserved).
- `makeUrl($tid)` → `Url::fromRoute('node.add', ['node_type' => content_type], ['query' => [key => $tid]])`
  where `prepopulateQueryKey()` returns `edit[<field_name>][widget]` (the form-value path Prepopulate
  reads; the code notes this is the empirically-working key for select-list widgets, not the
  documented one).
- `build()` → assembles `#items` from `buildItems()` (each item: term name as `title`, `Attribute`,
  the node-add `url`) into a `#theme => 'menu__<id>'` render array with `#sorted = TRUE`. Item titles
  are term names rendered through the menu theme (escaped). A cache-tag TODO is commented out, so the
  block is **not** invalidated when vocabulary terms change.
- `label()`, `fieldLabel()`, `contentTypeLabel()`, `permission()` (returns the string
  `'create ' . content_type`) provide admin labels / the intended per-block permission.

## Block plugin + deriver
- `hook`-style `createcontentwithcategory_target_nodes_fields()` (`.module`) reads
  `createcontentwithcategory.settings:target_nodes_fields` and returns one `Ccwc` per id.
- `Plugin\Derivative\CreateContentWithCategoryBlock::getDerivativeDefinitions()` creates one block
  derivative per configured id, using `Ccwc::label()` as the admin label.
- `Plugin\Block\CreateContentWithCategoryBlock` (id `createcontentwithcategory_block`, deriver-backed):
  `build()` = `new Ccwc($this->getDerivativeId())->build()`.
- Place a derivative via *Block layout* (or Layout Builder). Each block renders the term links for
  its target; clicking a link lands on `node.add`, which enforces the standard `create <type>`
  permission — the block does not create content itself.

## Operate it
1. Enable this module and Prepopulate.
2. Add a taxonomy-term entity-reference field to a content type (if not present).
3. At `/admin/config/content/createcontentwithcategory` check the field(s) to expose and save.
4. Place the resulting "Create … content with category …" block(s) in a region.
5. Editors click a category link → node-add form opens with that term pre-selected.

Note: because block visibility keys off the intended `create <type>` permission (see
`Ccwc::permission()`), only users allowed to create the content type should be shown the block; keep
the target field's own field/entity access in mind when exposing links.

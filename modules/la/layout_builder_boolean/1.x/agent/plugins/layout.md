<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Boolean layout plugin + deriver

## Plugin and derivatives

One `@Layout` plugin, `layout_builder_boolean`
(`src/Plugin/Layout/LayoutBuilderBoolean.php`, extends `Drupal\Core\Layout\LayoutDefault`,
implements `ContainerFactoryPluginInterface`, marked `@internal`). Its annotation points at
template `layout--layout-builder-boolean`, library `layout_builder_boolean/layout_builder_boolean`,
and deriver `LayoutBuilderBooleanDeriver`.

The deriver (`src/Plugin/Derivative/LayoutBuilderBooleanDeriver.php`) generates **one derivative per
YAML-defined layout on the site**. It deliberately discovers layouts with its own
`YamlDiscovery('layouts', module_dirs + theme_dirs)` instead of calling
`LayoutPluginManager::getDefinitions()` — calling the manager from inside a layout deriver would
recurse infinitely (deriver.php:91-108). For each discovered layout it clones the base definition,
sets the label to `"<label> (Boolean)"`, copies icon map / category / provider, and rebuilds the
region list by duplicating every base region as both `true:<region>` and `false:<region>`
(deriver.php:78-83). It also adds an **optional** `entity` context.

Result: plugin ids of the form `layout_builder_boolean:<base_layout_id>`. Confirmed live on this
site: `layout_builder_boolean:layout_onecol`, `:layout_twocol_section`, `:layout_threecol_section`,
`:layout_fourcol_section`, `:layout_twocol`, `:layout_twocol_bricks`, `:layout_threecol_25_50_25`,
`:layout_threecol_33_34_33`, `:navigation_layout`. Because this can be a lot of extra layouts, pair
with Layout Builder Restrictions to keep the section chooser manageable.

The plugin wraps a fresh instance of the **base** layout (`baseLayoutInstance`, built in the
constructor from the derivative id via `plugin.manager.core.layout`) and delegates the config form
and submit to it, so a Boolean layout keeps whatever settings the base layout has.

## Configuration (settings on the section)

`buildConfigurationForm()` adds the base layout's form plus one required select, `switch_field`
(LayoutBuilderBoolean.php:92-104), whose options come from `getFieldOptions()`: all field
definitions for the display's entity type + bundle, minus a hardcoded exclude list of unsuitable
base fields (`changed`, `created`, `default_langcode`, `langcode`, `nid`, `revision_*`, `title`,
`type`, `uid`, `uuid`, `vid`), sorted alphabetically (LayoutBuilderBoolean.php:156-188). The display
is read from `route_match->getParameter('section_storage')->getContextValue('display')`.

Stored layout settings (config schema `layout_plugin.settings.layout_builder_boolean:*`, which
`type: layout_plugin.settings.[base_layout]` then adds):

- `switch_field` (string) — machine name of the entity field used as the on/off switch.
- `base_layout` (string) — the wrapped base layout id (set from the derivative id on submit).

`defaultConfiguration()` seeds `switch_field => ''` and `base_layout => $this->getDerivativeId()`.

## Build + render decision (which branch shows)

`build(array $regions)` (LayoutBuilderBoolean.php:119-126) does NOT choose a branch. It builds
**both**: `organizeRegions()` splits the incoming `true:*` / `false:*` regions back into two region
sets, then `$build['#true'] = baseLayoutInstance->build(true regions)` and
`$build['#false'] = baseLayoutInstance->build(false regions)`, plus `$build['#entity'] = getContextValue('entity')`.
Building a render array does not render it — it only assembles the arrays.

The branch is picked in `template_preprocess_layout__layout_builder_boolean()`
(`layout_builder_boolean.module:15-46`):

1. Copies `content['#true']` / `content['#false']` into `_true` / `_false`, then folds the actual
   region content (`content` keys prefixed `true:` / `false:`) into those two structures.
2. If the section attributes have **no** `data-layout-update-url` (i.e. a normal front-end render,
   not the Layout Builder edit UI), it reads the switch field on the entity:
   `$entity->hasField($field_name) && !$entity->get($field_name)->isEmpty() && <main property is truthy>`
   → sets `$variables['render'] = $_true`, otherwise `$variables['render'] = $_false`. The main
   property is resolved generically via
   `getFieldDefinition()->getFieldStorageDefinition()->getMainPropertyName()`, so it works for a real
   `boolean` field (`value`), a link field (`uri`), an image/reference (`target_id`), etc. — "true"
   means "populated and truthy", "false" means "empty, missing field, or falsy".
3. If `data-layout-update-url` **is** set (the section is being rendered inside the Layout Builder
   edit UI), it skips the decision and instead adds `help_text` so the editor sees a "Section
   conditioned on: <field>" heading and both region groups.

The template `templates/layout--layout-builder-boolean.html.twig` renders **only** `{{ render }}`
when it is set (`{% if render %}{{ render }}{% else %} … both branches … {% endif %}`). So on the
front end the non-selected branch's render array is never printed and is **absent from the HTML**
(the `{% else %}` two-column preview is only reached in the edit UI, where `render` is unset). The
module's functional test asserts exactly this with `elementTextNotContains` on the hidden branch.

Practical notes for operating it:

- It is a **display condition, not access control**. The decision depends solely on the displayed
  entity's own field and is identical for every viewer; do not use it to gate sensitive content.
- An unset/empty/missing switch field renders the **false** branch (fail-to-false). A bogus field
  name also renders false (covered by the test).
- Most useful on entity **view displays** with optional fields; less so for one-off overrides.

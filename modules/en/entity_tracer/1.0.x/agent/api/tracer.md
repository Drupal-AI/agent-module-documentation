<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracer service, trace form & Twig extension

## Route & permission

`entity_tracer.tracer` → **`/admin/config/development/entity-tracer`**, form
`Drupal\entity_tracer\Form\EntityTracer`, permission **`view entity tracer`**. Menu link
*Configuration → Development → Entity tracer*.

## The trace form — `Form/EntityTracer.php`

`final class EntityTracer extends FormBase`, form id `entity_tracer_entity_tracer`. Injects
`entity_tracer.tracer`, `config.factory`, `entity_type.manager` (`create()`). Attaches library
`entity_tracer/entity_tracer_form`.

Controls (`buildForm()`):

- **Entity Type** — `radios` from `getSelectedEntityTypes()` (labels of the config-enabled
  types). If none are enabled, shows a message linking to the settings route instead. AJAX
  callback `createBundleListAjax` refreshes the bundle list.
- **Bundle** — `select` from `Tracer::getBundles($entity_type)` with a leading "Select Bundle"
  entry. AJAX callback `calcTracerAjax`.
- **Direction** — `radios` `up` / `down`, default `down`. AJAX callback `calcTracerAjax`.

`calcTracerAjax()` returns an `AjaxResponse` that `ReplaceCommand`s `#entity-tracer-results` with
`buildTracerBlock()`. `calculateTracer()` reads the three values and, when all are present, calls
`Tracer::searchReferenceChain($entity_type, $bundle, $direction)` for `#results` and
`Tracer::getBundleLabel($entity_type, $bundle, TRUE)` for `#label`, rendered through theme hook
`entity_tracer_results`. Submit handlers just `setRebuild()` — the form performs **no writes**.

## The Tracer service — `Tracer.php`

Service `entity_tracer.tracer` = `Drupal\entity_tracer\Tracer`. Constructor args:
`entity_field.manager`, `entity_type.manager`, `config.factory`, `cache.data`,
`entity_type.bundle.info`, `router.route_provider`. Key methods:

- `referenceChainComplete()` — builds/returns the full chain for all `enabled_entity_types`.
  Caches it in `cache.data` under key `entity_tracer_chain_complete`, `Cache::PERMANENT`, with
  tags `config:entity_tracer.settings`, `entity_field_info`, and per enabled type
  `config:<bundle_entity_type>_list`.
- `getReferenceFields($entity_type, $bundle)` — returns only `FieldConfig` fields of type
  `entity_reference` or `entity_reference_revisions` (so base fields are ignored).
- `getRawReferenceChain($entity_type, $bundle, $max_depth)` — recurses over each reference
  field's `handler_settings['target_bundles']` and `target_type`, decrementing `max_depth`;
  stops descending when the target type is `node` (recorded as an `end_*` leaf) and returns `[]`
  at depth 0. Chain keys encode `field_machine__field_label` and `type__bundle`.
- `searchReferenceChain($entity_type, $bundle, $direction)` — `down` returns
  `$complete_chain["$type__$bundle"]`; `up` uses `recursiveArraySearch()` + `buildNestedArray()`
  to reconstruct the paths that lead **to** the selected bundle.
- `getBundleLabel($type, $bundle, $link)` — label `"<Bundle label> (<type>:<bundle>)"`; when
  `$link` and route `entity.<type>.field_ui_fields` exists, wraps it via `Link::fromTextAndUrl()`
  to that bundle's Field UI page.
- `getFieldLabel()` / `getBundles()` — human-readable field and bundle labels.

All data comes from field definitions and bundle info — **no content entities are loaded or
queried**, and no field values are read.

## Twig extension — `EntityLabelTwigExtension.php`

Service `entity_tracer.twig_extension` (tag `twig.extension`) adds the Twig function
`entity_tracer_label($label)`. It `explode('__')`s the encoded label: a `field_*` part becomes a
bolded `"<label> (<machine>)"` markup string; otherwise it delegates to
`Tracer::getBundleLabel(..., TRUE)` to emit the linked bundle label.

## Theme & rendering

Theme hook `entity_tracer_results` (`entity_tracer_theme()` in the `.module`) with variables
`results`, `label`, `direction`. `templates/entity-tracer-results.html.twig` iterates results and
calls `macros.twig`'s `recurseArray()` to render the nested tree; leaves keyed `end_*` render the
target label. All values are printed through Twig auto-escaping / core `Link`, and labels derive
from admin-defined field/bundle config. `hook_help()` documents the module on its help page.

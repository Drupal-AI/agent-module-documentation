<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapping imported values into Paragraphs

Grounded in `feeds_para_mapper.module` (`hook_feeds_targets_alter`), `src/Feeds/Target/WrapperTarget.php`
(`targets()`, `buildConfigurationForm()`, `getSummary()`), and `src/Mapper.php`.

There is **no admin/config page** (`configure = null`). All setup happens on a **Feeds Feed Type**
at `admin/structure/feeds/manage/{feed_type}/mapping`. This module only changes what targets that
mapping form offers and how their values are written.

## Prerequisites

- `feeds` (^3.0) and `paragraphs` enabled (both bring in `entity_reference_revisions`).
- A **Feed Type** whose processor creates an entity (e.g. `Node`) whose bundle has a **Paragraphs
  field** (an `entity_reference_revisions` field pointing at one or more paragraph bundles).
- Those paragraph bundles must contain fields whose field type has a Feeds target plugin
  (text, long text, link, email, number, date, boolean, file/image, …). A sub-field whose type
  has no Feeds target is silently skipped.

## What you see in the mapping UI

1. Go to **Structure → Feeds → (your feed type) → Mapping**.
2. Under **Add a target**, instead of one opaque `Paragraphs` target you now see **one target per
   supported leaf field** inside the referenced paragraph bundles. Each is labelled with its host
   path, e.g. `Body (field_sections)` or, for a nested paragraph, `Title (field_sections:field_cards)`.
   The label is built in `WrapperTarget::prepareTarget()` by joining the `host_field` chain from the
   field's computed `path`.
3. The **default `paragraphs` target is removed automatically** by `hook_feeds_targets_alter()`. The
   first time this happens on a feed type that still had the raw mapping, you get the warning
   *“Mapping has been updated, please refresh the page.”* — reload the mapping form once.
4. Map each source column to the paragraph leaf target you want, exactly like any other Feeds mapping.

Only paragraph bundles actually **allowed by the host field** are scanned
(`Mapper::getEnabledBundles()` reads the field's `handler_settings` `target_bundles` /
`target_bundles_drag_drop`), and the module recurses into nested Paragraphs fields to expose deep
leaf fields too (`Mapper::getSubFields()`).

## The “Maximum Values” per-mapping setting

Some paragraph targets show an extra **Maximum Values** textfield in their mapping settings
(`WrapperTarget::buildConfigurationForm()`). It appears **only when `has_settings` is true** — i.e.
when **both** the host Paragraphs field **and** the target leaf field are multi-valued
(cardinality unlimited or > 1), decided in `Mapper::getSubFields()`.

- Meaning (from the field description): *“When this field exceeds this number of values, a new
  paragraph entity will be created to hold the remaining values.”*
- At import, `Importer::sliceValues()` chunks the incoming values by this number
  (`array_chunk($values, $max)`); each chunk becomes one paragraph. `-1` / unlimited means one
  paragraph holds everything.
- `Mapper::getMaxValues()` validates the entered number against the field's storage cardinality and
  falls back to the field cardinality if the value is out of range.
- The mapping summary appends `Maximum values: N` beneath the wrapped plugin's own summary
  (`getSummary()`).

## Multiple values from one column

The module maps values it is handed; it does **not** itself split a delimited string. To turn a
single source cell like `a,b,c` into several paragraph values, add a **Feeds Tamper** “Explode”
plugin to that source before it reaches the mapping (see https://www.drupal.org/node/2287473).

## Behavior on import vs. update

- **New host entity:** `Importer` finds the not-yet-saved attached paragraphs (or creates the whole
  host chain of intermediate paragraphs via `createParents()`), then sets values through the
  wrapped leaf plugin.
- **Existing host entity (re-import/update):** values are compared (`checkValuesChanges()`);
  unchanged paragraphs are left alone, changed ones are updated, overflow creates new paragraphs by
  duplicating the last one, and — via `hook_entity_update` → `RevisionHandler` — updated paragraphs
  get a **new revision** and paragraphs no longer referenced are **removed** from the host field.
  The module never hard-deletes data mid-import; unused entities are pruned at the cleanup step.

## Verify targets are exposed

```bash
# List the mapping targets a feed type offers (paragraph leaf targets appear with :-joined labels).
ddev drush php:eval '$ft = \Drupal::entityTypeManager()->getStorage("feeds_feed_type")->load("YOUR_FEED_TYPE");
foreach ($ft->getMappingTargets() as $k => $t) { print $k . " => " . $t->getLabel() . "\n"; }'
```

If no paragraph sub-fields show up: confirm the processor's target bundle actually has an
`entity_reference_revisions` (Paragraphs) field, that the paragraph bundles hold Feeds-supported
fields, and that you reloaded the mapping form after the “please refresh” warning.

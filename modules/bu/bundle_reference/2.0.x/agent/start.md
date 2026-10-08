<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Reference (bundle_reference) — agent index

A field type that stores a reference to an **entity bundle** (an `entity_type` ID + `bundle`
machine name, e.g. `node:article`) instead of to an entity. Package `Field types`. Core-only,
**no dependencies, no routes, no permissions, no services, no hooks, no config schema, no Drush**.
Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0-beta1.

- **The field type, widget, formatter, settings, and how to operate them** →
  [fields/bundle_reference.md](fields/bundle_reference.md)

## What it actually is

Three plugins under `src/Plugin/Field/`, all targeting field type id `bundle_reference`:

- **FieldType** `BundleReferenceItem` (id `bundle_reference`, label *"Bundle reference"*, category
  *"Reference"*) — `FieldItemBase`. Two `varchar(255)` columns `entity_type` and `bundle`; two
  string properties; `default_widget = bundle_reference_widget`,
  `default_formatter = bundle_reference_formatter`. Field setting `referencable_bundles` (array of
  `entity_type:bundle` strings) whitelists selectable bundles. `isEmpty()` is true when `bundle`
  is empty.
- **FieldWidget** `BundleReferenceWidget` (id `bundle_reference_widget`) — two cascading `select`s:
  entity type, then its bundles (loaded via `ajaxCallback`). Only `ContentEntityTypeInterface`
  types are listed; both lists are filtered by `referencable_bundles` when set. Injects
  `entity_type.bundle.info` + `entity_type.manager`.
- **FieldFormatter** `BundleReferenceFormatter` (id `bundle_reference_formatter`) — renders each
  value as a `entity_type: bundle` line inside a `#theme => item_list` (empty text *"No referenced
  bundles."*).

## Mechanism (from source)

- The value is **just two machine names**. Nothing loads or renders a referenced entity, runs an
  entity query, or checks entity access — there is no target entity, only a bundle identifier.
- `BundleReferenceItem::getBundleOptions()` builds the settings-form checkbox options from
  `entity_type.bundle.info` `getAllBundleInfo()`, keeping only content entity types; each option
  is `"{EntityLabel}: {BundleLabel}"`.
- `fieldSettingsToConfigData()` drops unchecked (`empty`) whitelist entries before save.
- Widget entity-type options come from `entity_type.manager->getDefinitions()` filtered to content
  entity types; bundle options from `bundleInfo->getBundleInfo($entity_type)`; both further
  filtered to the `referencable_bundles` whitelist when it is non-empty.
- Formatter output is `$item->entity_type . ': ' . $item->bundle` placed in `item_list` `#items`,
  so it is escaped by the theme layer. Labels shown in the widget/settings selects are
  Form-API-escaped option text.

No `.install`, no `config/` directory, no `.services.yml`, no `.routing.yml`, no
`.permissions.yml`, no submodules.

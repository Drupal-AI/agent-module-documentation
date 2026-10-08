# The machine_name property & API

## The base field

`taxonomy_machine_name_entity_base_field_info()` defines a single field on `taxonomy_term`:

```php
$fields['machine_name'] = BaseFieldDefinition::create('string')
  ->setLabel('Machine name')
  ->setRevisionable(FALSE);
```

It is stored as a column on `taxonomy_term_field_data`. Read it with any of:

```php
$term->get('machine_name')->value;   // canonical
$term->machine_name->value;          // magic accessor
```

There is no separate `machine_name` per-vocabulary storage — it is one shared base field on
all term bundles.

## Automatic generation on save

`taxonomy_machine_name_taxonomy_term_presave()` runs on **every** term save:

1. If `machine_name` is empty, it seeds from the term **name**; otherwise it re-cleans the
   value already set.
2. `taxonomy_machine_name_clean_name($name)` produces the slug:
   - if the string is not already `^[a-z0-9_]+$` (or `$force` is TRUE): transliterate to
     ASCII for the current language, `mb_strtolower`, then replace every run of
     non-`[a-z0-9_]` characters with `_` and trim leading/trailing `_`.
   - otherwise it is returned unchanged.
3. `taxonomy_machine_name_uniquify(&$machine_name, $term)` checks the vocabulary for a clash
   (via `taxonomy_machine_name_term_load`) and, if found, appends `_0`, `_1`, `_2`, … (the
   base is truncated to keep the total ≤ 255 chars) until unique **within that vocabulary**.

So creating two Tags terms both named "Blue Sky" yields machine names `blue_sky` and
`blue_sky_0`. Setting `machine_name` explicitly to an already-valid slug keeps it verbatim
(only uniqueness suffixing may change it).

## Load a term by machine name

```php
$term = taxonomy_machine_name_term_load('blue_sky', 'tags'); // term or NULL, scoped to $vid
```

Internally it is `entityTypeManager->getStorage('taxonomy_term')->loadByProperties(['machine_name' => $m, 'vid' => $vid])`.
You can run that `loadByProperties` query yourself (machine_name is a real, queryable field):

```php
\Drupal::entityTypeManager()->getStorage('taxonomy_term')
  ->loadByProperties(['machine_name' => 'blue_sky', 'vid' => 'tags']);
```

## Backfilling existing terms

`taxonomy_machine_name_update_term($term)` fills the machine name only if it is empty, then
saves. The module runs it in bulk two ways: a batch on install
(`taxonomy_machine_name_install`) and a deploy hook
(`taxonomy_machine_name_deploy_update_existing_terms`) for `drush deploy:hook`. Both query
`entityQuery('taxonomy_term')->notExists('machine_name')` in chunks of 10.

## Token

`[term:machine_name]` — registered via `hook_token_info_alter()` /
`hook_tokens()`; resolves to `$term->machine_name->value`. Usable anywhere term tokens are,
e.g. a Pathauto term pattern.

## Migrate (Drupal 7)

`hook_migration_plugins_alter()` swaps any migration using source plugin `d7_taxonomy_term`
to `d7_taxonomy_machine_name_term` (class
`Drupal\taxonomy_machine_name\Plugin\migrate\source\d7\TaxonomyMachineNameTerm`). That source
exposes `term_machine_name` / `vocabulary_machine_name` source properties from the D7 DB so
existing slugs migrate across.

## Theming side effect

`taxonomy_machine_name_preprocess_html()` adds a body class `term--<machine_name>` (cleaned
CSS identifier) on the `entity.taxonomy_term.canonical` route, for targeting term pages in
CSS/Twig.

## Uninstall

`taxonomy_machine_name_uninstall()` sets the `machine_name` column to NULL for all rows in
`taxonomy_term_field_data` (the base field itself is removed as the module is uninstalled).

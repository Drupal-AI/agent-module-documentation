# UI, overview column, permission & Views integration

There is **no settings form and no `configure` route**. "Configuration" means the term form
element, the permission that reveals the overview column, and the Views handlers.

## Term add/edit form

`taxonomy_machine_name_form_taxonomy_term_form_alter()` injects a `#type => 'machine_name'`
element just after the Name field (only when the Name field is visible/not hidden). It uses
`taxonomy_machine_name_term_load` as its `exists` callback so the AJAX widget flags
duplicates live. A validate handler rejects the reserved words `add`, `list`, `delete`,
`update` (they collide with taxonomy route arguments).

To set a machine name in code instead of the form:

```php
$term->set('machine_name', 'my_slug');
$term->save(); // presave still sanitises + uniquifies the value
```

## Overview page column + permission

`taxonomy_machine_name_form_taxonomy_overview_terms_alter()` adds a **Machine name** column to
`/admin/structure/taxonomy/manage/<vid>/overview`, but only for users with the permission:

```
view machine name overview page   (taxonomy_machine_name.permissions.yml)
```

Grant it with `drush role:perm:add <role> 'view machine name overview page'`.

## Views: exposed/normal filter

`hook_views_data_alter()` sets the filter handler for
`taxonomy_term_field_data.machine_name` to `taxonomy_index_machine_name` (class
`TaxonomyIndexMachineName`, extends core `ManyToOne`). Add it to a view as the field
**"Machine name"** filter. Extra options mirror the core term filter: selection type
(Dropdown / Autocomplete), vocabulary limit, "Show hierarchy in dropdown". Config schema:
`views.filter.taxonomy_index_machine_name` (extends `views.filter.in_operator`).

## Views: contextual filter (argument) validator

`hook_views_plugins_argument_validator_alter()` registers argument validator
`taxonomy_term_machine_name` (title "Taxonomy term machine name", class `TermMachineName`,
extends core `Entity`). On a taxonomy-term contextual filter, choose **Validator: Taxonomy
term machine name** so the URL argument is a term **machine name** instead of a term ID.
Its option `transform` (default TRUE) converts dashes in the URL to underscores before
matching, and it can accept multiple names when the argument's "multiple" option is on.
Schema: `views.taxonomy_term_machine_name` (extends `views.argument_validator_entity`).

## Quick drush checks

```bash
# a term's machine name
drush php:eval '$t=\Drupal\taxonomy\Entity\Term::load(1); print $t->machine_name->value;'
# load by machine name within a vocabulary
drush php:eval 'print taxonomy_machine_name_term_load("blue_sky","tags")?->id();'
```

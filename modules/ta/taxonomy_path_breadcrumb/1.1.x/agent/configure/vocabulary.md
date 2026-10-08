<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure per-vocabulary breadcrumb builder

Configuration is per **vocabulary**, on the vocabulary edit form
(`/admin/structure/taxonomy/manage/<vocab>`, requires `administer taxonomy`). The module adds
a **"Breadcrumb builder settings"** group (via `hook_form_taxonomy_vocabulary_form_alter`)
with one select, **"Select Breadcrumb Service"**:

| Option value | Label | Effect on term pages of this vocabulary |
|---|---|---|
| `taxonomy_term.breadcrumb` | Default | Core taxonomy breadcrumb (term parent hierarchy). |
| `system.breadcrumb.default` | Path based, Drupal core | Core path/URL-alias based breadcrumb. |

The choice is saved as a vocabulary **third-party setting**:

```
taxonomy.vocabulary.<vocab>:
  third_party_settings:
    taxonomy_path_breadcrumb:
      taxonomy_path_breadcrumbs_builder: system.breadcrumb.default
```

(schema `taxonomy.vocabulary.*.third_party.taxonomy_path_breadcrumbs`).

## How it takes effect

`TermBreadcrumbBuilder` is registered with breadcrumb-builder priority **1003** (higher than
core's taxonomy builder), and `applies()` returns true only on the term canonical route. In
`build()` it loads the term's vocabulary, reads the third-party setting, and returns
`\Drupal::service(<setting>)->build($route_match)`. If the setting is unset it uses
`taxonomy_term.breadcrumb`, i.e. identical to core default — so an un-opted vocabulary behaves
exactly as before.

## Set it with Drush

```php
// drush php:eval — use path-based breadcrumbs for the 'tags' vocabulary
$v = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load('tags');
$v->setThirdPartySetting('taxonomy_path_breadcrumb', 'taxonomy_path_breadcrumbs_builder', 'system.breadcrumb.default');
$v->save();
```

Note: because `build()` calls `\Drupal::service()` on the stored string, only an admin with
`administer taxonomy` (or config import access) can set this value, and the form restricts it
to the two options above.

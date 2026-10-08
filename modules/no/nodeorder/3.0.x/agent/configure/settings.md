<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Node Order

## Settings config: `nodeorder.settings`

Admin form `nodeorder.admin` at `/admin/config/content/nodeorder` (permission *administer
nodeorder*). Keys (schema `nodeorder.settings`, defaults from `config/install`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `vocabularies` | sequence (map `vid => vid`) | `{}` | Which vocabularies are orderable |
| `show_links_on_node` | integer (radios 0/1/2) | `true`* | 0 = don't show ordering links, 1 = all categories, 2 = active category |
| `link_to_ordering_page` | boolean | `true` | Show an Order tab on term/nodeorder pages |
| `link_to_ordering_page_taxonomy_admin` | boolean | `true` | Show an Order tab on taxonomy admin pages |
| `override_taxonomy_page` | boolean | `true` | Replace the default term page with nodeorder's |
| `entity_list_limit` | integer | `50` | Max nodes per page on the ordering screen |

\* `show_links_on_node` is shipped as `true` in config/install but the admin form treats it as the
0/1/2 radio value; set it to an integer when writing config.

Read/write:

```bash
drush cget nodeorder.settings
drush cset nodeorder.settings entity_list_limit 25 -y
```

## Making a vocabulary orderable (the core switch)

A vocabulary is orderable **iff** its machine name is a truthy entry in
`nodeorder.settings.vocabularies` (stored as `vid => vid`). Two equivalent ways:

**UI (vocabulary form):** edit the vocabulary (`/admin/structure/taxonomy/manage/<vid>`), tick the
**Orderable** checkbox in the *Node Order* fieldset, Save. Toggling this runs a **batch** that
reweights (or resets) every existing term/node pair in that vocabulary
(`SwitchToOrderableBatch` / `SwitchToNonOrderableBatch`).

**UI (settings form):** on `/admin/config/content/nodeorder`, tick the vocabulary under
**Vocabularies** and Save.

**Programmatic:** use the config manager service so the value is written in the expected `vid => vid`
shape:

```php
\Drupal::service('nodeorder.config_manager')->updateOrderableValue('tags', TRUE);   // make 'tags' orderable
// or the whole map:
\Drupal::service('nodeorder.config_manager')->updateConfigValues(['vocabularies' => ['tags' => 'tags']]);
```

Check it: `\Drupal::service('nodeorder.manager')->vocabularyIsOrderable('tags')` returns TRUE.

## Ordering nodes (the per-term UI)

Once a vocabulary is orderable, each of its terms exposes route **`nodeorder.admin_order`** at
`/taxonomy/term/{tid}/order` (also an **Order** entity operation on the term). It renders a tabledrag
table of the term's nodes (`NodeOrderListBuilder`); drag rows and **Save** to write the new
per-node weight to `taxonomy_index.weight`. Requires permission *order nodes within categories* and
passes only when the term's vocabulary is orderable and the `weight` column exists.

## Views integration

`hook_views_data_alter` exposes `taxonomy_index.weight` as a **"Nodeorder"** field and sort. To make
a View honour the manual order, add the **Nodeorder** sort (ascending) to a View that joins
`taxonomy_index` (e.g. the *Taxonomy term* view).

## Storage note

Node positions are **not** config or a field — they live in the `weight` int column that
`nodeorder_install()` adds to core's `taxonomy_index` table (dropped by `nodeorder_uninstall()`).

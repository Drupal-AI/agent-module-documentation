# Configuration

Title length has **no admin UI and no configuration object**. Everything is
controlled by a variable in `settings.php` plus a Drush command that applies the
value to the database. This page explains both.

## Choosing the length

The default applied length is **500 characters**. To use a different value, add a
variable to your site's `settings.php`. The variable is named
`<entity_type>_title_length_chars`:

```php
// web/sites/default/settings.php
$settings['node_title_length_chars'] = 1000;          // node titles
$settings['taxonomy_term_title_length_chars'] = 512;  // taxonomy term names
```

- Set this **before** enabling the matching submodule, and the length is applied
  automatically when the submodule installs.
- If you set or change it **after** the submodule is already enabled, you must
  re‑apply it with Drush (below) — editing `settings.php` alone does not resize the
  column.

## Re‑applying a changed length

If you change the `settings.php` value later, re‑apply it to the database with the
module's Drush command:

```bash
drush title_length:update node
drush title_length:update taxonomy_term
```

The entity type argument must match an enabled submodule — `node` or
`taxonomy_term`. The command widens (or narrows) the title column and its revision
column to the current length, then keeps the field definition in sync.

There is **no command to set** the length — the number always comes from
`settings.php` (or the 500 default). The command only applies whatever that value
currently is.

## Safety: you cannot shrink below existing data

If you lower the length, the module first checks whether any existing title or
revision is already longer than the new target. If so, the operation is refused —
the Drush command aborts, and uninstalling the submodule is blocked — so you never
silently truncate data. Shorten or clean up the offending titles first, then lower
the limit.

## Where the length actually lives

The length is stored in the **database schema**, not in Drupal configuration.
Enabling a submodule (or running the update command) resizes the entity's title
column directly and updates the base‑field definition to match. That is why there
is nothing to export as config and nothing to see on an admin form.

# Permissions

Defined in `taxonomy_class.permissions.yml`.

| Permission | Machine name | Grants |
|------------|--------------|--------|
| Administer taxonomy classes | `administer taxonomy classes` | See and edit the "Taxonomy Class settings" group (the `taxonomy_class` field) on the taxonomy term add/edit form. |

- This is the only permission the module declares.
- `taxonomy_class_form_taxonomy_term_form_alter()` checks it with
  `\Drupal::currentUser()->hasPermission('administer taxonomy classes')`; users without it never
  see the field on the term form (the alter returns early).
- The permission does NOT restrict who can *view* the rendered class — output happens for anyone who
  can view the term. It only gates editing the field.

Grant via drush:

```bash
drush role:perm:add editor 'administer taxonomy classes'
```

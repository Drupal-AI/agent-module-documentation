# Taxonomy Multi-delete Terms — permission

One permission, defined in `taxonomy_multidelete_terms.permissions.yml`:

- **`access taxonomy multidelete terms`** — "Users can delete multiple taxonomy terms at the same
  time." Holders get the bulk checkboxes + Delete button on the vocabulary term overview page and
  access to the confirm/delete route (`taxonomy_multidelete_terms.delete`).

The form alter returns early for users without this permission, so the bulk UI simply does not
appear for them. Note the permission only exposes the module's bulk UI — the actual term deletion
still uses core taxonomy term deletion under the hood.

```bash
drush role:perm:add editor 'access taxonomy multidelete terms'
```

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter a View by URL alias, and rebuild the index

The module has **no settings form and no `configure` route**. You "configure" it entirely
inside the Views UI, plus a one-off Rebuild form when the index drifts.

## Add alias filtering to a View

1. Open/create a content-entity View (e.g. a View of Content/nodes).
2. **Advanced → Relationships → Add** → choose **"{Entity Label} URL Alias"** (e.g.
   *Content URL Alias*). Optionally tick **Require this relationship**. This joins the
   entity's data table to `views_url_alias` on the entity id (with a langcode match and an
   `entity_type` = this type constraint).
3. **Filter criteria → Add → URL Alias** (from the *Alias* group). Configure it like any
   string filter (contains / starts with / equals). Point it at the relationship if asked.
4. Optionally add **Sort criteria → URL Alias**, or add the **URL Alias** field as a
   sortable column.

Typical use: a "starts with `section/`" filter to scope a listing to one path branch, often
paired with Views Bulk Operations to act on everything under that branch.

The Views data added:
- Base table `views_url_alias`, group **Alias**, field `alias` (title "URL alias",
  click-sortable, string filter, string sort).
- A relationship on **every** content entity type's data table:
  `<data_table>.views_url_alias` labelled "{Label} URL Alias", base field `entity_id`,
  extra conditions `entity_type = <type>` and a langcode join.

## Rebuild the index table

When aliases change without the entity hooks firing (direct DB import, migration) or right
after install, the mapping table drifts. The module flags this (state
`views_url_alias.needs_rebuild`) and shows a warning to users with `administer views`.

- UI: go to `/admin/config/search/views-url-alias` (menu: *Configuration → Search and
  metadata → Rebuild views alias table*), confirm **Rebuild table**. This truncates
  `views_url_alias` and repopulates it via a batch over all `path_alias` rows, then clears
  the needs-rebuild flag.
- Route name: `views_url_alias.views_url_alias_admin_form` (permission `administer views`).

Read/clear the flag directly:

```bash
drush state:get views_url_alias.needs_rebuild        # TRUE when a rebuild is pending
drush state:delete views_url_alias.needs_rebuild     # clear it manually
```

Inspect the table:

```bash
drush sqlq "SELECT entity_type, entity_id, langcode, alias FROM views_url_alias LIMIT 20"
```

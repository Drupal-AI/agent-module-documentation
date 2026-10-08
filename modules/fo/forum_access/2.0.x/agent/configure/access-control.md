<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure per-forum access

Forum Access has **no dedicated settings page**. `configure` in the info file points at
`forum.overview` (Admin > Structure > Forums). Editing or adding any forum or container gets
an **Access control** details section injected by
`forum_access_form_taxonomy_term_forums_forum_form_alter()` (forums) and
`forum_access_form_taxonomy_term_forums_container_form_alter()` (containers), both in
`forum_access.module`.

Access to that form is inherited from core Forum: it requires the core **`administer forums`**
permission. The form's own "Permissions information" panel spells out how the per-forum grants
combine with core permissions.

## The grid (roles × grants)

Built by `_forum_access_forum_grants_form()` / `_forum_access_container_grants_form()`
(`includes/forum_access.admin.inc`), rendered via theme hook `forum_access_table`. One
checkbox row per role, columns:

| Grant (column) | DB column     | Forum meaning                | Container meaning                         |
|----------------|---------------|------------------------------|-------------------------------------------|
| View           | `grant_view`  | View this forum & its topics | View this container                       |
| Post / Create  | `grant_create`| Post (create topics/replies) | Show container in the forum selection list |
| Edit           | `grant_update`| Edit posts in this forum     | (forums only)                             |
| Delete         | `grant_delete`| Delete posts in this forum   | (forums only)                             |

Roles holding `administer forums` or `bypass node access` are shown **disabled** (their
checkboxes are locked) because those permissions already imply full access.

**Moderators** (per-forum admin users) are added in the same section via ACL's
`acl_edit_form()` (`name='moderate'`, `figure=tid`). Moderators receive all four grants on
that forum and can see unpublished posts/comments.

**Update choice** (forums, when the term has topics): radios `all_now` (rebuild all node
access immediately, `node_access_rebuild(TRUE)`) or `all_later` (set the "needs rebuild" flag
— you must then run *Rebuild permissions*). A "Update even if unchanged" checkbox forces a
rewrite.

## Storage

Per-role grants are **not** config — they live in the custom table `{forum_access}`
(`tid, rid, grant_view, grant_update, grant_delete, grant_create, priority`, PK `(tid, rid)`,
schema in `forum_access.install`). Submitting the form calls
`_forum_access_form_roles_permissions_save()` → `forum_access_set_settings($tid, $access)`,
which deletes and re-inserts all rows for that `tid`.

The only *config* object is `forum_access.settings`:

```yaml
# config/install/forum_access.settings.yml
forum_access_roles_gids: []   # runtime map: role machine name (rid) => integer gid
```

Schema (`config/schema/forum_access.schema.yml`): `forum_access.settings` is a
`config_object` whose `forum_access_roles_gids` is a `sequence` of `integer`. It is populated
automatically (install + role insert/delete hooks); you normally never edit it by hand.

## Setting grants programmatically

`forum_access_set_settings()` expects arrays keyed by grant type, each a `rid => flag` map
(exactly the shape the checkbox table produces):

```php
$tid = 5; // forum term id
$settings = [
  'view'   => ['anonymous' => 0, 'authenticated' => 1, 'staff' => 1],
  'create' => ['authenticated' => 1, 'staff' => 1],
  'update' => ['staff' => 1],
  'delete' => ['staff' => 1],
];
forum_access_set_settings($tid, $settings); // writes {forum_access} rows for $tid

// Re-apply to existing topics so node_access reflects the change:
node_access_rebuild(TRUE);
```

Read current settings back with `forum_access_get_settings($tid)` (returns arrays of `rid`s
per grant, plus `priority`). To grant a role on **all** forums, loop over the forum terms.

## Defaults on install

`forum_access_install()` seeds every existing forum term with public defaults —
`anonymous`: view=1, create=0; `authenticated`: view=1, create=1 — so forums stay public
until you restrict them. It also builds the initial `forum_access_roles_gids` map and sets the
module weight to 2 (loads after `forum`). Deleting a forum term or a role cleans up the
matching `{forum_access}` / `node_access` rows automatically.

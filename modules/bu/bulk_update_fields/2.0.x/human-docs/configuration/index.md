# Configuration

Bulk Update Fields has one configuration screen: the **exclude form**, where you
choose fields that should never be offered for bulk editing. Everything else about
the module happens on the Content listing (see the [main page](../index.md)).

## The exclude list

Go to **Configuration → User interface → Bulk update exclude fields**
(`/admin/bulk_update_fields/exclude`). The form lists the fields you might want to
protect — core base fields such as `title`, `status`, author, and the created and
changed timestamps are already filtered out of the choices, since they should
never be mass‑edited.

Tick any field you want to keep off the bulk‑update picker and save. From then on,
that field won't appear in **Step 1** of the bulk‑update form, so it can't be
accidentally overwritten across many entities. This is the place to protect a
sensitive reference field, a legal/body field, or anything else where a mass edit
would be dangerous.

The choices on this form are built from **node** fields, but the saved exclude list
is applied to the bulk‑update picker generally.

## Permissions

The module defines two permissions, both flagged as security‑sensitive on the
permissions page:

- **Administer bulk_update_fields** (`administer bulk_update_fields`) — lets a role
  run the bulk‑update action and reach the multi‑step update form. Grant this to
  the trusted staff who should be able to mass‑edit content.
- An intended permission for the exclude form.

Grant the working permission at **People → Permissions**, or with Drush:

```bash
drush role:perm:add editor 'administer bulk_update_fields'
```

### A note about the exclude‑form permission

In the shipped 2.0.x code there is a genuine bug: the permission that guards the
exclude form is spelled inconsistently between where it is *defined* and where it
is *required*. Because the two names don't match, the exclude‑form permission
cannot be granted to any role through the UI, and in practice only user 1 (the
superuser, who bypasses all access checks) can open
`/admin/bulk_update_fields/exclude`. If you need other roles to manage the exclude
list, you'll need to patch the typo in the module's `permissions.yml`, or set the
exclude list directly in configuration. This is a limitation of the module itself,
not of your setup.

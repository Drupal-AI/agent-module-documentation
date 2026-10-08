<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL glossaries permissions

Defined in `tmgmt_deepl_glossary.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer deepl_glossary entities` | Full admin: the overview View, the fetch form (`/admin/tmgmt/deepl_glossaries/fetch`), and all glossary management. This is the entity `admin_permission`. |
| `add deepl_glossary entities` | Creating glossary entities. |
| `edit deepl_glossary entities` | Editing glossary entities. |
| `delete deepl_glossary entities` | Deleting glossary entities. |
| `edit deepl_glossary glossary entries` | Editing the term entries within a glossary. |
| `access deepl_glossary overview` | Viewing the glossary overview. |

Grant example:

```bash
drush role:perm:add editor 'access deepl_glossary overview'
drush role:perm:add editor 'edit deepl_glossary glossary entries'
```

The `deepl_glossary` entity uses `AccessControlHandler` with these permissions; the
`administer deepl_glossary entities` permission is the entity type's `admin_permission`.

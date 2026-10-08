<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL glossaries permissions

Defined in `tmgmt_deepl_glossary.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer deepl_glossary entities` | Both glossary entities' `admin_permission`; the fetch form (`/admin/tmgmt/deepl_glossaries/fetch`). |
| `add deepl_glossary entities` | Creating glossary/dictionary entities (`checkCreateAccess`). |
| `edit deepl_glossary entities` | `update` access to glossary entities (OR'd with the entries permission). |
| `delete deepl_glossary entities` | `delete` access to glossary entities. |
| `edit deepl_glossary glossary entries` | `update` access to entities; CSV upload and CSV download routes. |
| `access deepl_glossary overview` | `view` access to glossary entities (the overview Views). |

## Access control (`AccessControlHandler`)

`checkAccess()` maps operations to permissions:

- `view` → `access deepl_glossary overview`
- `update` → `edit deepl_glossary entities` **OR** `edit deepl_glossary glossary entries`
- `delete` → `delete deepl_glossary entities`
- `create` → `add deepl_glossary entities`

Both `deepl_ml_glossary` and `deepl_ml_glossary_dictionary` use this handler, and both declare
`administer deepl_glossary entities` as their `admin_permission` (which grants all operations). The
CSV upload/download routes are gated by `edit deepl_glossary glossary entries`; the fetch form by
`administer deepl_glossary entities`.

Grant example:

```bash
drush role:perm:add editor 'access deepl_glossary overview'
drush role:perm:add editor 'edit deepl_glossary glossary entries'
```

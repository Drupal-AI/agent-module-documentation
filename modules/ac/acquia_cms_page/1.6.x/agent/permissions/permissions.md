<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `acquia_cms_page.permissions.yml`. All five are standard per-bundle node permissions with
`provider: node` (i.e. they behave exactly like node's built-in content permissions for the `page`
bundle).

| Permission | Title | Notes |
|---|---|---|
| `create page content` | Page: Create new content | |
| `edit own page content` | Page: Edit own content | Anonymous users with this can edit any anon-created content (per the yml description). |
| `delete own page content` | Page: Delete own content | Same anon caveat as above. |
| `edit any page content` | Page: Edit any content | |
| `delete any page content` | Page: Delete any content | |

## Automatic role grants

The module wires these permissions into Acquia CMS's editorial roles through
`acquia_cms_page_content_model_role_presave_alter()` (in `.install`), which reacts to the
`hook_content_model_role_presave_alter` invoked by `acquia_cms_common` when its roles are (re)saved:

- **`content_author`** → `create page content`, `edit own page content`, `delete own page content`.
- **`content_editor`** → `edit any page content`, `delete any page content`.

So on an Acquia CMS site you normally do not grant these by hand — enabling the module and having the
`acquia_cms_common` roles present is enough. On a non-Acquia site (no `content_author`/`content_editor`
roles), assign the permissions to your own roles via the People → Permissions UI or:

```bash
drush role:perm:add content_author 'create page content'
```

# Permissions

`acquia_cms_document.permissions.yml` statically declares the five per-bundle media permissions for the
`document` bundle, each attributed to the core Media module via `provider: media`:

| Permission | Title | Provider |
|---|---|---|
| `create document media` | Document: Create new media | media |
| `edit own document media` | Document: Edit own media | media |
| `delete own document media` | Document: Delete own media | media |
| `edit any document media` | Document: Edit any media | media |
| `delete any document media` | Document: Delete any media | media |

These are the standard per-bundle permission strings that core Media enforces for creating/editing/
deleting `document` media entities. Declaring them here (rather than relying only on Media's dynamic
per-bundle permission generation) keeps them stable and grouped under Media on the permissions page.

They are granted to the Acquia CMS roles automatically — see [hooks/roles.md](../hooks/roles.md) — but
you can assign them to any role at `admin/people/permissions` or with
`drush role:perm:add <role> 'create document media'`.

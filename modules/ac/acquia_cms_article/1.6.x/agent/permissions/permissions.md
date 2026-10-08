# Permissions

`acquia_cms_article.permissions.yml` statically declares the standard node-CRUD permissions for the
`article` bundle. They are declared here (rather than left to the node module's per-bundle
auto-generation) so they exist even when the Article content type is provided as optional config. Each
is tagged `provider: node`, so they appear under **Node** on `/admin/people/permissions`.

| Permission string | Title | Notes |
|-------------------|-------|-------|
| `create article content` | Article: Create new content | |
| `edit own article content` | Article: Edit own content | Anonymous holders can edit any anonymous-authored article |
| `delete own article content` | Article: Delete own content | Anonymous holders can delete any anonymous-authored article |
| `edit any article content` | Article: Edit any content | |
| `delete any article content` | Article: Delete any content | |

These are enforced by Drupal core's node access system in the usual way — this module does not add any
custom access handler.

## How roles receive them

The module implements `acquia_cms_article_content_model_role_presave_alter()` (in
`acquia_cms_article.install`), an alter hook invoked by `acquia_cms_common` while it builds the
distribution's editorial roles:

- **`content_author`** is granted `create article content`, `edit own article content`,
  `delete own article content`.
- **`content_editor`** is granted `edit any article content`, `delete any article content`.

So on an Acquia CMS site these permissions are wired to the standard roles automatically. On a
non-Acquia-CMS site (no `content_author`/`content_editor` roles being built) you assign them manually.
See [../hooks/integration.md](../hooks/integration.md) for the alter-hook mechanics.

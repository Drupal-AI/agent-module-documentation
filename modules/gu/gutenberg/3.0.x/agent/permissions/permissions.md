# Gutenberg permissions (`gutenberg.permissions.yml`)

| Permission | Gates |
|---|---|
| `use gutenberg` | Access to any Gutenberg action — the editor UI and all `/editor/*` controller routes (media upload/load/edit/render, blocks, reusable blocks, patterns, oEmbed, search). Most routes require this. |
| `manage blocks lock` | Ability to manage block locking in the Gutenberg editor. |
| `create and edit custom gutenberg content blocks` | Ability to create/edit custom **non-reusable** Drupal content blocks inside the editor. |

Notes:

- The `/editor/*` routes additionally require `_format: json` and, for mutating (POST/PUT/DELETE)
  routes, a CSRF header token; the media upload route also checks `_entity_access: editor.use`.
- There is no "administer" permission and no settings page; enabling Gutenberg for a content type
  is done on the content-type form (see [configure/enable.md](../configure/enable.md)) and requires
  the usual *administer content types* permission, not a Gutenberg-specific one.
- Grant `use gutenberg` to any role whose users should author content with the block editor.

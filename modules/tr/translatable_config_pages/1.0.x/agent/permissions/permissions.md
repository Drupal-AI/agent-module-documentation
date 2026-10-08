# Permissions & access

Defined in `translatable_config_pages.permissions.yml`:

| Permission | `restrict access` | Grants |
| --- | --- | --- |
| `administer translatable config pages types` | **true** | Full admin of both entity types (it is the `admin_permission` on the type config entity *and* on the content entity). Define/edit/delete types and their fields; implicitly all operations on the values entities. |
| `manage translatable config pages` | — | Create and edit config-page values entities. |
| `view translatable config pages` | — | View config-page values entities (also needed to reach the *add translation* flow). |

## Access handler

`TranslatableConfigPagesAccessControlHandler` (on the content entity) after core's
`admin_permission` short-circuit:

| Operation | Requirement |
| --- | --- |
| `view` | `view translatable config pages` |
| `update` | `manage translatable config pages` **OR** `administer translatable config pages` |
| create | `manage translatable config pages` **OR** `administer translatable config pages` |
| delete / other | neutral (falls through to `admin_permission`) |

Because the entity's `admin_permission` is `administer translatable config pages types`, that
permission alone grants every operation (including delete) via core's pre-check.

Note: the handler's `update`/create branch also lists `administer translatable config pages`
(without the trailing "types"), which is **not** a declared permission — it can never be granted, so
in practice `update`/create are gated by `manage translatable config pages` (or the admin
permission). Harmless, fail-closed.

## Practical role split

- Site builders/admins → `administer translatable config pages types` (define structure).
- Editors/translators → `manage translatable config pages` (+ `view translatable config pages`) to
  maintain and translate values without being able to change the field structure.

## Rendering / escaping

Values are stored as ordinary entity fields and rendered through core field formatters (the only
module template, `translatable-config-pages.html.twig`, prints an auto-escaped `{{ bundle }}` and is
not registered via any `hook_theme`). The module emits no `|raw` / `#markup` field output, so
stored values are escaped by the normal render pipeline; any HTML in a formatted-text field is
governed by that field's text format as usual.

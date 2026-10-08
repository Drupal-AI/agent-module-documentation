<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Texts — permissions & access

Defined in `texts.permissions.yml`; enforced by `TextsAccessControlHandler` and the route requirements.

| Permission | Gates |
| --- | --- |
| `access string translation overview` | The `texts` entity `admin_permission`. Grants the collection `/admin/content/texts`, the locale-style overview, and the `entity.texts.restore_duplicate` route. |
| `create string translation` | Creating a `texts` entity (`checkCreateAccess`); also satisfied by `administer string translation`. |
| `edit string translation` | `update` on a `texts` entity; also satisfied by `administer string translation`. |
| `delete string translation` | `delete` on a `texts` entity; also satisfied by `administer string translation`. |
| `view string translation` | `view` on a `texts` entity. |
| `administer texts configuration` | **`restrict access: true`.** Settings form `/admin/config/regional/texts`, CSV export `/admin/config/regional/texts/export`, CSV import `/admin/config/regional/texts/import`. |

Notes:

- `TextsAccessControlHandler::checkAccess()` accepts either the specific verb permission **or** `administer string translation` (a permission the module references but does not itself declare — it would come from core/another module).
- The CRUD permissions (`create/edit/view/delete string translation`) are **not** marked restricted, so they are appropriate for content-editor roles; only `administer texts configuration` is restricted.
- The overview edit form (`TranslationEditForm`) runs `locale_string_is_safe()` on submitted translation values; the single-entity add/edit form (`TextsForm`) does not.
- The `texts_graphql` submodule adds no Drupal permissions of its own — access to its Query fields is whatever the configured GraphQL server grants.

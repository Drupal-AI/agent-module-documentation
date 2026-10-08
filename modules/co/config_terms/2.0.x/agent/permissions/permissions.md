# Permissions

Declared in `config_terms.permissions.yml`, one static permission plus a dynamic callback.

## Static

| Permission | Grants |
|---|---|
| `administer config terms` | Full control: manage vocabularies and all terms; it is the vocab entity `admin_permission` and short-circuits the term access handler. Treat as a trusted/admin-only permission (restrict access). |

## Dynamic (per vocabulary)

`permission_callbacks:` → `Drupal\config_terms\ConfigTermsPermissions::permissions`. For every existing
`config_terms_vocab`, two permissions are generated:

| Permission (pattern) | Grants |
|---|---|
| `edit terms in <vid>` | Edit (update) terms in that vocabulary |
| `delete terms in <vid>` | Delete terms from that vocabulary |

`<vid>` is the vocabulary machine name, so the list grows/shrinks as vocabularies are added/removed.
After creating a vocabulary, rebuild permissions/cache for its two rows to appear on
`/admin/people/permissions`.

## How access is enforced

`TermAccessControlHandler::checkAccess()`:
- Anyone with `administer config terms` is allowed for every operation (checked first).
- `view` → requires `access content` (used only by reference/entity-query access tagging; terms have
  no canonical view route).
- `update` → requires `edit terms in <vid>` for the term's own `vid`.
- `delete` → requires `delete terms in <vid>` for the term's own `vid`.
- otherwise neutral.

`TermAccessControlHandler::checkCreateAccess()` requires `administer config terms` — so **creating**
terms (and vocabularies) is admin-only; the per-vocab permissions only cover edit/delete of existing
terms. The `vid` on the term edit form is a fixed value from the loaded term, so an `edit terms in X`
holder cannot move a term into another vocabulary.

Vocabulary entities use the default access handler against their `admin_permission`
(`administer config terms`), so all vocab add/edit/delete/reset/overview operations require that permission.

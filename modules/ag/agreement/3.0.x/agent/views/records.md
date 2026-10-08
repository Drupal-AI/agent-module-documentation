# Acceptance records & Views

Acceptances for authenticated users live in the `{agreement}` database table
(`agreement.install`):

| Column | Type | Meaning |
|---|---|---|
| `id` | serial | PK. |
| `type` | varchar(100) | Agreement machine name (`Agreement::id()`). |
| `uid` | int | Accepting user id. |
| `agreed` | int | `1` = agreed, `0` = revoked. |
| `sid` | varchar(100) | Session id at acceptance (used when `frequency == 0`). |
| `agreed_date` | int | Unix timestamp of acceptance. |

Index `type_uid` on `(type, uid)`. (Anonymous acceptances are cookies, not rows — see
[api/handler.md](../api/handler.md).)

## `hook_views_data()` (`agreement.views.inc`)

Exposes the `{agreement}` table (group "User"), left-joined to `users_field_data` on `uid`, with
fields/filters/sorts for `agreed_date` (date), `agreed` (boolean, "Has Agreed"), and `type`
(handler `agreement_entity`, filter `in_operator` with options callback
`agreement_get_agreement_options`).

## Views field plugin `agreement_entity`

`Drupal\agreement\Plugin\views\field\AgreementEntity` (`#[ViewsField('agreement_entity')]`).
Renders columns from the referenced agreement config entity; its `display` option chooses any of
`id`, `label`, `path`, `roles`, `title`. Values are passed through `sanitizeValue()`.

## Bundled optional views (`config/optional`)

| View | Path | Access | Purpose |
|---|---|---|---|
| `agreements` | `/admin/config/people/agreement/agreements` (tab) | perm `administer agreements` | Site-wide records report with exposed filters (agreement type, has-agreed, user status, user name). |
| `user_agreements` | `/user/%user/agreements` (profile tab "My Agreements") | display access `none`, gated by the `user_uid` contextual argument validating `entity:user` **update** access | A user's own agreement records; only accounts you may edit are viewable. |

Both are optional config (require the `views` module) and can be edited or deleted like any view.

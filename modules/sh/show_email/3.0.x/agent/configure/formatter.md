# Configure Show Email

## Enable the email display

1. Enable the module. Its `hook_entity_base_field_info_alter()` makes the user `mail` field
   display-configurable.
2. Go to **Configuration » People » Account settings » Manage display**
   (`/admin/config/people/accounts/display`, and any user view mode).
3. Drag the **Email** field out of *Disabled* and set its format to **Show email address**.
4. Configure the formatter (gear icon) and save.

## Formatter: `show_email_address`

Applies only to `email` fields on the `user` entity (`isApplicable()` returns false otherwise).

| Setting | Key | Default | Effect |
|---|---|---|---|
| Hide user one | `hide_user_one` | `1` (on) | When on, the email is never rendered for uid 1 (super admin). |
| Hide per role | `hide_per_role` | `[]` | Checkboxes of all roles except anonymous. If the **account being displayed** has any checked role, its email is suppressed. |
| Enable *mailto* link | `email_mailto` | `0` (off) | On → output `<a href="mailto:EMAIL">EMAIL</a>`; off → plain text. |

The settings summary shows whether user 1 is hidden and whether mailto is enabled.

## Behavior details (`ShowEmailAddress::viewElements`)

- For each item it loads the account via `user_load_by_mail($item->value)`.
- uid 1 + `hide_user_one` → renders nothing.
- Otherwise, if the account's roles intersect the selected `hide_per_role` roles → renders nothing.
- Else renders the address (mailto or plain).

Note: `hide_per_role` keys on the **viewed account's** roles, not the viewer's — it hides *whose*
emails are shown, not *who* may see them.

## Storage

Per view mode in the user entity view display config, e.g.
`core.entity_view_display.user.user.default` → `content.mail.settings` with keys `hide_user_one`,
`email_mailto`, `hide_per_role` (schema `field.formatter.settings.show_email_address`).

## Who can see the email (access)

Show Email adds **no** view permission. Whether a viewer sees the value depends on core: the user
profile/`mail` field must be viewable by that viewer and the display component enabled. To restrict by
audience, use core/contrib field or entity access (e.g. profile view access, a field-permissions
module) — this module only layers the hide-user-1 / hide-per-role suppression on top. The default
`hide_user_one = 1` is a sensible default that keeps the super-admin address out of the display.

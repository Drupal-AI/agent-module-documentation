# Configure

![Masquerade — "Masquerade as" form](../../../../../../../screenshots/masquerade/2.2.x/masquerade-form.png)

Masquerade has **no dedicated admin settings form**. Configuration is limited to a block
and one settings flag.

## Switch UI
- Form/route `/masquerade` (`masquerade.block`, access `_masquerade_switch_access`) — an
  entity-autocomplete "Masquerade as…" field + **Switch** button.
- "Masquerade" block (plugin id `masquerade`, category *Forms*) renders that form. Place it
  at **Admin → Structure → Block layout**. Block setting `show_unmasquerade_link` (bool,
  default FALSE): when masquerading, show a lazy-built "Switch back" link instead of the form.
- Profile tab: `/user/{user}/masquerade` (`entity.user.masquerade`, CSRF-protected).
- Switch back: `/unmasquerade` (`masquerade.unmasquerade`, requires `_user_is_masquerading`
  + CSRF) and an account-menu "Unmasquerade" link (`masquerade.links.menu.yml`).

## Settings config (`masquerade.settings`)
Schema `config/schema/masquerade.schema.yml`; install default in `config/install`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `update_user_last_access` | bool | `false` | Whether to update the target user's "last access" timestamp while you are masquerading as them. |

No UI writes this; set it with config:
```
drush config:set masquerade.settings update_user_last_access true -y
```
It is consumed by the decorated `user_last_access_subscriber`
(`MasqueradeUserRequestSubscriber`).

# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Disable user deletion → Settings**, or navigate
   directly to `/admin/config/disable_user_deletion/settings`.

## The three toggles

The form has three checkboxes, one for each of core's destructive cancellation
methods. Tick a box to **hide** that method from the user cancel forms:

- **Delete the account and its content** (`user_cancel_delete`) — the most
  destructive option; hiding it prevents an admin from permanently removing a
  user and everything they authored.
- **Delete the account and make its content belong to Anonymous**
  (`user_cancel_reassign`) — deletes the user but reassigns their content to the
  Anonymous user. Hide it to keep authorship information from being wiped this
  way.
- **Disable the account and unpublish its content**
  (`user_cancel_block_unpublish`) — blocks the account and unpublishes its
  content. Hide it if you'd rather content stayed published when an account is
  disabled.

Core's non‑destructive method — **Disable the account and keep its content**
(`user_cancel_block`) — has no toggle and is **always left available**, so admins
always have a safe way to deactivate a user.

When any of these are hidden, the cancel forms show a warning in place of the
removed options directing the admin to contact a technical administrator.

## Save

Click **Save configuration**. The change applies immediately to both the
single‑user cancel form and the bulk (multiple‑user) cancel‑confirm form.

## Deploying the policy

The toggles are stored in the `disable_user_deletion.settings` configuration
object, so they travel with your exported configuration. You can also set them
from the command line, for example:

```bash
drush cset disable_user_deletion.settings user_cancel_delete 1 -y
drush cset disable_user_deletion.settings user_cancel_reassign 1 -y
drush cset disable_user_deletion.settings user_cancel_block_unpublish 1 -y
```

## Remember the limitation

This form only removes options from the rendered cancel forms. It adds no
server‑side validation, so it is a guardrail for trusted admins rather than an
enforcement boundary. Continue to rely on core's *Administer users* permission
and sensible role scoping to control who can cancel accounts at all.

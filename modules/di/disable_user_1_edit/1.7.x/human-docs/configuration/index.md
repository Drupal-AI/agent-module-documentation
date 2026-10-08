# Configuration

Disable user 1 edit needs no configuration to do its job — protection is **on by
default** the moment you enable the module. The settings form exists for one
purpose: to temporarily lift that protection when you genuinely need to change user
1, and then to put it back.

## Open the settings form

1. Log in as a user with the **Administer disable user 1 edit** permission (this is
   a restricted permission, separate from *Administer users*).
2. Go to **Configuration → People → Disable user 1 edit**, or navigate directly to
   `/admin/config/people/disable_user_1_edit`.

## The one setting — "Disable restriction"

The form has a single checkbox: **Disable restriction** ("Make user 1 editable
again"). Read the wording carefully, because it's the *module's restriction* that
is being disabled, not user 1:

- **Unchecked (the default)** — the restriction is **active**. User 1 is locked:
  it cannot be edited, deleted, or viewed through the entity access system, even by
  accounts with *Administer users*.
- **Checked** — the restriction is **turned off**. User 1 becomes editable again,
  and normal core user access rules apply.

So to make a legitimate change to user 1, tick **Disable restriction**, save, make
your change, then come back and **untick** it to re‑lock the account.

## Save

Click **Save configuration**. The change takes effect immediately — there's no
cache clear required. A good habit is to leave this form with the box **unchecked**
(restriction active) so user 1 stays protected in normal operation.

## Managing it from the command line

Because the setting is stored as plain configuration, you can also toggle it with
Drush. The underlying key is `disabled`, and its meaning is inverted just like the
checkbox — `0` means protected, `1` means editable:

```bash
drush cget disable_user_1_edit.settings disabled     # 0 = protected, 1 = editable
drush cset disable_user_1_edit.settings disabled 1 -y # make user 1 editable again
drush cset disable_user_1_edit.settings disabled 0 -y # re-lock user 1 (the default)
```

This makes it easy to keep the protection state consistent across environments as
exported configuration.

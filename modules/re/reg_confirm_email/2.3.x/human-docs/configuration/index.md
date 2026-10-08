# Configuration

The module has no page of its own. Its settings are added as a **"Confirm email
address"** section on the core account settings form.

## Turn on the confirm field

1. Go to **Configuration → People → Account settings**
   (`/admin/config/people/accounts`). You need the *Administer account settings*
   permission (administrators have it by default).
2. Find the **Confirm email address** section, which has two controls:
   - **Use two e-mail fields on registration form** — the master on/off switch.
     Tick it to add the confirm field to the registration form. (Off by default.)
   - **Confirm Email Description** — the help text shown under the confirm field.
     The default is *"Please re-type your e-mail address to confirm it is
     accurate"*; change it to match your site's tone.
3. **Save configuration.**

## What enabling it does

Once the master switch is on, the registration form gains a required **Confirm
e-mail address** field immediately below the standard e-mail field, showing your
help text. When a visitor submits the form, the module checks the two addresses and,
if they don't match exactly, blocks submission with the error *"Your e-mail address
and confirmed e-mail address must match."* Correcting the mismatch lets the
registration proceed as normal.

## Configuring with Drush (optional)

You can set the two values without visiting the UI:

```bash
ddev drush cset reg_confirm_email.settings mail_confirm 1 -y
ddev drush cset reg_confirm_email.settings mail_desc 'Please re-enter your email address' -y
```

- `mail_confirm` — `1` to enable the confirm field, `0` to disable (default `0`).
- `mail_desc` — the help text string.

## Scope

That is the whole feature. The module does not modify account activation, approval,
verification emails, one-time login tokens, or the login flow — it only adds the
confirm field and the equality check. It pairs naturally with core's "require
e-mail verification" so the now typo-checked address gets a real activation mail.

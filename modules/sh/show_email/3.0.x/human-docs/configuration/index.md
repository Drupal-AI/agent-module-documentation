# Configuration

Show Email has no page of its own — you configure it as a field formatter on the
user entity's display.

## Enable the email display

1. Make sure the module is enabled. That marks the user `mail` field as
   display-configurable, so it appears on the user *Manage display* screen.
2. Go to **Configuration → People → Account settings → Manage display**
   (`/admin/config/people/accounts/display`). Choose the view mode you want (the
   default, or any custom user view mode).
3. Drag the **Email** field out of the **Disabled** section into the visible area.
4. Set its format to **Show email address**.
5. Click the gear icon to configure the formatter (below), and **Save**.

## The formatter settings

The **Show email address** formatter has three options:

- **Hide user one** (on by default) — when on, the email is never rendered for user
  1 (the super administrator). This is a sensible default that keeps the super-admin
  address out of the display; leave it on unless you have a specific reason not to.
- **Hide per role** (default: none selected) — a checkbox list of every role except
  anonymous. If the **account being displayed** holds any role you tick here, its
  email is suppressed. Use it, for example, to hide staff emails while showing member
  emails.
- **Enable mailto link** (off by default) — when on, the address is output as a
  clickable `<a href="mailto:…">` link; when off, it's shown as plain text.

The formatter's settings summary shows at a glance whether user 1 is hidden and
whether mailto is enabled.

## View-mode awareness

Because this is a normal field formatter, its settings are stored **per view mode**
of the user entity. That means you can show emails in one view mode (say "Full")
and not another ("Compact"), or expose them only in a members-directory view mode
you built — just repeat the steps above on each view mode you care about.

## Who can see the email (important)

Show Email does **not** add a view permission of its own. Whether a given visitor
actually sees an address is still decided by core: the user profile and its `mail`
field must be viewable by that visitor, and the display component must be enabled.
The formatter's settings only *further hide* the email on top of core's rules.

Note the direction of "Hide per role": it keys on the **viewed account's** roles
(*whose* emails are shown), not the viewer's (*who* may see them). To restrict by
audience — for example, show emails only to certain viewers — combine Show Email
with core or contrib field/entity access (such as profile view access or a
field-permissions module).

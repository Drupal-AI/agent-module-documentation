# Configuration

Popup After Login is configured from a single settings form where you choose who
sees a popup and what it says.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **`/admin/config/popup_after_login`**.

## The two popups

The form lets you set up two independent popups. You can use either, both, or
neither.

### First-login popup (shown once)

- **Target roles** — select which roles should see this popup. Only users in a
  selected role will ever receive it.
- **Title** — the popup's heading. **If you leave the title blank, this popup is
  disabled** and nothing shows.
- **Message** — the body of the popup. This is a **full-HTML** field, so you can
  include formatting, links and markup. It is trusted admin content — treat it as
  such and only give the settings form to people you trust.

This popup is shown **only the first time** a targeted user logs in. Internally the
module marks it as shown after the first appearance, so it does not repeat.

### Always popup (shown every login)

- **Target roles** — the roles that should see this popup on every login.
- **Title** — the heading; again, **leave it blank to disable** this popup.
- **Message** — the full-HTML body shown each time a targeted user logs in.

## Combining them

Because the two popups are configured separately, you can run any combination:

- just the first-login welcome,
- just the always-on reminder,
- or both — for example a one-time welcome the first time, and a standing notice on
  every login thereafter.

If a user is not in any of the roles you targeted, they see nothing at all.

## How it behaves

When a targeted user logs in, a small piece of JavaScript calls the module's JSON
endpoint, which returns the title and message for that user's session (only if they
are in a targeted role). SweetAlert2 then displays it. The endpoint discloses only
the admin-set message for the current session, keyed to the current user — no user
input is reflected.

## Save

Click **Save configuration**, then **clear the cache** (`drush cr`) so the changed
settings and attached JavaScript are picked up. Log in as a user in a targeted role
to confirm the popup appears as configured.

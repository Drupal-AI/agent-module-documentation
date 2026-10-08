# Configuration

Setting up Masquerade Toolbar is two jobs: **grant the permissions** that decide
who sees and uses the toolbar, and **tune the toolbar's appearance and behaviour**
on its settings form. Who can actually *become* another user is still governed by
Masquerade's own permissions — this toolbar is a front end to them.

## Set permissions

At **People → Permissions** (`admin/people/permissions`), a user needs **both** of
the following before the toolbar appears for them:

- **`Use Masquerade Toolbar`** (`use masquerade toolbar`) — this module's own
  permission to see and use the floating toolbar.
- A **Masquerade** masquerade‑as permission — **`masquerade as any user`** or
  **`masquerade as super user`** — which is what actually authorises switching into
  another account.

Grant these only to trusted roles (developers, admins, support staff). The
`masquerade as any user` / `super user` permissions are high‑privilege: while
masquerading, the user has the target's full access.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → People → Masquerade Toolbar**
   (`/admin/config/people/masquerade-toolbar`).

## Settings

The form lets you tune how the toolbar looks and behaves:

- **Toolbar position** — choose one of the four corners: bottom‑right (default),
  bottom‑left, top‑right, or top‑left.
- **Collapsed by default** — start the toolbar collapsed so it stays out of the way
  until clicked.
- **Recent users list** — show or hide the list of recently masqueraded users, and
  set the maximum number remembered for one‑click re‑switching.
- **Role display** — show each user's roles in the autocomplete results and user
  lists, which helps you pick the right test account.
- **Keyboard shortcuts** — enable optional keyboard navigation for the toolbar.
- **Mobile behaviour** — control whether the toolbar shows or hides on small
  screens.

## Save

Save the form, then reload a page as a permitted user. The toolbar should reflect
your chosen position and options. Use the search field to find a user, click to
switch, and use **Switch Back** to return to your original account.

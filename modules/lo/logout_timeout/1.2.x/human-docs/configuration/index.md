# Configuration

Logout on Timeout ships **disabled**, so this page matters: the feature does
nothing until you enable it here and set a timeout.

## Open the settings form

1. Log in as an administrator.
2. Go to **Administration → Configuration → People → Logout on Timeout**, or
   navigate directly to `/admin/config/people/logout_timeout`.

## Enable the feature

There is an enable toggle on the form. **The module is installed with features
disabled**, so tick this to actually turn on the inactivity timeout. Leave the
rest of the form set up the way you want before (or at the same time as) enabling.

## Timeout and warning timing

Set how long a user may be inactive before the warning appears and, after that,
how long they have to respond before they are logged out. When the warning window
opens, the user sees the pop‑up (below) and can extend the session or log out
right away; if they do nothing, the logout fires.

## Alert messaging

You have full control over how the user is warned:

- **Pop‑up alert** — the message shown in the dialog that appears before logout,
  including the text and the extend / log‑out‑now options.
- **Tab‑title alert** — an optional message that flashes in the browser tab's
  title, so a user whose attention is on another tab still notices the countdown.

Word these clearly so users understand they can keep their session alive.

## Logout message via the theme

The logout redirect includes a **query parameter** so your site's theme can detect
that the user was logged out by inactivity and render a custom message
("You were signed out due to inactivity"). This is handled in the theme layer —
the module supplies the signal.

## simpleSAMLphp Authentication integration

Tick **Use simpleSAMLphp Authentication** only if you have users who sign in via
the simpleSAMLphp Authentication module. When enabled, logout redirects to that
module's configured logout target instead of a hard‑coded destination. Enabling
this without simpleSAMLphp Authentication installed does nothing.

## Hook Event Dispatcher integration

Tick **Use Hook Event Dispatcher** to fire a logout event through Hook Event
Dispatcher's **User Event Dispatcher** submodule when logging out simpleSAMLphp
sessions. This does nothing unless **both** the User Event Dispatcher and
simpleSAMLphp Authentication modules are enabled.

## Permissions

Review the module's permissions at **People → Permissions**
(`/admin/people/permissions`) and grant them to the appropriate roles.

## Save

Click **Save configuration**. Once the feature is enabled and a timeout is set,
inactive users will be warned and then logged out, with all their open tabs
synchronised.

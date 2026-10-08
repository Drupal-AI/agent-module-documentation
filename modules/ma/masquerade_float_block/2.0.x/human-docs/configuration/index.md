# Configuration

Configuring Masquerade Float Block is two small jobs: **decide who may see and
toggle the block** (permissions) and **turn the block on** (the settings form,
plus a couple of optional shortcuts). The block itself simply displays
Masquerade's own switch‑user form, so who can actually *become* another user is
governed by Masquerade's permissions, not this module.

## Set permissions

At **People → Permissions** (`admin/people/permissions`):

- The float block appears for any user who already holds a **`masquerade as …`**
  permission (granted through Masquerade), plus user 1 (the superuser). If a user
  cannot masquerade, they will not see the block.
- **`manage masquerade float block visibility`** is this module's own
  **restricted** permission. It gates the settings form *and* the `?mfb_show`
  query‑parameter shortcut described below. Grant it only to trusted staff.

## Turn the block on

1. Log in as a user with the *manage masquerade float block visibility*
   permission.
2. Go to **Configuration → Development → Masquerade Float Block**
   (`/admin/config/development/masquerade-float-block`).
3. Tick the **visible** checkbox to enable the floating block, then save. (The
   block only renders when this setting is on *and* the current user may
   masquerade.)

The block inherits its behaviour from the native Masquerade block, so it works the
same way — search for or select the user, switch, and use "Switch Back" to return
to your own account. It first appears at the top left; drag it anywhere and its
position is remembered via a cookie.

## Optional: toggle visibility per request

If you hold the restricted permission, you can flip the *visible* setting with a
query parameter without opening the form:

- `?mfb_show=1` — show the block on all pages.
- `?mfb_show=0` — hide the block on all pages.

For example, `https://example.com/?mfb_show=1`. This writes the same *visible*
config the form controls, so it changes the setting site‑wide, not just for your
session.

## Optional: lock the setting in settings.php

To force the block on or off for a whole environment (for example, always off on
production) regardless of the UI, override the config in `settings.php`:

```php
// Hide the float block.
$config['masquerade_float_block.settings']['visible'] = 0;

// Show the float block.
$config['masquerade_float_block.settings']['visible'] = 1;
```

This is the reliable way to keep the block available on staging while guaranteeing
it never appears on a live site.

# Configuration

Everything about Alive5 is controlled from one settings form — the widget ID and
the rules for where the chat widget appears.

## Open the settings form

1. Log in as a user with the **Administer Alive5** permission. This is a
   restricted permission, so grant it only to trusted administrators.
2. Go to **Configuration → System → Alive5**, or navigate directly to
   `/admin/config/system/alive5`.

## Enter your widget ID

Paste the **Alive5 widget ID** from your Alive5 account into the form. This is
what ties the on-page widget to your Alive5 workspace. The form also lets you set
the third-party script URL that is loaded.

## Choose where the widget appears

The display rules decide, per request, whether the chat script is attached:

- **Paths** — show the widget only on selected paths (for example the contact or
  pricing pages), or everywhere except certain paths.
- **Exclude admin routes** — keep the chat widget off admin screens.
- **Roles / audience** — restrict the widget to specific user roles, for example
  logged-in users only.

These decisions are made in a cache-safe way, so they keep working correctly with
page caching enabled.

## Turning it off

To remove the widget site-wide without uninstalling the module, disable it from
this form. Because the settings are standard Drupal configuration, you can also
export them with configuration management and deploy them between environments —
handy for enabling chat in production but not on staging.

## Save

Click **Save configuration**. The widget starts (or stops) appearing according to
your rules immediately.

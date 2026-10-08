# Configuration

The ribbon does not have a separate settings form — it draws its name and colours
from **Environment Indicator**, which it extends. So configuration is really two
things: setting up the environment in Environment Indicator, and granting the
permission that decides who sees the ribbon.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Environment indicator**, or navigate
   directly to `/admin/config/development/environment-indicator` (the
   `environment_indicator.settings` form).

## Set the environment name and colour

On the Environment Indicator settings form you give the current environment a
**name** and a **colour** (background and text). The ribbon uses both:

- The **name** is the important part — it is printed in the ribbon text so the
  environment is identifiable even to someone who cannot distinguish the colours.
  Use a clear, non‑sensitive label such as "DEVELOPMENT", "STAGING", or
  "PRODUCTION". Avoid putting anything confidential in the name, since the ribbon
  is on‑screen.
- The **colours** give the fast visual cue — a convention such as green for local,
  amber for staging, red for production works well — but treat colour as a
  reinforcement of the name, never as the only signal.

## Detect the environment, don't hard‑code it per environment

This is the single most important point. If you set the environment name in
**exported configuration**, that same value is deployed to every environment, so
staging will display "production" — a confident, trusted, wrong label.

Instead, drive the value from something that differs per environment — most
commonly an **environment variable** read in `settings.php` (Environment Indicator
supports setting `$config['environment_indicator.indicator']` from
`getenv(...)`). A value read from the environment is correct everywhere
automatically, which is the whole point of the ribbon.

## Control who sees the ribbon

The module adds an **`access environment indicator ribbon`** permission. At
**People → Permissions** (`/admin/people/permissions`), grant it to the roles who
should see the ribbon — typically administrators, developers, and editors who work
across environments. Anonymous visitors normally should not see it.

## Save

Click **Save configuration** on the Environment Indicator settings form. Reload any
page as a user with the permission and the ribbon should reflect the new name and
colour immediately.

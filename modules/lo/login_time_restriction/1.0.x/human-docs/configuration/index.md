# Configuration

Login Time Restriction has two parts to configure: a **site‑wide settings form**
that turns the feature on and controls how it behaves, and a **per‑user access
window** set on each account.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/login_time_restriction/settings`**.

### Enable

A master toggle that turns the whole feature on or off. Leave it off (the
default) while you set windows up; turn it on when you are ready to enforce them.
Turning it off later disables enforcement without deleting any of your other
settings or the per‑user windows.

### Restriction mode

Choose how the allowed window is interpreted:

- **Per‑day (time‑only)** — a recurring daily window, e.g. 10:00–12:00 every day.
  Best for shift hours or business‑hours access.
- **Date range** — a fixed start and end date/time, e.g. a single exam or event
  window that does not repeat.

Switching modes changes how the value in each user's access‑time field is read,
so pick the one that matches how you intend to set windows.

### Error message

The message shown to a user who is blocked from logging in (or who is redirected
to the login page after their window closes). Write something that tells the
person *why* they cannot get in and who to contact.

### Warning time (minutes)

How many minutes before the window closes the user is warned. A logged‑in user
whose remaining time drops below this value sees a pop‑up telling them their
session is about to end. Set it to something like 5 or 10 minutes so people can
save their work.

### Sticky timer

When enabled, logged‑in users see a persistent countdown timer showing how long
they have left. Useful for time‑limited kiosk or lab sessions where the person
should always be able to see the clock.

## Save

Click **Save configuration**. Changes take effect immediately.

## Setting a user's access window

The settings form controls *behaviour*; the actual allowed hours are set
per user:

1. Grant the role that manages windows the **Allow access time modification**
   permission at **People → Permissions**. Without it, a user cannot see or edit
   the access‑time field — including on their own account, so people cannot widen
   their own window.
2. Edit the user account (**People → *(user)* → Edit**) and fill in the
   date/time‑range access‑time field (`field_ltr_access_time`) with the allowed
   window. In per‑day mode you set the daily start/end times; in date‑range mode
   you set a start and end date/time.
3. Save the account. The user may now sign in and stay signed in only during that
   window; the moment it closes, their session is ended and they are redirected to
   the login page.

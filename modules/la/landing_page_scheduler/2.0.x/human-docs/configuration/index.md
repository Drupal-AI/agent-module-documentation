# Configuration

Everything for Landing Page Scheduler lives on a single form.

## Open the configuration page

1. Log in as a user with the module's permission.
2. Go to **Configuration → System → Landing Page Scheduler**
   (`/admin/config/system/landing-page-scheduler`).

## The settings

- **Target node** — choose the page visitors should be redirected *to* during the
  scheduled window. This is an internal Drupal node, so pick the landing page you've
  prepared for the campaign, promotion, or maintenance notice.
- **Time window** — set the start and end of the period during which the redirect
  is active. Outside this window, no redirect happens and the site behaves normally.
- **Redirect only once** — an option controlling whether each visitor is redirected
  a single time, or on every request while the window is open. "Only once" is
  gentler: a visitor sees the landing page once and can then browse freely.

## Save

Click **Save configuration**. The redirect becomes active as soon as the current
time falls inside the window you set.

## Scope it carefully

Because this sends visitors away from wherever they were heading, plan the scope
before you save:

- Make sure the redirect doesn't unintentionally **trap administrators or other
  logged‑in users** who need to keep working on the site during the window.
- Double‑check that the **target node** is the exact internal page you intend — a
  wrong target sends everyone to the wrong place for the whole window.
- Remember this is a **marketing/site‑building** convenience, not an access‑control
  feature; it doesn't secure anything, it just reroutes visitors for a while.

# Configuration

There are four things you may want to do: grant **permissions**, adjust the two **settings**,
customize the **dashboard layout**, and sort out the **Chart.js** library.

## 1. Grant the permissions

At **People → Permissions** (`/admin/people/permissions`), two permissions control access:

- **Use moderation dashboard** — lets a user reach **their own** dashboard at
  `/user/{their‑uid}/moderation-dashboard`. It also controls whether the "Moderation
  Dashboard" link appears in that user's toolbar, and whether the after‑login redirect fires
  for them. Grant this to any role that should have an editorial dashboard.
- **View any moderation dashboard** — lets a user view **other people's** dashboards, for
  editorial oversight (for example a lead editor checking a reviewer's queue).

The settings form itself is gated separately by core's *Administer site configuration*
permission, not by these two.

## 2. The settings form

Go to **Configuration → People → Moderation Dashboard**
(`/admin/config/people/moderation_dashboard`). It has exactly two options:

- **Redirect on login** *(on by default)* — after a user logs in through the normal login
  form, send them straight to their moderation dashboard. This only fires when the user has
  *Use moderation dashboard*, at least one content type is under moderation, and the login had
  no explicit destination of its own.
- **Load Chart.js from CDN** *(off by default)* — leave **off** to load Chart.js from a local
  library (recommended); turn **on** only if you can't install the library locally and want to
  pull it from a CDN instead.

Save the form.

## 3. Customize the dashboard (no code)

The dashboard itself is a Views page rendered through a Layout‑Builder layout, so you edit it
in the UI. Enable **Views UI** if you want to tweak the underlying Views, then go to:

**Configuration → People → Account settings → Manage display → Moderation dashboard**
(`/admin/config/people/accounts/display/moderation_dashboard`).

There you can add, remove, and re‑order the pieces in the three‑region **Moderation Dashboard
Layout**. The building blocks available include:

- the four shipped Views (recently created, recent changes, in review, and the master view);
- **Moderation Dashboard Activity** — the Chart.js activity graph;
- **Moderation Dashboard Add Links** — quick "create content" links for moderated types;
- and any other block or View you want to drop in, including Views for non‑node moderated
  entities.

Because the module ships **no update hooks**, your customizations here are preserved across
module updates.

## 4. Chart.js library

The activity chart needs the Chart.js library. Either:

- install `nnnick/chartjs` locally (e.g. into `libraries/chart.js/` or `libraries/chartjs/`) —
  the module detects it automatically and this is the recommended, CDN‑free option; or
- turn on **Load Chart.js from CDN** on the settings form above.

If neither is in place, the **Reports → Status report** page shows a warning and the chart
won't render.

## Verify it works

Log in as an editor who has *Use moderation dashboard* (with a moderated content type
configured). If **Redirect on login** is on, you should land on your dashboard automatically;
otherwise visit `/user/{your‑uid}/moderation-dashboard` or use the toolbar link. You should see
your recent and in‑review content and, with Chart.js in place, the activity graph.

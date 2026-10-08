# Configuration

Changelogify works in two places: a **settings** page where you decide what to
track, and a **dashboard** where you turn tracked events into published releases.
It also relies on three permissions to control who can administer, manage, and
view the changelog.

## Set which events to track

1. Log in as an administrator.
2. Go to **Configuration → Development → Changelogify → Settings**, or navigate
   directly to `/admin/config/development/changelogify/settings`.

On this page you choose which categories of activity Changelogify captures —
**Content** (node creates, updates, deletes), **Modules** (installs and
uninstalls), and **Users** (role changes) — and you set **retention limits** for
how much captured activity is kept. Turn off any category you don't want to
appear in your changelog, and tune retention to suit how busy your site is.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`), assign the three
Changelogify permissions to appropriate roles:

- **`administer changelogify`** — full control, including the settings above.
- **`manage changelogify releases`** — generate, edit, and publish releases from
  the dashboard.
- **`view changelogify releases`** — see the published changelog.

## Generate and publish a release

1. Go to the **Dashboard** at `/admin/config/development/changelogify`. Even right
   after installing, you can create a release manually; as the site is used,
   captured events accumulate here.
2. Click **Generate New Release** and select a **date range** — a specific span
   or **"Since last release"**.
3. Changelogify drafts the release, grouping the captured events into the
   standard sections: **Added, Changed, Fixed, Removed, Security,** and **Other**.
4. **Review and edit** the descriptions so they read clearly for your audience —
   this is where automatic capture becomes polished release notes.
5. Click **Publish**.

## View the result

Your published release is now live at **`/changelog`**, a clean, themeable page
listing your releases for anyone with the view permission (or the public, if you
grant it to the anonymous role).

# Logout Tab — manual setup guide

**Logout Tab** (`logouttab`) adds a **"Log out"** local task (a tab) to the user
profile page, sitting alongside the usual **View** and **Edit** tabs. The idea is
a small usability one: on a site where the account menu is hidden, or a theme
where logging out means hunting for a link in the footer, a tab on the profile
page is a predictable, obvious place for people to find it. The tab only shows on
a user's own profile, not on other people's.

You can configure the tab's **weight** (its position relative to the other tabs)
and the **URL** it points to.

## Important compatibility note (Drupal 10 and 11)

**On Drupal 10 and 11 the tab does not actually log you out** — and this is due to
a change in Drupal core, not a bug in the module. The tab redirects to the logout
path (`user/logout` by default), but core has since added CSRF protection to that
route. A plain redirect that doesn't carry a CSRF token now lands the user on a
**confirmation page** (`/user/logout/confirm`) asking *"Are you sure you want to
log out?"* — with the session still active until they confirm. This was verified
on a clean install.

That behaviour is core working exactly as designed (it's why a logout link can't
be triggered from another website), so nothing here is unsafe. But it means the
module's one feature now costs an extra click and doesn't do what the tab label
promises. If you just want a one‑click logout, **core's own account‑menu logout
link already carries the token and works in a single click** — consider whether
you need this module at all on Drupal 10/11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the tab's weight and the logout
   URL.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Logout Tab**
(`/admin/config/people/logouttab`) and requires the **Administer users**
permission. The tab itself appears on the user profile page (`/user/{user}`) for
the logged‑in user viewing their own profile.

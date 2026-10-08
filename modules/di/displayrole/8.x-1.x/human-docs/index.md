# Display Role — manual setup guide

**Display Role** (`displayrole`) lets administrators show a user's assigned
role(s) on their profile page. It adds "Roles" as a pseudo‑field to the user
display, so you can drag it into place on the *Manage display* form alongside
built‑in items like *Picture* and *Member for* — no preprocess function or custom
theme code required. The roles then also become available in the user profile
template (`user.html.twig`).

Showing roles is genuinely useful on community and organisational sites — badges
like "Editor" or "Moderator" tell visitors who's who. But it comes with a
disclosure consideration worth pausing on: publicly displaying that a user holds
an **administrator** (or other privileged) role tells a potential attacker exactly
whose account is worth targeting. Because the current version shows *all* of a
user's roles, decide deliberately which profiles this feature is enabled for, and
avoid surfacing privileged roles on public‑facing profiles. It depends only on
core's **User** module.

There is no settings form — you enable the module and then position the "Roles"
element on the user display, just like any other display field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration page** — you set it up on the user display
tab, described in "How to use it" below.

## Where it lives in the admin menu

Display Role adds no admin page of its own. You configure it from **Configuration
→ People → Account settings → Manage display**
(`/admin/config/people/accounts/display`).

## How to use it

1. Enable the module.
2. Go to **Configuration → People → Account settings → Manage display**.
3. Find the **Roles** field in the list and drag it to where you want it to appear
   relative to the other user display items.
4. Save. The user's roles now render on their profile, and the data is also
   available in `user.html.twig` for theme‑level customization.

> **Disclosure tip:** because every role a user holds is shown, think carefully
> before enabling this on public profiles for sites where some users hold
> privileged roles like *administrator*. Exposing who the admins are makes them
> easier to target.

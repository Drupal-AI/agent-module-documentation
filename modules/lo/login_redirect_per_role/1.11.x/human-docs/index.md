# Login And Logout Redirect Per Role — manual setup guide

**Login And Logout Redirect Per Role** (`login_redirect_per_role`) sends users to
a landing page of your choosing after they log in or log out, and it picks that
page based on the user's **role**. Editors can go straight to the content list,
administrators to a dashboard, customers to their account page — all without
writing a custom login hook.

You configure it on one admin form that holds two tables, **Login redirect** and
**Logout redirect**. Each table has a row per role with three settings: a
**Redirect URL**, an **Allow destination** checkbox, and a **Weight** that sets
priority. When a user logs in or out, the module walks that role's rows in weight
order and uses the first role the user actually has whose Redirect URL is filled
in. So a user who is both a *Manager* and an *Authenticated user* lands on the
Manager page if the Manager row has higher priority.

A Redirect URL can be the front page (`<front>`), an internal path (`/admin/
content`), a query or anchor (`?tab=x`, `#top`), or a token such as
`/user/[current-user:uid]/edit` when the Token module is installed. If **Allow
destination** is ticked and the request already carries a `?destination=` (for
example a deep link from an email), that existing destination is respected
instead of the role URL. The module deliberately stays out of the way of
password-reset, two-factor, and Commerce checkout flows so it never interrupts
them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the login and logout redirect
   tables, the URL formats, and how role priority works.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Login and Logout Redirect per
role** (`/admin/people/login-and-logout-redirect-per-role`). Editing it requires
core's **Administer site configuration** permission — the module defines no
permission of its own. On a fresh install nothing is configured, which means
users keep Drupal's default login/logout behavior until you fill in a row.

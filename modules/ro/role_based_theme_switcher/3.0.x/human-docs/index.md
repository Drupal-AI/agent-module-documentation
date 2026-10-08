# Role Based Theme Switcher — manual setup guide

**Role Based Theme Switcher** (`role_based_theme_switcher`) lets you serve a
different front-end theme to different user roles. You map each role to a theme in
one admin form; when a user visits the site, they see the theme assigned to their
role. If a user holds several roles, a drag-and-drop weight decides which role's
theme wins.

This is handy for giving editors or "premium" members a distinct look, previewing
a redesign for a single test role, branding a partner role, or applying a
high-contrast/accessibility theme to specific users — all without spinning up
separate sites or writing a custom theme negotiator.

The module leaves your **administration** pages alone in the common case: on admin
routes, users who have the *View the administration theme* permission still get the
configured admin theme, so the role-based theme applies to the front end. Saving
the settings form flushes caches so anonymous visitors pick up the change
immediately.

One thing to watch: the form's built-in default rows reference the old `seven` and
`bartik` theme names, which do not exist on Drupal 10/11 — so always pick an
actually-installed theme in each row.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per-role theme mapping form,
   weights/priority, and how admin pages are handled.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Role Based Theme Switcher →
Settings** (`/admin/config/system/role_based_theme_switcher/settings`). It requires
the core **Administer site configuration** permission.

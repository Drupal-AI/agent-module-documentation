# Theme Switcher Rules — manual setup guide

**Theme Switcher Rules** (`theme_switcher`) lets you swap the active theme — and
optionally the admin theme — depending on where a visitor is on your site. Instead
of one theme for the entire site, you build a list of *rules*, each pairing a theme
with a set of conditions: a URL path, a content type, a user role, a language, and
anything else Drupal's condition system exposes (including conditions added by
other modules).

Each rule says, in effect, "use *this* theme when *these* conditions are met." On
every request the module walks its rules in order, from lowest weight to highest,
and the **first** rule whose conditions all match wins — no later rule is
consulted. That ordering is why you drag the most specific rule to the top of the
list. A rule can require that *all* its conditions match (AND) or that *any one*
matches (OR), and any condition can be negated to mean "everywhere except here."

This is the module you reach for to give a marketing landing page path its own
look, theme one content type differently site-wide, serve a distinct theme per
language, roll out a redesign path-by-path, or build a "microsite" section without
standing up a separate Drupal install. It ships five permissions so you can
delegate rule management (or read-only auditing) to non-admin roles, and it exposes
a small hook other modules can use to remove conditions from the rule form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — building rules, choosing conditions,
   ordering them, and the permissions that gate access.

## Where it lives in the admin menu

The rule list sits at **Configuration → System → Theme Switcher Rules**
(`/admin/config/system/theme_switcher`). From there you add, edit, delete, reorder
(drag-and-drop), and enable/disable rules.

## How to use it

Enable the module, then add a rule: pick the theme you want, choose one or more
conditions (for example a "Pages" condition matching `/campaign/*`), decide whether
the conditions combine with AND or OR, and save. Drag competing rules so the most
specific one sits highest. Visit a matching page and your chosen theme takes over;
everywhere else, the site's normal default theme still applies. Full step-by-step
details are in [Configuration](configuration/index.md).

# Role Classes — manual setup guide

**Role Classes** (`role_classes`) automatically adds a CSS class to the page's
`<body>` tag based on the current user's **highest-privilege role**. This lets site
builders and theme developers style pages differently per role using pure CSS — no
JavaScript, no template overrides, no custom theme hooks.

Every Drupal role has a weight that reflects its privilege level. On each page,
Role Classes reads the current user's roles, picks the one with the highest weight,
looks up the class you configured for that role, and writes it onto the `<body>` tag.
A user who holds several roles — say both *authenticated* and *editor* — gets only
the class for the highest-weight role, which keeps the markup clean and predictable.

Typical uses are ordinary presentation ones: giving editors a visual cue that they
are logged in with elevated rights, hiding a marketing banner from staff, adjusting
spacing when an admin toolbar is present, or styling a members' area differently.
The module runs its logic in a small cached service, validates class names against
the CSS identifier rules, and is compatible with Drupal 10.2, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Configuration is a single simple form, folded into the sections below.

## Where it lives in the admin menu

Once enabled, go to **Administration → Configuration → System → Role Classes**
(`/admin/config/system/role-classes`).

## How to configure it

1. Open **Configuration → System → Role Classes**.
2. Enter a CSS class name next to each role you want to target. The role weights are
   shown alongside each field so you can follow the privilege hierarchy at a glance.
3. Leave a role's field **blank** to skip that role entirely — no class is added for
   it.
4. Save, then clear caches.

From then on, the class for a user's highest-weight role appears on the `<body>` tag,
and you can write plain CSS such as `body.role--editor { … }` to style by role.

## Important: a role class is not a way to hide anything

Say this plainly before you rely on it. A body class is a **styling hook only**. CSS
that "hides" an element hides it *visually* — the element is still in the HTML,
readable in view-source, present to screen readers unless also removed from the
accessibility tree, and available to anything that scrapes the page. Using a role
class to keep content away from a role is **not a weak control; it is no control**,
because the content was already sent to the browser.

- If something **must not be seen**, use entity or field access.
- If something **must not be reachable**, use a permission.

Two further points that follow from how it works:

- **A body class is a cache context.** A page that varies by role must declare the
  `user.roles` cache context, or the first visitor's classes get cached and served to
  everyone. (Role Classes handles this itself, but keep it in mind if you build
  caching or layout on top of the class.)
- **The class names are published.** Every visitor can read the role names your site
  uses. That is unremarkable on most sites, but worth a thought if a role name itself
  is revealing (for example `role--pending-investigation`).

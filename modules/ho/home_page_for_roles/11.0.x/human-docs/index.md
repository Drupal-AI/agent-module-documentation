# Homepage by role — manual setup guide

**Homepage by role** (`home_page_for_roles`) lets you send different users to
different front pages depending on their **role**. When a visitor hits your site's
front page, the module redirects them to a role‑appropriate homepage — for
example, anonymous visitors to a marketing landing page and logged‑in members to a
dashboard. You can set a homepage for anonymous users, one for all registered
users, and/or a specific homepage for a particular role.

One thing to be clear about: this is a **redirect convenience, not access
control**. Sending a user to a page does not grant or deny them access to it — the
destination page still enforces its own permissions. Use Homepage by role to
point people at the right starting point, not to protect content.

The module has no dependencies beyond Drupal core and targets Drupal 11. Setup is
genuinely quick: enable it, open its settings page, and paste in the paths you
want each role to land on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the per‑role homepage paths.

## Where it lives in the admin menu

After enabling, you get a settings page at **Configuration → People → Homepage by
role** (`/admin/config/people/homepage-roles`, the `home_page_for_roles.settings`
form). A link to it also appears under **People** on the main Configuration page.
See [Configuration](configuration/index.md).

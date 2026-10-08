# Clean Maintenance — manual setup guide

**Clean Maintenance** (`clean_maintenance`) replaces Drupal's plain default
maintenance page with a cleaner, nicer-looking one — so when you put your site into
maintenance mode, visitors see a professional "we'll be back" screen instead of the
bare core page. The appeal is that you get this with no custom design, no coding,
and no theming work: you simply install the module.

Under the hood it repoints core's `maintenance_page` template at its own template
and fills it with your site name and the maintenance message you've already
configured in Drupal's standard Maintenance mode settings (the message is
tokenised, so `@site` becomes your site name). It deliberately leaves the
`update.php` database-update screen alone, so that page keeps the standard
maintenance UI.

There is nothing to configure in the module itself — it has no settings form and no
permissions. The text on the page comes from Drupal's own Maintenance mode settings
and the site name from your site information. If you want to change the look beyond
that, you override the module's Twig template in your theme, the normal Drupal way,
without hacking core. It works on Drupal 8 through 11. Note that it is described as
*minimally maintained* (maintenance fixes only) and is not covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. The maintenance text is set in
Drupal's core Maintenance mode settings, described under "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Set your maintenance message and toggle maintenance mode at **Configuration →
   Development → Maintenance mode** (`/admin/config/development/maintenance`) — this
   is core's own settings page, unchanged by the module.
3. When the site is in maintenance mode, visitors now see the cleaner template,
   showing your site name and the message you entered. The `update.php` page is
   intentionally left on the standard maintenance screen.

To customise the appearance further, copy the module's Twig template into your
theme and edit it there.

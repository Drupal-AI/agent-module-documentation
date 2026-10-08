# Site Branding Per Role — manual setup guide

**Site Branding Per Role** (`site_branding_per_role`) is a drop-in variant of Drupal's
core Site Branding block. It shows the same three elements — site logo, site name, and
slogan — but with one twist: the **logo's link destination changes depending on the
viewing user's role**. Click the logo as an administrator and you can be sent to an
admin dashboard; click it as an anonymous visitor and you land on the front page.

Alongside the per-role logo link, the block lets you toggle each branding element
(logo, name, slogan) on or off, so you can show exactly the pieces you want in a given
region. It is a small, focused block enhancement with no dependencies and no
performance or security surprises: site name and slogan come straight from your
site's admin-controlled **Basic site settings**, the logo URL comes from your theme
setting, and each per-role link you enter is validated when you save the block.

There is no separate settings page and no new permission — all configuration happens on
the block itself when you place it, which means placing the block is gated by the usual
**Administer blocks** permission. The module keeps its output cache-correct by
inheriting the `system.site` cache tags, so a change to the site name or slogan
invalidates the block automatically.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — placing the block, toggling elements, and
   setting a link per role.

## How to use it

After enabling, go to **Structure → Block layout** (`/admin/structure/block`) and place
the **Site branding per role block** in a region — typically the header, where your
existing site branding sits. All of its options live on the block's configuration form;
see [Configuration](configuration/index.md).

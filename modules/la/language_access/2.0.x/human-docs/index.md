# Language Access — manual setup guide

**Language Access** (`language_access`) puts each of your site's languages behind
its own permission. For every configured language it creates a permission named
**Access language *(language)*** (machine name `access language <langcode>`, for
example `access language fr`). Roles that hold a language's permission can browse
its pages; roles that don't get an HTTP 403 on those pages and never see the
language anywhere — not in the language switcher, not in `hreflang` tags, not in
sitemaps, and not in the language selection widgets. This is the clean way to
soft‑launch a half‑finished translation to editors, hand a specific language to
the staff who speak it, or quietly retire a language from public view without
deleting its content.

The enforcement is thorough. A request subscriber returns 403 when the current
user lacks the current language's permission (with sensible exemptions for
`/user/` routes, public files, and `/s3/` paths, and it never blocks CLI/Drush or
cron). Beyond the hard block, the module prunes the language everywhere it would
otherwise leak: it removes inaccessible switcher links, strips `hreflang`
alternates, drops Simple Sitemap entries, trims the *preferred language* options on
the user form and on language‑select widgets, and swaps core's browser
language‑negotiation and content‑translation overview for access‑aware variants
(including a TMGMT‑aware version when TMGMT content is present).

There is **no settings form and no configuration object** — the module is driven
entirely from the standard permissions page. On install it grants **Access
language *(default)*** to the anonymous and authenticated roles so the site's
default language keeps working for everyone, and every other language starts locked
until you grant its permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You manage everything on **People →
Permissions** (`/admin/people/permissions`), where the per‑language permissions
appear grouped under this module. Filter the page for "Access language" to find
them quickly.

## How to use it

1. Enable the module. Your default language is granted to anonymous and
   authenticated roles automatically; every other language is now locked.
2. Go to **People → Permissions** and, for each language you want a role to reach,
   tick that role's **Access language *(language)*** box, then save.
   - You can also do this from Drush, for example
     `drush role:perm:add editor 'access language fr'`.
3. Adding a new site language later automatically creates a new
   **Access language** permission (after a cache rebuild) that starts locked until
   you grant it.

To let a role reach every language, grant it all the **Access language**
permissions. Because these are ordinary Drupal permissions, they export with your
`user.role.*` config and deploy across environments like any other permission.

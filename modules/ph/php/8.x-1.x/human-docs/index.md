# PHP Filter — manual setup guide

**PHP Filter** (`php`) re‑adds the "PHP code" text‑format filter that Drupal core
removed years ago. When you enable its filter on a text format, any content using
that format — a node body, a comment, a block body — has its embedded PHP code
**executed** when the page is rendered. You write PHP wrapped in `<?php … ?>` tags
inside content, and it runs in the Drupal process.

> **This module executes arbitrary PHP code, by design — it is the single
> highest‑risk capability you can add to a Drupal site.** Anyone who can author
> content in a PHP‑enabled format can run any code the web server can run: read
> every piece of data Drupal can see (including other sites' `settings.php` and
> databases on a shared server), read and modify files, run executables, and use
> your server to send spam. It is exactly *why* Drupal core dropped the PHP filter.
> Grant its permission only to **fully trusted administrators**, never enable the
> filter on a format that untrusted roles can use, and prefer building a small
> custom module instead wherever you can. This is public, documented guidance from
> the project itself.

It depends on core's Filter module. Note this is a Drupal 9/10 contrib module with
no Drupal 11 release, and its security advisory coverage has been revoked — treat it
as a legacy power tool, not something to reach for on a new site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no module‑specific settings page; the PHP filter is switched on within a
text format on core's **Text formats and editors** screen, described in "How to use
it" below.

## How to use it — and how to lock it down

Do all of these steps together; the last two are not optional if you value the site:

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **create a new, dedicated text format** —
   for example "PHP code". **Never** add the PHP filter to *Basic HTML* or *Full
   HTML*.
3. In that new format, enable the **PHP evaluator** filter and set it to run
   **last** in the filter order.
4. On the format's **Roles** setting, restrict it to trusted roles only — ideally
   just the administrator role.
5. Grant the **`use PHP for settings`** permission (under **People → Permissions**)
   to the same small, trusted set of users, and no one else.

When authoring, wrap code in `<?php … ?>` tags. Remember that stored snippets are
saved in content and **re‑run on every render**, so audit every snippet before it
goes live.

> **The safer long‑term path:** move whatever you needed PHP for into a real custom
> module (a hook, a controller, a Twig extension), then **uninstall this module** to
> remove the code‑execution surface entirely.

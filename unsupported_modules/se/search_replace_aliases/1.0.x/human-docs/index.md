# Search Replace Aliases — manual setup guide

**Search Replace Aliases** (`search_replace_aliases`) gives administrators a
two-step form to find a text fragment across all of your site's URL path aliases
and replace it in bulk. You preview the changes first, then confirm, and the
replacement runs as a batch process so it can handle large numbers of aliases
without timing out.

It solves the chore of a site-wide slug change: if you need to rename a URL prefix
(for example `/blog` → `/news`), fix a typo that repeats across many aliases, or
migrate a path segment, doing it by hand across hundreds of aliases is painful.
This form lets you enter a search fragment and a replacement, see a preview list of
the old → new aliases that would change, and apply them all in one pass. It
depends only on core's **path_alias** and requires **Drupal 10 or newer**.

Two cautions to take seriously. First, this is a **destructive bulk mutation**:
there is no rollback beyond the preview step, so review the preview carefully — a
broad fragment can rewrite many aliases at once. Consider pairing it with the
**Redirect** module (the form itself warns about this) so that old URLs still
resolve after the change. Second, the module is marked **unsupported / obsolete**,
its stable release is **not covered** by Drupal's security advisory policy, and its
UI strings are in Spanish — weigh all of this before using it on a production site.

On access: the form is protected against cross-site request forgery (it is a
standard Drupal form) and the search term is safely parameterised, so there is no
SQL injection. The route is gated by the **Administer site configuration**
permission. Note that the module *also* defines an `access search replace aliases`
permission but the route actually checks the site-configuration permission — so in
practice only trusted administrators should ever reach this page.

This guide is written for a **human** using the module through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The tool is at **Configuration → Search and metadata → URL aliases → Replace**
(`/admin/config/search/path/replace`), reachable by users with the **Administer
site configuration** permission.

## How to use it

1. Go to `/admin/config/search/path/replace`.
2. Enter the text fragment to **search** for and the text to **replace** it with.
3. Submit to see a **preview** list of the aliases that would change, old → new,
   with a count of how many are affected.
4. Review the preview carefully, then **confirm** to run the batch replacement.

Because there is no undo beyond the preview, keep the search fragment as specific
as possible, and consider enabling the Redirect module first so old URLs keep
working.

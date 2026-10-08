# Link Magician — manual setup guide

**Link Magician** (`link_magician`) scans your rich‑text content for faulty or
hard‑coded links and improperly referenced files and images, and tidies them up.
Hard‑coded links are converted into Linkit‑compatible entity links, and files
that were referenced directly as unmanaged files are converted into proper media
entities and linked correctly. Just as importantly, it keeps **extensive logs**
of every change it makes and tracks the things it *cannot* fix automatically, so
you can process those by hand.

It is built for real content migrations and cleanups. The work runs in batches so
you can process large amounts of content and, if you need to babysit the process,
control batch sizes and limits. Most of the day‑to‑day work happens through Drush
commands rather than the UI — a `tidy` command does the actual cleanup, a `purge`
command empties the module's tracking tables, and a `backstop` command exports
data useful for before/after comparison.

Link Magician depends on core **Media** and **Path Alias** and on the contrib
**Redirect** module, and it recommends **Linkit** for the entity‑link
conversions. Optional submodules add support for **Paragraphs** and **Layout
Builder** content. Note the module is currently *minimally maintained* and its
maintainers flag that the configuration still needs polish — so read the settings
below carefully and test on a copy of your content first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, its Redirect dependency, and any submodules you need.
2. [Configuration](configuration/index.md) — set the Base URI and Additional
   Hosts so the redirect‑detection logic works correctly.

## Where it lives in the admin menu

Link Magician's settings form is at **Configuration → System → Link Magician**
(`/admin/config/system/link_magician`). The actual link‑tidying is performed with
Drush commands, described in "How to use it" below.

## How to use it

1. Set the **Base URI** and **Additional Hosts** on the configuration page first —
   these tell the module which URLs count as "this site" (see
   [Configuration](configuration/index.md)).
2. Run the tidy process with Drush. Start with the help output to see the
   available options:

   ```bash
   drush link_magician:tidy --help
   ```

3. To empty the module's tracking tables and start over:

   ```bash
   drush link_magician:purge
   ```

4. To export data for a before/after comparison of a batch:

   ```bash
   drush link_magician:backstop {batchid} > backstoplinks.json
   ```

Because Link Magician rewrites links across your content, always trial it against
a database copy or staging environment before running it on production, and review
its logs afterward.

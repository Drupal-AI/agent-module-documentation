# Tome — manual setup guide

**Tome** (`tome`) turns a normal Drupal site into a static-site generator and a
flat-file content store. It does two related jobs. First, it can render every
public page of your site to plain static HTML, so production needs no database and
no PHP — you upload the generated files to any static host (Netlify, GitHub Pages,
Amazon S3, a plain web server) and serve a fast, hardened, cheap site. Second, it
can serialize all of your content, configuration, and files to JSON on disk, so
the entire site can be committed to Git and rebuilt from scratch on any machine.

Tome itself is an umbrella that installs the pieces that do the real work.
**Tome Static** (`tome_static`) generates the static HTML. **Tome Sync**
(`tome_sync`) writes content, config, and files out to disk as JSON and reads
them back in. Both share code through **Tome Base** (`tome_base`). Once Tome Sync
is on, every content edit you make locally is automatically written back to the
on-disk JSON store, so your export stays in step with your work and is always
ready to commit.

The primary interface is Drush, not the admin UI: you run `drush tome:export`
once to seed the on-disk content store, keep editing normally, and run
`drush tome:static --uri=https://example.com` to produce the deployable HTML.
Where the exported files land is controlled by a handful of keys in
`settings.php` rather than an admin settings form. Tome does expose some admin
pages under `/admin/config/tome`, and several optional add-on submodules cover
cron-driven builds, longer-lived caching, and automatic cleanup.

This guide is written for a **human** setting Tome up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. Note that the deepest technical
detail lives in each submodule's own documentation tree.

## Contents

1. [Installation](installation/index.md) — install with Composer, and enable the
   submodules you need.
2. [Configuration](configuration/index.md) — the `settings.php` keys that control
   where files go, and the Drush export/build workflow.

## Where it lives in the admin menu

Tome has no single settings form. Its admin pages sit under **Configuration →
Tome** (`/admin/config/tome`), with Tome Static at
`/admin/config/tome/static` and Tome Sync at `/admin/config/tome/sync`. These
pages let you trigger and monitor exports and static builds from the browser, but
the day-to-day interface is the `tome:*` family of Drush commands.

## How to use it

A typical first run looks like this:

1. Enable `tome` (which pulls in `tome_static` and `tome_sync`).
2. Run `drush tome:export` once to write all existing content, config, and files
   to disk as JSON.
3. Keep editing your site normally — content edits are exported automatically.
4. Commit the exported directories (`../content`, your config sync directory,
   `../files`) to Git.
5. When you are ready to publish, run
   `drush tome:static --uri=https://your-site.example` to generate static HTML
   into the output directory, then upload that directory to your host. Preview it
   locally first with `drush tome:preview`.

To rebuild a site from the repository on a fresh machine, install Drupal
(`drush si <profile> -y`) and then run `drush tome:import`.

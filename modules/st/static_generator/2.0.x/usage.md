<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Generator produces a static HTML copy of a Drupal site so the dynamic Drupal install can sit behind a firewall while a fast, hardened static host serves the public site.

---

The central service (`static_generator`, `src/StaticGenerator.php`) renders pages as the anonymous user — by default via a Guzzle HTTP request to the configured host, working around a core block-varies-by-page bug — and writes HTML files into a generator directory (default `private://`). It supports **ESI**: elements whose class begins `sg-esi--` are replaced with ESI include markup so shared fragments (blocks) can be regenerated without rebuilding every page. Assets and code are pushed out with admin-configured `rsync` commands, and a queue worker regenerates pages when moderated content transitions to `published` (and deletes them on `archived`), scoped to configured node bundles. Content authors can regenerate a single node/media from admin routes, and administrators drive full generation/cleanup through Drush (`sg`, `sgp`, `sgb`, `sgf`, `sgr`, `sgd`). Events `static_generator.modify_markup` and `static_generator.modify_esi_markup` let other modules alter generated output.

Every web route requires the `administer static generator` permission (restrict access); there is no anonymous, deletion, or low-privilege endpoint, and node/media ids from the generate routes flow only into page rendering, never into a shell command. The shell and HTTP behavior is therefore admin-config build tooling. Two admin-trust caveats worth knowing: the `rsync`/`mkdir`/`rm` strings are built unquoted from config values, and the `guzzle_options` config string is passed through `eval()` on each Guzzle render (and can disable TLS verification via `['verify' => false]`) — both require the trusted `administer static generator` permission to influence.
---
- Generate a full static HTML copy of a Drupal site.
- Serve a public static site while keeping Drupal behind a firewall.
- Regenerate a single node's static page from `/node/{nid}/gen`.
- Regenerate a single media item's static page from `/media/{mid}/gen`.
- Auto-generate static pages when content is published via content moderation.
- Delete static pages automatically when content is archived.
- Use ESI fragments (`sg-esi--*`) to share blocks across pages.
- Deploy generated assets to a static host with configurable rsync.
- Run a full generation with `drush sg`.
- Generate pages for a specific type/bundle with `drush sgpt`.
- Generate only blocks with `drush sgb` (optionally frequent-only).
- Generate public and code files with `drush sgf`.
- Generate redirect rules with `drush sgr`.
- Delete generated pages/ESI/all with `drush sgd`.
- Queue page generation and process it via the queue worker.
- Render pages via Guzzle to avoid the core block-per-page caching bug.
- Configure which entity types/bundles trigger generation.
- Alter generated markup via the `modify_markup` event subscriber.
- Alter ESI markup via the `modify_esi_markup` event.
- View per-node generation info at `/node/{node}/sg`.
- Restrict all generation to holders of `administer static generator`.
- Set the generator output directory (default `private://`).
- Exclude file types from the public rsync (css/js/php/...).
- Regenerate frequently-changing blocks on a schedule.
- Inspect generation status for troubleshooting deploys.

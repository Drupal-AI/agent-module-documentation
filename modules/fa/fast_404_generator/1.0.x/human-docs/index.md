# Fast 404 Generator — manual setup guide

**Fast 404 Generator** (`fast_404_generator`) writes a static `404.html` file
into your site's public files directory, rendered from a node you choose, so the
[Fast 404](https://www.drupal.org/project/fast_404) module can serve a *themed*
"page not found" response without ever bootstrapping Drupal.

Fast 404 exists because a missing image, or a bot probing for `/wp-admin`, should
not cost a full Drupal bootstrap — it intercepts those requests early and returns
a static response. The catch is that the static response Fast 404 ships looks
nothing like your site: plain text on a white page. This module fixes that by
rendering one of your nodes once and saving the result as HTML, so the generated
file keeps the site's styles, menus, and markup. Visitors get a page that looks
like the rest of the site, served without touching PHP.

The one thing to plan for is **staleness**. The generated file is a snapshot: if
you change the theme, the menu, or the source node, the 404 page keeps the old
markup until it is regenerated. Regeneration belongs in your deployment pipeline
alongside cache rebuilds, not in someone's memory. And because the file is written
into the public files directory, it is directly fetchable at
`/sites/default/files/404.html` — so the source node must contain nothing that is
not already public.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside Fast 404, and add the required `settings.php` lines.

There is **no configuration page** for this module. Setup is a small `settings.php`
edit plus regenerating the file — both described below and in Installation.

## How to use it

After installing and enabling the module (see [Installation](installation/index.md)),
tell Fast 404 to use the generated file by adding these lines to your site's
`settings.php`:

```php
$site_404 = DRUPAL_ROOT . '/' . $site_path . '/files/404.html';
$settings['fast404_HTML_error_page'] = file_exists($site_404) ? $site_404 : FALSE;
$settings['fast404_path_check'] = file_exists($site_404);
```

The `file_exists()` guards are the important part: if the file has not been
generated yet, Fast 404 falls back gracefully rather than pointing at a path that
does not exist.

Then clear the site caches. On the next 404, Fast 404 serves your themed static
page. Whenever the theme, menu, or source node changes, regenerate the file (and
clear caches) so the error page stays current — the ideal place for that is your
deploy script, next to the cache rebuild.

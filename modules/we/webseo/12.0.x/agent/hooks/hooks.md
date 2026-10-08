<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web SEO — hook classes

The only runtime PHP in the module. Both are OOP `#[Hook]` classes under `src/Hook/`
(`declare(strict_types=1)`, `final`), auto-discovered — no `webseo.services.yml`.

## MetatagHooks (`src/Hook/MetatagHooks.php`)
Implements `hook_metatags_alter()` (`#[Hook('metatags_alter')]`).

Dependencies (constructor promotion): `RequestStack $requestStack`, and `title_resolver`
(`TitleResolverInterface`, injected via `#[Autowire(service: 'title_resolver')]`).

`metatagsAlter(array &$metatags, array &$context)`:
- Only acts when `$metatags['title']` is a string containing the `[current-page:title]` token;
  otherwise returns early.
- Resolves the current request's route title via `TitleResolverInterface::getTitle()`.
  If the route yields a non-empty printable title (scalar or `Stringable`), it returns unchanged.
- If the title is empty (e.g. the log-out confirmation page has no route title), it strips
  `[current-page:title]` and any adjacent separator (`|`, `:`, `-`, en/em dash, with surrounding
  whitespace) via three `preg_replace` patterns, then trims. If nothing remains, it falls back to
  `[site:name]`.
- Purpose: stop the browser title from starting with a stray "|" on title-less pages.

## XmlSitemapHooks (`src/Hook/XmlSitemapHooks.php`)
Implements `hook_cron()` (`#[Hook('cron')]`).

Dependency: `StateInterface $state`. Constant `INSTALLER_PATH = '/core/install.php'`.

`cron()`:
- Reads state `xmlsitemap_base_url`; returns if it is not a string.
- If that base URL contains `/core/install.php` (the sitemap was captured while the site was
  installed through the web installer), it truncates the URL at that position, writes the cleaned
  value back to `xmlsitemap_base_url`, and sets `xmlsitemap_regenerate_needed = TRUE` so the
  sitemap is rebuilt. Any other base URL is left untouched.
- Purpose: fix XML sitemap links that would otherwise be built under `.../core/install.php`.

## Security-relevant notes
Neither hook takes request-controlled input into a sink: `metatagsAlter` only removes a fixed
token from an admin-configured metatag pattern; `cron()` only rewrites a server-side state value
using a hard-coded constant. No external calls, DB writes via string SQL, output rendering or
user input handling.

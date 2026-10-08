<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process Newspaper Playwright is a migrate process plugin (`migrate_process_newspaper_playwright`) that scrapes an article URL by shelling out to a Python `Newspaper3k/4k` scraper wrapped with Playwright, returning a structured array of the parsed article (title, text, images, authors, publish date, HTML, meta, etc.).
---
`transform()` only runs for absolute `http(s)` URLs; it instantiates `NewspaperPlaywrightWrapper` (from the required `2dareis2do/newspaper-playwright-wrapper` Composer package) and calls `scrape($url, $debug, $cwd?, $command)`. Plugin config keys control the run: `debug` (default false; writes JSON to /tmp), `command` (Python interpreter path, default `python3`), and `cwd` (working directory of the `ArticleScraping.py` script, relative to docroot). Exceptions are logged and yield an empty string. Downstream you use `get`/`extract` to pull individual keys (`_title`, `_text`, `_top_img`, `_authors`, ...).

This plugin **executes a local Python process** on the web server, using a `command`/`cwd` taken from the migration configuration; those values are developer-controlled (not request input), but the prerequisite is a server able to run Python3 + Playwright + a browser. There is no route, permission or UI. Setup: install the Python wrapper per its README, then reference the plugin in a migration with the appropriate `cwd`/`command`.
---
- Scrape full article text from a URL during migration.
- Extract an article title with `newspaper` parsing.
- Pull the top image / images from a scraped article.
- Capture article authors and publish date on import.
- Migrate news articles that require JS rendering (Playwright).
- Set a custom Python interpreter path via `command`.
- Point the plugin at a custom `ArticleScraping.py` via `cwd`.
- Enable `debug` to dump the scraper JSON to /tmp.
- Extract `og`/meta keywords and tags from an article.
- Chain with `skip_on_empty` to drop failed scrapes.
- Import article HTML (`_html` / `_article_html`) into a body field.
- Migrate summaries (`_summary`) into teaser fields.
- Handle JS-heavy pages that plain HTTP fetching cannot render.
- Run multiple scraper scripts from different working directories.
- Log scrape failures to the module logger channel.
- Feed scraped image URLs into `file_remote_url`.

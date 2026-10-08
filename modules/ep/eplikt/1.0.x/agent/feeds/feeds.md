<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds, routes, controller & theming

## Routes (`eplikt.routing.yml`)

| Route | Path | Controller method | Requirement |
|---|---|---|---|
| `eplikt.feed_all` | `/eplikt/all` | `EpliktController::all` | `_permission: access content` |
| `eplikt.feed_weekly` | `/eplikt/weekly` | `EpliktController::weekly` | `_permission: access content` |

Both return a `Symfony\Component\HttpFoundation\Response` with
`Content-Type: application/rss+xml; charset=utf-8`. GET, read-only.

## Controller — `Drupal\eplikt\Controller\EpliktController`

Injects `renderer`, `config.factory` (reads `eplikt.settings`), `logger.factory` (channel
`eplikt`), and `plugin.manager.eplikt_source`.

- `all()` → `getEntities()` (no max age).
- `weekly()` → `getEntities(60*60*24*7)` (entities changed within 7 days).
- `getEntities(?int $max_age)` → calls `getEnabledSources()`, then merges each source's
  `getEntities($max_age)`.
- `getEnabledSources()` → for each id in `config('sources')`: `createInstance($id)`,
  `setConfiguration($config->get($id))`; any exception is logged to the `eplikt` channel and the
  source is skipped.
- `prepareItems()` → wraps each entity in `#theme => 'eplikt_rss_item'`, `#entity => …`,
  `#sorted => TRUE`.
- Render: `all()` uses `renderer->render($build)`; `weekly()` uses `renderer->renderInIsolation($build)`
  (minor inconsistency, same output shape). `$build` is `#theme => 'eplikt_rss'` with `items`.

## Theme hooks — `Drupal\eplikt\Hook\ThemeHooks`

`#[Hook('theme')]` defines:

- `eplikt_rss` (`render element: items`)
- `eplikt_rss_item` (`variables: entity`)
- `eplikt_rss_item__media` (`variables: entity`) — a dedicated default for media.

`#[Hook('theme_suggestions_alter')]` for `eplikt_rss_item` adds suggestions
`eplikt_rss_item__<entityType>` and `eplikt_rss_item__<entityType>__<bundle>` — this is how media
entities pick up `eplikt-rss-item--media.html.twig`.

### Preprocess (legacy hooks in `eplikt.module`, delegating to `ThemeHooks`)

- `preprocessEpliktRss`: sets `base_url`, `self_url`, `title` (`e-Plikt | <site name>`),
  `language` (current language id), `description`.
- `preprocessEpliktRssItem`: `guid` = `entity->uuid()`; `link` = `entity->toUrl()`; `pubdate` =
  `date('r', created)`; `publisher` / `access_rights` from `eplikt.settings`; `title` =
  `entity->label()`; `format` = `text/html`.
- `preprocessEpliktRssItemMedia`: calls the item preprocess, then overrides `link` to the
  `media_entity_download.download` route (absolute) for the media id, sets `format` to the source
  file's MIME type (`getSource()->getSourceFieldValue()` → `File::load()`), and exposes
  `media_link` / `media_format` for the `media:content` element.

## Templates (`templates/`)

- `eplikt-rss.html.twig` — RSS 2.0 `<channel>` wrapper (atom/media/dc/dcterms namespaces),
  emits `{{ items }}`.
- `eplikt-rss-item.html.twig` — `<item>` with `guid`, `link`, `pubDate`, `dc:publisher`, `title`,
  `dcterms:accessRights`, `dc:format`.
- `eplikt-rss-item--media.html.twig` — as above plus
  `<media:content url="{{ media_link }}" type="{{ media_format }}" />`.

All values render through Twig's default autoescaping. Templates follow the National Library of
Sweden RSS delivery spec (linked in each template header).

## Operating

1. Enable at least one source and configure its bundles at `/admin/config/services/eplikt`.
2. Set `publisher` and `access_rights`.
3. Point the harvester at `/eplikt/all` (full) and/or `/eplikt/weekly` (incremental).

`hook_help` (`Hooks::help`, route `help.page.eplikt`) renders the module README (via the `markdown`
filter if that module is present, else escaped `<pre>`).

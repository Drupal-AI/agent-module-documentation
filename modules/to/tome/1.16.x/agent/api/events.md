<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome extension points (events)

Tome has no hooks of its own; you extend it by subscribing to Symfony events fired by the two
sub-modules. Full details live in each sub-module's `api/events.md`; this is the map.

## Tome Sync — `Drupal\tome_sync\Event\TomeSyncEvents`
Fired around content export/import. Subscribe to run custom logic per entity or per run.
- `tome_sync.export_content` / `tome_sync.import_content` / `tome_sync.delete_content` — one
  content entity was exported / imported / deleted (event: `ContentCrudEvent`, has the entity).
- `tome_sync.export_all` / `tome_sync.import_all` — the whole export/import run finished.

(`tome_sync_autoclean` is itself just a subscriber to `tome_sync.export_content`.)

## Tome Static — `Drupal\tome_static\Event\TomeStaticEvents`
Fired while collecting and rendering paths. Subscribe to add/rewrite paths or post-process HTML.
- `tome_static.collect_paths` (`CollectPathsEvent`) — add or replace paths to export
  (`addPath()`, `addPaths()`, `replacePath()`, `deletePath()`).
- `tome_static.path_placeholder` (`PathPlaceholderEvent`) — resolve placeholder paths.
- `tome_static.request_prepare` — reset per-request state before each rendered request.
- `tome_static.modify_html` (`ModifyHtmlEvent`) — rewrite the rendered HTML and discover related assets.
- `tome_static.modify_destination` (`ModifyDestinationEvent`) — change the output file path for a page.
- `tome_static.file_saved` (`FileSavedEvent`) — react after a static file is written.

Core subscribers already registered (examples of the pattern): `EntityPathSubscriber`,
`RoutePathSubscriber`, `ExcludePathSubscriber`, `PagerPathSubscriber`, `RedirectPathSubscriber`,
`MediaOembedPathSubscriber`, `LanguagePathSubscriber`.

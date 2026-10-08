<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static — extension events

Constants on `Drupal\tome_static\Event\TomeStaticEvents`. Register an `event_subscriber`
service (like Tome's own subscribers) to hook the build.

| Constant / event name | Event class | Use it to |
|---|---|---|
| `COLLECT_PATHS` = `tome_static.collect_paths` | `CollectPathsEvent` | Add/replace/delete paths to export. Methods: `addPath($p,$meta=[])`, `addPaths()`, `replacePath()`, `replacePaths()`, `deletePath()`, `getPaths($with_metadata=FALSE)`. |
| `PATH_PLACEHOLDER` = `tome_static.path_placeholder` | `PathPlaceholderEvent` | Resolve a placeholder path into concrete paths. |
| `REQUEST_PREPARE` = `tome_static.request_prepare` | (base event) | Reset per-request state before each rendered request. |
| `MODIFY_HTML` = `tome_static.modify_html` | `ModifyHtmlEvent` | Rewrite rendered HTML and discover related assets. |
| `MODIFY_DESTINATION` = `tome_static.modify_destination` | `ModifyDestinationEvent` | Change the on-disk destination path for a page. |
| `FILE_SAVED` = `tome_static.file_saved` | `FileSavedEvent` | React after a static file is written. |

Core subscribers that already use these (patterns to copy): `RoutePathSubscriber`,
`EntityPathSubscriber`, `ExcludePathSubscriber`, `PagerPathSubscriber`, `RedirectPathSubscriber`,
`MediaOembedPathSubscriber`, `LanguagePathSubscriber`. Entity paths are collected in the special
format `_entity:<entity_type>:<langcode>:<id>` and resolved during the build.

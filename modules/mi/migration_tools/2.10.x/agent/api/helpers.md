# Migration Tools helper library

Namespace `Drupal\migration_tools\*`. Mostly static utility classes you call from custom migration
code (a `prepareRow()`, a source plugin, a custom process plugin). No service container entries except
the two event subscribers (auto-registered via `migration_tools.services.yml`).

## `CheckFor` — row checks (all static)
`hasRowValue($row, $element, $value)`, `stopOnRowValue(...)`, `isDateAfter($date, $cutoff, $default)`,
`isDuplicateByRedirect($legacy_path)`, `isInPath($file_id, $paths)`, `isSkipFile($file_id, $skip)`,
`isSkipAndRedirectFile(...)`, `isType($desired_type, $row)`, `isFile($path)`, `isPage($path)`. Use in
`prepareRow` to gate/skip rows and detect duplicates.

## `StringTools` — string cleanup (all static)
Encoding/character fixing (`fixEncoding`, `convertNonASCIItoASCII`, `stripFunkyChars`,
`fixWindowSpecificChars`, `decodeHtmlEntityNumeric`), whitespace (`superTrim`, `stripWindowsCRChars`,
`reduceDuplicateBr`), markup (`removePhp`, `stripCmsLegacyMarkup`, `fixHtmlTag`/`fixHeadTag`/`fixBodyTag`),
titles/casing (`makeWordsFirstCapital`, `cleanTitle`), and multibyte `strlen`/`truncate`.

## `Url` — URL & path handling (mostly static)
`drupalizePath`, `convertLegacyUriToAlias`, `convertRelativeToAbsoluteUrl`, `isRelativeUrl`,
`isImageUri`, `isAllowedDomain($url, $allowed_hosts, $destination_base_url)`, `normalizePathEnding`,
`urlExists($url, $follow_redirects)`, `extractUrlFromJS`, `rewriteImageHrefsOnPage`,
`rewriteRelativeImageHrefsToMedia`, `hasFragment`, `extractPath`. Handles legacy→Drupal URL conversion
and in-page image href rewriting during scrapes.

## `Redirects` — create redirect entities (instance + static)
Constructed with a `&$row`. `createRedirect($source, $dest, $dest_base_url, $allowed_hosts)`,
`createRedirectsMultiple(...)`, `addRedirectSource($source)`, `saveRedirects($entityID)`,
`hasValidRedirect`/`hasValidHtmlRedirect`/`hasServerSideRedirects`/`getRedirectFromHtml` (detect existing
server-side or in-HTML redirects), plus attachment-redirect helpers. Requires the `redirect` module.

## `Media` — media embeds (static)
`buildMediaEmbed($mediaData)`, `getMediaUuidfromMid($mid)`, `lookupMediaByRedirect($href)`.

## `Message` — migration logging (static)
`make($message, $variables, $severity, $indent)`, `makeSeparator`, `makeSkip($reason, $row_id, $level)`,
`makeSummary($completed, $total, $operation)`, `varDumpToDrush(...)`. `make()` also dispatches a
`MessageEvent` (see below), so migration output can be captured centrally.

## `Operations` — orchestration (static)
`process(array $migration_tools_settings, $row)` — runs a configured set of source modifiers + Obtainer
Jobs for a row; the entry point the `dom` parser uses.

## The `migration_tools_message` event
`Drupal\migration_tools\Event\MessageEvent` (const `EVENT_NAME = 'migration_tools_message'`) carries
`messageTemplate`, `variables`, `severity`, `type`, `message`. Subscribe to it to route migration
messages to your own logger/UI.

## Event subscribers (automatic)
- `migration_tools.prepare_row` → `EventSubscriber\PrepareRow` on Migrate Plus `PREPARE_ROW`: runs DOM /
  source modifiers and pre-import redirect collection.
- `migration_tools.post_row_save` → `EventSubscriber\PostRowSave` on `POST_ROW_SAVE`: creates redirects
  for the saved entity.
Both take `@entity_type.manager` and `@redirect.repository`.

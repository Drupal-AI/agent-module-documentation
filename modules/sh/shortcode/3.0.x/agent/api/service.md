<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services: ShortcodeService, plugin manager, MediaUrlResolver

Declared in `shortcode.services.yml`.

## `shortcode` — `ShortcodeService` (`src/ShortcodeService.php`)

The parser/expander. Constructor takes only `ShortcodePluginManager` (`@plugin.manager.shortcode`).
Caches are **instance properties** (3.0.x switched away from `drupal_static()` since the service is
a container singleton): `$shortcodePluginTokens`, `$shortcodePlugins`, `$shortcodePluginInstances`.

Key methods:

- `loadShortcodePlugins(): array` — all plugin definitions, each defaulted to `weight = 99` and
  `token = strtolower(token ?? id)`.
- `getShortcodePluginTokens(bool $reset = FALSE): array` — token set for `isValidShortcodeTag()`.
- `getShortcodePlugins(?FilterInterface $filter = NULL, bool $reset = FALSE): array` — definitions
  keyed by **token** (not id). With a `$filter`, returns only tags enabled in that format's
  `settings` map; when two ids share a token the **higher weight** wins.
- `getShortcodePlugin(string $id): ShortcodeInterface` — instantiates (memoised) via the manager.
- `isValidShortcodeTag($tag): bool` — case-sensitive token lookup.
- `process($text, $langcode = LANGCODE_NOT_SPECIFIED, ?FilterInterface $filter = NULL): string`
  — the core parser. `splitIntoChunks()` = `preg_split('!(\[{1,2}.*?\]{1,2})!', ...)`. Each chunk
  goes through `processChunk()`:
  - `normalizeEscapedChunk()` — `[[...]]` → escaped (rendered literally; media `[[{...}]]` left
    intact).
  - opening tag → `pushOpeningTag()`; closing `[/tag]` → `processClosingTag()` pops the matching
    heap span and renders; self-closing `[tag /]` → `pushSelfClosingTagResult()`.
  - `processTag(array $m, array $enabled)` looks up the token, calls
    `$shortcode->process($attr, $m[4])`, and returns `$m[1] . <result> . $m[5]`. Unknown/disabled
    tag → input returned with tokens stripped.
  - `parseAttrs(string $text): array` — regex parse of quoted (`"`/`'`), unquoted, and positional
    attributes; keys lowercased; `html_entity_decode` + NBSP/zero-width normalisation applied.
- `postprocessText($text, $langcode, ?FilterInterface $filter = NULL): string` — the HTML
  corrector body: `preg_replace` patterns that unwrap `<p>` around `<div>` and strip Twig-debug
  `#!#` markers. Used by `ShortcodeCorrector`.

**Output contract:** `process()` inserts each plugin's returned string directly into the text and
the `Shortcode` filter returns a `FilterProcessResult` **without additional escaping** — a plugin's
`process()` return value is trusted markup, so plugins are responsible for escaping the attribute
values they emit.

## `plugin.manager.shortcode` — `ShortcodePluginManager`

Extends `DefaultPluginManager`. Namespace `Plugin/Shortcode`, interface `ShortcodeInterface`,
attribute class `Drupal\shortcode\Attribute\Shortcode`, annotation class
`Drupal\shortcode\Annotation\Shortcode` — **both discovery mechanisms active**. `alterInfo('shortcode_info')`
→ `hook_shortcode_info_alter(&$definitions)`. Cache backend keyed `shortcode_info_plugins`.

## `shortcode.media_url_resolver` — `MediaUrlResolver` (new in 3.0.x)

`src/MediaUrlResolver.php` implements `MediaUrlResolverInterface`. Constructor:
`EntityTypeManagerInterface`, `FileUrlGeneratorInterface`. Consolidates the media lookups that used
to live on `ShortcodeBase`:

- `getFileUrl(int|string $mid): string|false` — loads the `media` entity, finds its file field
  (private `getMediaField()` tries `field_media_file`, `field_media_image`,
  `field_media_video_file`, `field_media_audio_file`), returns the absolute file URL, or `FALSE`.
  Null-guards a nonexistent media id (a deliberate 3.0.x bugfix vs. the old `TypeError`).
- `getImageProperties(int|string $mid): array` — `['alt' => ..., 'path' => ...]` for image media.
- `getImageStyleUrl(string $imageStyleId, string $uri): string|false` — image-style derivative URL.

Inject by type-hinting `MediaUrlResolverInterface` (FQCN service aliases exist for the service, the
plugin manager and `ShortcodeService`, so all three autowire).

## Autowiring aliases & hooks

`shortcode.services.yml` also declares FQCN aliases `Drupal\shortcode\ShortcodeService`,
`ShortcodePluginManager`, `MediaUrlResolverInterface`, and the autowired OOP-hook service
`Drupal\shortcode\Hook\ShortcodeHooks` (implements `hook_migration_plugins_alter`).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `vite.vite` service & the manifest

Service id `vite.vite` (class `Drupal\vite\Vite`). Inject it or use
`\Drupal::service('vite.vite')`.

## `getChunk(string $extension, string $libraryId, string $chunk): string`

Resolves the **built** path for a single source asset that belongs to a Vite-managed library —
useful for an asset that is not itself a JS/CSS library entry (e.g. an image referenced from a
template).

```php
$logo = \Drupal::service('vite.vite')->getChunk('frontend', 'global', 'assets/logo.svg');
```

- `$extension` — the module/theme that registered the library.
- `$libraryId` — the library name to resolve within.
- `$chunk` — the **source** path, exactly as written in the library definition.

Behaviour: if the library is not Vite-managed, the input `$chunk` is returned unchanged. If the
dev server is active, returns `{devServerBaseUrl}/{chunk}`. Otherwise it looks the source path up
in the manifest and returns the built file, or the input unchanged if the manifest has no such
chunk. Throws `LibraryNotFoundException` if the library does not exist.

## `processLibraries(array &$libraries, string $extension): void`

The `hook_library_info_alter()` entry point. For each library that `shouldBeManagedByVite()`, it
decides dev-server vs dist and rewrites the definition (dev: point at dev server + attach
`vite/vite-dev-client`; dist: swap source paths for manifest chunks, mark JS `type="module"`, and
add each chunk's associated CSS). You rarely call this directly.

## `Manifest` (`Drupal\vite\Manifest`) — reading the build manifest

Represents a Vite `manifest.json`. Construct with an absolute path; throws
`ManifestNotFoundException` / `ManifestCouldNotBeLoadedException` on missing/invalid JSON.

| Method | Returns |
|---|---|
| `getChunk($src)` | built `file` for a source path, or `NULL` if absent |
| `getStyles($src)` | array of CSS files listed under the chunk's `css` |
| `getImports($src)` | built paths of the chunk's `imports` |
| `getAssets($src)` | built paths of the chunk's `assets` |

```php
use Drupal\vite\Manifest;
$m = new Manifest('/path/to/dist/.vite/manifest.json');
$builtJs  = $m->getChunk('src/main.ts');   // e.g. 'assets/main-ABC123.js'
$builtCss = $m->getStyles('src/main.ts');  // e.g. ['assets/main-DEF456.css']
```

Path resolution helpers: `AssetLibrary::getManifestPath()` defaults to
`{distDir}/.vite/manifest.json` (distDir default `dist`, relative to `viteRoot`, which defaults
to the extension dir). `Vite::getAbsolutePath()` normalises `.`/`..` segments.

## Twig

The service also backs a Twig function — see [../theming/twig.md](../theming/twig.md).

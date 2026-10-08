<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig function: `vite_get_chunk_path`

The Vite Twig extension (`vite.twig_extension`, class `Drupal\vite\Twig\TwigExtension`) exposes a
single function that maps a source asset path to its built (or dev-server) path — the Twig
equivalent of the service's `getChunk()`.

```twig
<img src="{{ vite_get_chunk_path('frontend', 'global', 'assets/logo.svg') }}" />
```

Arguments (same as `Vite::getChunk`):

1. `extension` — the module/theme that registered the library.
2. `library` — the library name to resolve the chunk within.
3. `chunk` — the **source** path, as written in the library definition.

Returns the built path from the manifest (dist mode), a dev-server URL (when the dev server is
active), or the input path unchanged if the library is not Vite-managed / the chunk is not in the
manifest. See [../api/service.md](../api/service.md) for details and PHP usage.

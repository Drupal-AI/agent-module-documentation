<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The nine binary processor plugins

Each is an `@ImageAPIOptimizeProcessor` plugin in
`src/Plugin/ImageAPIOptimizeProcessor/`, extending `ImageAPIOptimizeProcessorBinaryBase`.
The plugin **id** is what you store in a pipeline's `processors.<uuid>.id`. Every processor
also carries `manual_executable_path` (optional override; empty = auto-detect on `$PATH`).

| id | binary | extra `data` keys (defaults) | notes |
|---|---|---|---|
| `advdef` | `advdef` | `recompress` (false), `mode` (3) | recompress deflate in PNGs |
| `advpng` | `advpng` | `recompress` (false), `mode` (3) | PNG recompression |
| `jfifremove` | `jfifremove` | — | strips the JFIF header from JPEGs |
| `jpegoptim` | `jpegoptim` | `progressive` (''), `quality` (''), `size` ('') | JPEG optimizer; runs `--strip-all` |
| `jpegtran` | `jpegtran` | `progressive` (false) | lossless JPEG transforms |
| `optipng` | `optipng` | `interlace` (''), `level` (5) | PNG optimizer, level 0–7 |
| `pngcrush` | `pngcrush` | — | portable PNG optimizer |
| `pngout` | `pngout` | — | aggressive PNG optimizer |
| `pngquant` | `pngquant` | `speed` (3), `quality.min` (90), `quality.max` (99) | lossy PNG (palette) |

## How a processor runs

`applyToImage($image_uri)` (per plugin) checks the derivative's MIME type, assembles binary
options from its `data`, and calls `execShellCommand($cmd, $options, $arguments)`. Example —
`jpegoptim` on an `image/jpeg`:

- always: `--quiet --strip-all --preserve-perms`
- `progressive === 0` → `--all-normal`; `=== 1` → `--all-progressive`
- numeric `quality` → `--max=<quality>`
- numeric `size` → `--size=<size>%`

`optipng` adds `-o<level>` and (when set) `-i1`/`-i0` for interlace. `pngquant` uses
`--speed` and a `min-max` quality range. If the binary is not found the processor returns
`FALSE` and does nothing (its pipeline summary shows "Command not found").

## Config schema

Schema lives in `config/schema/imageapi_optimize_binaries.schema.yml` as
`imageapi_optimize.processor.<id>` mappings (e.g. `imageapi_optimize.processor.jpegoptim`
has `manual_executable_path`, `progressive:int`, `quality:int`, `size:int`). Note: this
module provides processor *instances* — the `ImageAPIOptimizeProcessor` plugin **type** is
defined by the parent `imageapi_optimize` module, so `provides_plugin_types` is `[]`.

## Writing your own

Extend `ImageAPIOptimizeProcessorBinaryBase`, implement `executableName()` and
`applyToImage()`. See [../api/shell-operations.md](../api/shell-operations.md).

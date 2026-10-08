<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static Drush commands

| Command | Purpose | Key options |
|---|---|---|
| `drush tome:static` | Render all public paths to static HTML in the static directory. | `--uri=<abs-url>` (**pass this**), `--path-pattern=<preg>`, `--process-count=5`, `--path-count=5`, `--retry-count=1`, `--run-server`, `--port=8889`, `--ignore-warnings`, `-y` |
| `drush tome:static-export-path <comma,paths>` | Render one chunk of paths (worker command used internally by `tome:static`; usable directly for a subset). | `--return-json`, `--process-count`, `--path-count`, `--retry-count` |
| `drush tome:preview` | Serve the built static directory with PHP's built-in server. | `--port=8889`, `--open=1` |

Behavior notes:
- Without `--uri` (or with `http://default`), Tome warns absolute URLs may be invalid.
- `tome:static` sets state `tome_static.building=TRUE` for the duration and prompts if a build
  already appears to be running (bypass with `-y`).
- It calls `cleanupStaticDirectory()` then `prepareStaticDirectory()` before rendering, then
  fans work across worker subprocesses; discovered related assets (e.g. image-style derivatives)
  are exported in follow-up passes.
- `tome:preview` errors out if the static directory does not exist yet (run `tome:static` first).
- Full HTML generation renders real requests, so a broken site theme/module will surface here.

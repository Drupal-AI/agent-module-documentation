<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D2: Declarative Diagramming (d2) — agent index

Generates SVG diagrams from **D2** (a text-based declarative diagram language) by shelling out to the `d2` CLI
binary. Core `^11`, PHP `^8.1`. License GPL-2.0-or-later. Version dir `1.0.x` (released `1.0.0-beta0`).

## What it provides
- **`Drupal\d2\D2Helper`** (`src/D2Helper.php`) — helper with `getSvg(string $d2_input, array $d2_options = []): string`.
  Caches in the default cache bin under `d2:` + `hash('sha256', $input)`; on cache miss it invokes the
  `consensus/php-d2` library's `Consensus\PhpD2\D2::generateSvg()`, which runs the vendored `d2` binary through
  Symfony Process (argv array, input on STDIN, SVG on STDOUT).
- **Hook `hook_d2_command_options()`** (`d2.api.php`) — invoked with `invokeAll`; return extra `d2` CLI flags
  (e.g. `--sketch`) merged into the command before per-call `$d2_options`.
- **Permission `view d2 diagram errors`** (`d2.permissions.yml`) — gates whether a failed render shows the CLI
  error (messenger + `<pre>` of the input) or silently returns `''`.
- **Submodule `d2_filter`** — a text-format filter (`filter_d2`) that renders `[d2]...[/d2]` blocks. Documented at
  `../../modules/d2_filter/1.0.x/agent/start.md`.

## No routes / no config
No `*.routing.yml`, `*.services.yml`, `*.links.*.yml`, `config/install`, or `config/schema`. Nothing to configure
in the UI (the top module); behaviour is driven by the helper class and the optional filter. The `d2` binary must
be installed on the server (README documents a Composer helper).

## Dependencies
- Composer: `composer/composer ^2.9`, `consensus/php-d2 ^1.0` (plus core `^11`, php `^8.1`).
- Drupal module deps: none (top module). `d2_filter` depends on `d2:d2`.

## Solution docs
- API / rendering: [agent/api/rendering.md](api/rendering.md)

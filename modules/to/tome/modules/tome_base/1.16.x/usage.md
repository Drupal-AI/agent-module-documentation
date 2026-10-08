<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome Base is the shared-code sub-module for Tome: it holds the services and traits that both Tome Sync and Tome Static build on, plus the base class every `tome:*` Drush command extends. It is a dependency, not something you use directly.

---

Tome Base ships no configuration, routes, permissions, or admin UI. Its job is to hold reusable building blocks: `CommandBase` (the abstract Symfony console command that every Tome command — `tome:export`, `tome:import`, `tome:static`, `tome:preview`, etc. — extends, providing `--uri` handling and multi-process helpers), `ProcessTrait` (runs and manages concurrent Symfony `Process` instances for parallel exports), `ExecutableFinderTrait` (locates the PHP/Drush executable to re-invoke), and `PathTrait` (path/URI helpers). It also registers one Drush service, `cli.workaround` (`CliWorkaroundCommands`), whose `@hook pre-command php:cli` re-registers Tome's console commands as annotated commands so that `drush php` works alongside them. You install it automatically when you install Tome; both `tome_static` and `tome_sync` declare it as a dependency. There is nothing to click or set.

---

- Provide the `CommandBase` class that all Tome Drush commands extend.
- Share the multi-process export helper (`ProcessTrait`) between Tome Sync and Tome Static.
- Locate the PHP/Drush executable so Tome can spawn worker processes (`ExecutableFinderTrait`).
- Supply path/URI helper methods via `PathTrait`.
- Work around a Drush bug so `drush php` coexists with Tome's Symfony console commands.
- Act as the common dependency that keeps Tome Sync and Tome Static DRY.
- Get installed automatically as part of a normal Tome install.
- Give contrib/custom code a stable base class to build additional Tome-style commands on.
- Centralise `--uri` option handling for all Tome commands.
- Run export work concurrently with a configurable process count.
- Retry failed worker processes a configurable number of times.
- Keep the parallel-process plumbing out of the individual command classes.
- Serve as the low-level layer you rarely touch but must keep enabled.
- Provide a single place to fix cross-cutting Tome CLI behavior.
- Enable Tome Static and Tome Sync to be installed and used independently while sharing code.
- Underpin `tome:static`'s fan-out into `tome:static-export-path` worker processes.
- Underpin `tome:export`'s fan-out into `tome:export-content` worker processes.
- Remain dependency-only: nothing to configure, no permissions to grant.

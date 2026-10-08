<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dex Console provides a `dex` command-line binary that boots Drupal and runs Symfony Console commands auto-discovered from any module.

---

Dex Console is a lightweight, Drush-independent CLI framework for Drupal 10.2+/11. It ships a single Composer vendor binary (`bin/dex`, exposed as `vendor/bin/dex`) that bootstraps a full `DrupalKernel` in the `prod` environment and hands control to a Symfony Console `Application`. It exists to let module authors expose command-line commands using nothing but standard Symfony Console classes and the `#[AsCommand]` attribute, without depending on Drush's command system or the (unmerged) Drupal core console patch.

At container-compile time, `DexConsoleServiceProvider` registers `DexCompilerPass`, which scans every registered module namespace's `src/Command/` directory, reflects each PHP class, and — for any class carrying the `Symfony\Component\Console\Attribute\AsCommand` attribute — creates an autowired, autoconfigured, public service tagged `console.command`. The pass then builds a `ContainerCommandLoader` (stored in the `console.command_loader` service) mapping command names/aliases to lazy service references, mirroring Symfony's `AddConsoleCommandPass`. The `bin/dex` runtime (via `symfony/runtime`) boots the kernel, pushes a `Request` built from globals so Drupal's request-dependent code works, calls `preHandle()`, then wires the command loader into the Console application.

Operationally this is a developer/deploy tool: it only runs under the CLI SAPI (`bin/dex` throws if `PHP_SAPI !== 'cli'`), exposes no web routes, no permissions, and no configuration UI. The service provider deliberately throws a `LogicException` if the core `DexCompilerPass` class exists, to prevent clashing with the equivalent core patch — uninstall one before using the other. Security posture is that of any local CLI: whoever can execute `vendor/bin/dex` runs Drupal bootstrap and every discovered command with full site privileges, exactly like Drush; there is no additional authentication layer and none is expected for a CLI.

---

- Run `vendor/bin/dex` to list every discovered console command
- Run `vendor/bin/dex list` to enumerate commands and aliases
- Run `vendor/bin/dex help <command>` for a command's usage
- Invoke a module-provided command, e.g. `vendor/bin/dex my:command`
- Expose a new CLI command from a custom module by adding a `src/Command/` class
- Annotate a command class with `#[AsCommand(name: 'foo:bar')]` for auto-discovery
- Use command aliases via the `#[AsCommand]` name/aliases syntax (`foo:bar|fb`)
- Inject services into a command constructor (autowiring is enabled per command)
- Organize commands in nested subdirectories under `src/Command/`
- Provide commands that rely solely on `configure()` (registered via `console.command.ids`)
- Add a CLI entrypoint to a deploy pipeline without requiring Drush
- Point the binary at an alternate site path via the `DRUPAL_DEV_SITE_PATH` context
- Override the request host/port for URL generation via `HOST`/`PORT` context vars
- Build site-maintenance or data-migration commands as plain Symfony commands
- Ship a distribution with its own branded CLI commands
- Prime discovery by running a web request first if caches were just cleared
- Verify a module's commands are registered by inspecting `dex list` output
- Prevent conflicts by keeping this module OR the core console patch, never both
- Write commands portable to the future core console component
- Use the binary in CI to run administrative tasks headlessly
- Debug container command registration through the `console.command_loader` service

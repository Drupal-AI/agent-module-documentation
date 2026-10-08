<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using and writing dex console commands

Dex Console does not add Drush commands; it provides its own `dex` binary. This doc covers running it and authoring commands.

## Running

- List all commands: `vendor/bin/dex` or `vendor/bin/dex list`
- Help for one: `vendor/bin/dex help <name>`
- Run one: `vendor/bin/dex <name> [args] [--options]`

The binary (`bin/dex`) uses `symfony/runtime`. It:
1. Requires the Composer autoload runtime and asserts `PHP_SAPI === 'cli'` (otherwise throws).
2. `chdir(DRUPAL_ROOT)`, constructs `DrupalKernel('prod', ...)`, boots the environment and container.
3. Builds a `Request` from globals and pushes it onto the `request_stack`, then calls `preHandle()` (loads legacy includes) so request-dependent Drupal code works from CLI.
4. Creates a Symfony `Application('dex', \Drupal::VERSION)` and sets its command loader to the `console.command_loader` service.

### Context variables (from the environment/runtime `$context`)
- `DRUPAL_DEV_SITE_PATH` — site path to use instead of `sites/default`.
- `HOST` / `PORT` — override `SERVER_NAME` / `SERVER_PORT` on the synthetic request (affects URL generation).

## Writing a command

Place a class under your module's `src/Command/` (subdirectories allowed) and add the Symfony attribute:

```php
namespace Drupal\my_module\Command;

use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(name: 'my_module:hello', description: 'Say hello.')]
final class HelloCommand extends Command {
  public function __construct(private readonly SomeService $svc) { parent::__construct(); }
  protected function execute(InputInterface $in, OutputInterface $out): int {
    $out->writeln('hello');
    return self::SUCCESS;
  }
}
```

Discovery details (`DexCompilerPass`):
- Only classes in `<namespace>/Command/` with the `#[AsCommand]` attribute are picked up.
- Each becomes a public, autowired, autoconfigured service tagged `console.command` — so constructor injection of Drupal services works.
- Names/aliases come from the attribute (`name: 'a:b|alias'`); a `ContainerCommandLoader` maps them lazily.
- Classes whose parent hierarchy is unresolvable (e.g. extend an absent Drush/Console class) are skipped gracefully.
- Commands relying solely on `configure()` (no attribute) are collected under the `console.command.ids` parameter and added eagerly by `bin/dex`.

## Cautions
- Do not enable this module together with the core console patch — `DexConsoleServiceProvider` throws a `LogicException` when the core `DexCompilerPass` class exists.
- If you cleared caches and a command isn't found, prime discovery with a web request first (noted in `bin/dex`).
- Rebuild the container (`drush cr`) after adding a new command so the compiler pass re-scans.

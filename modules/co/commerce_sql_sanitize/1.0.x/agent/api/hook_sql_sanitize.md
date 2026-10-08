# Extending `sql:sanitize` — the Drush `SanitizePluginInterface` mechanism

This is a Drush command-hook API, **not** a Drupal `hook_*`. There is no `hook_sql_sanitize()` in
`.module` form; instead you register a service tagged `drush.command` whose class implements
`Drush\Drupal\Commands\sql\SanitizePluginInterface` and carries Drush annotation hooks. This module
is a worked example of that pattern; use it as a template for your own site-specific sanitization.

## How Drush discovers these plugins

`drush.services.yml` registers each command class as a service tagged `{ name: drush.command }`:

```yaml
services:
  commerce_sql_sanitize.commands.sanitize.commerce_order:
    class: Drupal\commerce_sql_sanitize\Commands\SanitizeOrderCommands
    arguments: ['@database', '@entity_type.manager']
    tags:
      - { name: drush.command }
```

`composer.json` declares the file so Drush loads it:

```json
"extra": { "drush": { "services": { "drush.services.yml": "^9 || ^10 || ^11" } } }
```

## The three annotation hooks

`SanitizePluginInterface` requires two methods, `sanitize()` and `messages()`. The classes here use
three Drush command hooks (annotations in the method docblocks):

- **`@hook post-command sql-sanitize`** → `sanitize($result, CommandData $commandData)`. Runs *after*
  core `sql:sanitize` has done its work. Read options with `$commandData->options()`. Do the scrub
  here. Signature: `public function sanitize($result, CommandData $commandData)`.
- **`@hook option sql-sanitize`** → `options(Command $command)`. Register extra `--…` options with
  `$command->addOption($name, NULL, InputOption::VALUE_OPTIONAL, dt('…'))`. Guard it so options are
  only added when the target entity/field exists.
- **`@hook on-event sql-sanitize-confirms`** → `messages(&$messages, InputInterface $input)`. Append
  a human line to the confirmation list shown before the operator confirms.

## Minimal custom plugin skeleton

```php
namespace Drupal\my_module\Commands;

use Consolidation\AnnotatedCommand\CommandData;
use Drupal\Core\Database\Connection;
use Drush\Commands\DrushCommands;
use Drush\Drupal\Commands\sql\SanitizePluginInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;

class SanitizeMyThing extends DrushCommands implements SanitizePluginInterface {

  public function __construct(protected Connection $database) {
    parent::__construct();
  }

  /** @hook post-command sql-sanitize */
  public function sanitize($result, CommandData $commandData) {
    $options = $commandData->options();
    if (($options['sanitize-my-thing'] ?? 1) === 'no') {
      return;
    }
    // Build every statement with the DB API — never concatenate values.
    $this->database->update('my_table')
      ->fields(['secret' => '[Sanitized]'])
      ->execute();
  }

  /** @hook option sql-sanitize */
  public function options(Command $command) {
    $command->addOption('sanitize-my-thing', NULL, InputOption::VALUE_OPTIONAL,
      dt('By default my_table is sanitized. Specify <info>no</info> to disable that.'));
  }

  /** @hook on-event sql-sanitize-confirms */
  public function messages(&$messages, InputInterface $input) {
    $messages[] = dt('Sanitize my_table.');
  }
}
```

Then register it in `my_module/drush.services.yml` with the `drush.command` tag (as above).

## Reusable base class in this module

`TruncateEntityTablesCommands` (abstract) is a ready-made base for "truncate every table of these
entity types" plugins: subclass it and implement `getEntityTypeIds()` returning a list of entity
type ids (`TruncateCommerceLogCommands` returns `['commerce_log']`,
`TruncatePaymentMethodsCommands` returns `['commerce_payment_method']`). It resolves the entity's
`SqlEntityStorageInterface` table mapping and truncates every table from `getTableNames()`, skipping
entity types whose storage is not SQL-backed and logging a warning. The per-type disable option is
derived as `sanitize-<entity-type-id-with-dashes>` (`getOptionName()`).

## Conventions worth copying

- Guard every hook against a missing target (`getDefinition($id, FALSE)`,
  `getFieldMapByFieldType(...)`, `schema()->tableExists(...)`) so the plugin is inert on sites that
  lack the data.
- Keep the option key you register (`options()`), the key you confirm (`messages()`), and the key
  you read (`sanitize()`) identical — see `drush/sanitize.md` for a case in this module where they
  diverge and the disable flag silently does nothing.
- Build all SQL with `->update()/->truncate()/->condition()` and the entity table mapping, never by
  interpolating table/column names or values into a raw query string.

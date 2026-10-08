<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Interpreter plugins

An **interpreter** turns a set of parsed RRULE rules into a human-readable string (e.g.
"Weekly on Monday and Wednesday, 10 times"). Plugin type id `date_recur_interpreter`.

## Plugin type surface

- Manager service: `plugin.manager.date_recur_interpreter`
  (`Drupal\date_recur\Plugin\DateRecurInterpreterManager`).
- Attribute: `Drupal\date_recur\Attribute\DateRecurInterpreter` (legacy annotation
  `Drupal\date_recur\Annotation\DateRecurInterpreter` also supported).
- Interface: `Drupal\date_recur\Plugin\DateRecurInterpreterPluginInterface`; base class
  `DateRecurInterpreterPluginBase`. Discovery dir: `src/Plugin/DateRecurInterpreter/`.
- Interface methods:
  - `interpret(array $rules, string $language, ?\DateTimeZone $timeZone = NULL): string`
    — `$rules` is an array of `DateRecurRuleInterface` (from `DateRecurHelper::getRules()`).
  - `supportedLanguages(): array` — language codes, or `['xx']`-style wildcard.
- Plugins that need settings implement `PluginFormInterface` (config lives on the
  `date_recur_interpreter` config entity under `settings`, schema
  `date_recur.interpreter.settings.[plugin_id]`).

## Shipped plugin: `rl`

`Drupal\date_recur\Plugin\DateRecurInterpreter\RlInterpreter` (id `rl`, "RL interpreter"),
implemented via `rlanvin/php-rrule`'s human-readable output. Settings (schema
`date_recur.interpreter.settings.rl`): `show_start_date` (bool), `show_until` (bool),
`date_format` (a core `date_format` entity id, e.g. `long`), `show_infinite` (bool). The
optional `default_interpreter` config entity (from `config/optional`) uses this plugin.

## Config entity

Interpreters are `date_recur_interpreter` config entities
(`Drupal\date_recur\Entity\DateRecurInterpreter`): keys `id`, `label`, `plugin`, `settings`.
Managed at /admin/config/regional/recurring-date-interpreters. `getPlugin()` returns the
configured plugin instance; a field formatter references an interpreter by id via its
`interpreter` setting.

```php
$interpreter = \Drupal\date_recur\Entity\DateRecurInterpreter::load('default_interpreter');
$text = $interpreter->getPlugin()->interpret($helper->getRules(), 'en');
```

## Write a custom interpreter

```php
namespace Drupal\my_module\Plugin\DateRecurInterpreter;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\date_recur\Attribute\DateRecurInterpreter;
use Drupal\date_recur\Plugin\DateRecurInterpreterPluginBase;

#[DateRecurInterpreter(id: 'my_words', label: new TranslatableMarkup('My words'))]
final class MyWordsInterpreter extends DateRecurInterpreterPluginBase {
  public function interpret(array $rules, string $language, ?\DateTimeZone $timeZone = NULL): string {
    // Build a sentence from $rules (each a DateRecurRuleInterface).
    return '…';
  }
  public function supportedLanguages(): array { return ['en']; }
}
```

Then create a `date_recur_interpreter` config entity with `plugin: my_words` (via the UI or
`DateRecurInterpreter::create([...])->save()`) and select it on a formatter.

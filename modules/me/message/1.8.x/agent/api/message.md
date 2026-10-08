<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# message API — create templates & messages in code

Classes: `Drupal\message\Entity\MessageTemplate` (config) and `Drupal\message\Entity\Message`
(content). Interfaces `MessageTemplateInterface` / `MessageInterface`.

## Create a message template (config entity)

```php
use Drupal\message\Entity\MessageTemplate;

$template = MessageTemplate::create([
  'template' => 'node_created',            // machine name == the message bundle id
  'label' => 'Node created',
  'description' => 'Logged when a node is created',
  'text' => [                              // sequence of partials, each { value, format }
    ['value' => '[message:author:name] created [node:title].', 'format' => 'full_html'],
    ['value' => 'Read it: [node:url]', 'format' => 'full_html'],
  ],
  'settings' => [
    'token options' => ['token replace' => TRUE, 'clear' => FALSE],
  ],
]);
$template->save();
```

Handy template methods: `getText($langcode, $delta)` (raw partials, no argument/token
processing — pass a `$delta` to get one partial), `getRawText()`, `getSetting($key, $default)`,
`setSettings()`, `getDescription()`, `id()` (== the `template` key).

## Create a message (content entity) of that template

```php
use Drupal\message\Entity\Message;

$message = Message::create(['template' => 'node_created']);
$message->setOwnerId($account->id());     // optional author (uid); drives [message:author:*]
// Per-instance arguments: keys prefixed @ % ! like core t(); replaced at render time.
$message->setArguments(['@extra' => 'some value']);
$message->save();                         // mid assigned; bundle() == 'node_created'
```

Message methods: `getText($langcode = NULL, $delta = NULL)` returns the array of rendered
partials **with arguments + tokens replaced** (each a `FormattableMarkup` / token-replaced
string); `getTemplate()` loads the `MessageTemplate`; `getArguments()` / `setArguments()`;
`getOwner()` / `setOwner()` / `setOwnerId()`; `getCreatedTime()` / `setCreatedTime()`;
`setLanguage()` / `getLanguage()`.

## How text is rendered (`Message::getText()`)

1. Load the template's partial text for the langcode (and optional delta).
2. **Arguments** (`setArguments`) are substituted: a plain value replaces its `@`/`%`/`!` key;
   an array `['callback' => fn, 'callback arguments' => [...], 'pass message' => bool]` calls
   the callback and uses its return. This is the "single use / custom callback" mechanism.
3. If the template's `settings['token options']['token replace']` is TRUE, remaining Drupal
   **tokens** are replaced via `\Drupal::token()->replace($str, ['message' => $message], ...)`
   with `clear` from the same settings.

So `[message:author:name]`, `[node:title]` etc. are *dynamic* (re-evaluated each render);
`@{...}`-style single-use tokens and explicit arguments are frozen when you build the message.

## Loading / querying messages

```php
$storage = \Drupal::entityTypeManager()->getStorage('message');
$mids = $storage->getQuery()->condition('template', 'node_created')->accessCheck(FALSE)->execute();
$messages = $storage->loadMultiple($mids);
// or:
$messages = $storage->loadByProperties(['template' => 'node_created']);
```

## Related services

- `plugin.manager.message.purge` — `MessagePurgePluginManager` for the `message_purge` plugin type (see `plugins/purge.md`).
- `message.purge_orchestrator` — runs purge on cron across templates.

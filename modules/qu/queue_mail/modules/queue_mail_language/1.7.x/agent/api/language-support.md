<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Queue Mail Language works

There is nothing to configure — enabling the module changes behavior via two pieces.

## 1. Worker-class swap

`queue_mail_language_queue_info_alter(&$queues)` sets:

```php
$queues['queue_mail']['class'] = LanguageAwareSendMailQueueWorker::class;
```

So the `queue_mail` queue is now processed by
`Drupal\queue_mail_language\Plugin\QueueWorker\LanguageAwareSendMailQueueWorker`, which
**extends** the parent `Drupal\queue_mail\Plugin\QueueWorker\SendMailQueueWorker`. You can
confirm on a live site:

```php
$def = \Drupal::service('plugin.manager.queue_worker')->getDefinition('queue_mail');
// $def['class'] === Drupal\queue_mail_language\Plugin\QueueWorker\LanguageAwareSendMailQueueWorker
```

When the submodule is **disabled**, that same definition's class is the parent
`SendMailQueueWorker`.

## 2. Language-aware send

The parent worker's `setMailLanguage()` merely returns `$message['langcode']` (a no-op for
activation) and `setActiveLanguage()` does nothing. The submodule overrides both:

- `setMailLanguage($message)` — if the mail's `langcode` differs from the site default,
  activates that language for formatting (returns the default code to restore later).
- `setActiveLanguage($message, $langcode)` — restores the previous language afterwards.

Both call `setNegotiatorLanguage($langcode)`, which:

1. Installs the `queue_mail.language_negotiator` service as the language manager's negotiator
   (if not already), then
2. `setLanguageCode($langcode)` on it and `languageManager->reset()` to re-run negotiation.

## The negotiator — `queue_mail.language_negotiator`

`QueueMailLanguageNegotiator` extends core `LanguageNegotiator`. Its `initializeType()`
returns the language matching the forced `languageCode` (falling back to the default
language if that code isn't available). Service definition
(`queue_mail_language.services.yml`) wires the language manager, negotiation-method manager,
config factory, settings, and request stack, and calls `initLanguageManager()`.

Requires the `language` module (typed dependency `ConfigurableLanguageManagerInterface`) and
the parent `queue_mail`. No hooks are invited, no Drush, no config schema.

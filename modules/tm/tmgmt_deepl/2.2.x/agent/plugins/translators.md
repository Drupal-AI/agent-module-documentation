<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL translator plugins & queue worker

These are **TMGMT `@TranslatorPlugin`s** (a plugin type defined by the `tmgmt` module). You
*select* one when creating a translator provider; you don't normally implement a new one. This
module defines no plugin type of its own.

## Translator plugins

| Plugin id | Class | Label |
|---|---|---|
| `deepl_free` | `Plugin/tmgmt/Translator/DeeplFreeTranslator` | DeepL API Free |
| `deepl_pro` | `Plugin/tmgmt/Translator/DeeplProTranslator` | DeepL API Pro |

Both extend the shared base `DeeplTranslator` (`Plugin/tmgmt/Translator/DeeplTranslator`) and
declare `ui = "Drupal\tmgmt_deepl\DeeplTranslatorUi"`, `logo = "icons/deepl.svg"`. They differ
only in the default DeepL API endpoints (free vs pro). The base implements TMGMT's translator
interface: building the request from the job + settings, mapping Drupal langcodes to DeepL codes
(e.g. `de`→`DE`, `pt-br`→`PT-BR`, `zh-hans`→`ZH-HANS`), sending, and applying the returned text.

## Settings UI

`DeeplTranslatorUi` builds the provider settings form (auth key, formality, split_sentences,
tag_handling, tag lists, etc. — see [../configure/translator.md](../configure/translator.md)) and
the per-job checkout settings form (alterable via hooks — see [../hooks/hooks.md](../hooks/hooks.md)).

## Cron queue worker

- `@QueueWorker(id = "deepl_translate_worker", cron = {time = 120})` —
  `Plugin/QueueWorker/DeeplTranslateWorker`. Processes queued DeepL translation work on cron (up to
  ~120s/run). Run with `drush queue:run deepl_translate_worker` or `drush cron`.

## Event

- `DeeplReceivedDataEvent` (`Event/DeeplReceivedDataEvent`, event name
  `DeeplReceivedDataEvent::ALTER_RECEIVED_DATA`) — subscribe to post-process translated data
  before it is written back to the job (see the hooks doc for a subscriber example).

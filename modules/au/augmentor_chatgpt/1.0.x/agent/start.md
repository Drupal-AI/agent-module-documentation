<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ChatGPT Augmentor (augmentor_chatgpt) — agent index

An [Augmentor](https://www.drupal.org/project/augmentor) backend plugin that calls the OpenAI
**chat-completions** API and returns the model reply as augmentor output. Version **1.0.0**;
core `^10.2 || ^11 || ^12`.

## What it provides
- **One Augmentor plugin**, id `chatgpt` (`src/Plugin/Augmentor/ChatGpt.php`), extending
  `src/ChatGptBase.php` (base) → `Drupal\augmentor\AugmentorBase`. Discovered via the
  `#[Augmentor]` attribute — no plugin type of its own.
- No routes, no permissions, no services beyond an autowired hook class
  (`src/Hook/AugmentorChatgptHooks.php`, only `hook_help`), no config schema, no Drush.

## Dependencies
- Drupal: `augmentor:augmentor` (the framework that owns the config entity, admin UI, and Key wiring).
- Composer: `drupal/augmentor ^1.1`, `orhanerday/open-ai ^5.2`, `openai-php/client >=0.10`
  (two selectable OpenAI PHP SDKs).

## How it works
- Configuration lives on Augmentor's own config entity; edited through Augmentor's admin UI, gated by
  the base module's `administer augmentors` permission. This module adds no routes.
- The OpenAI API key is a **Key entity**, resolved at call time by `AugmentorBase::getKeyValue()`;
  never stored inline.
- `ChatGpt::execute($input)` builds the message array (substituting `{input}` in `user` messages),
  calls the chosen SDK, and returns `['default' => [completions...]]`.

## Solution docs
- Plugin, config form, and `execute()` flow: [agent/plugins/chatgpt.md](plugins/chatgpt.md)
- SDK selection and key/credential handling: [agent/config/settings.md](config/settings.md)

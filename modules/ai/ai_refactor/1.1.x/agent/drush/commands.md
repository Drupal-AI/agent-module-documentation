<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Refactor — Drush commands

Registered via `drush.services.yml` → `MethodAnalyzerCommands`.

## `ai_refactor:analyze` (alias `ma:analyze`)
```
drush ai_refactor:analyze /path/to/File.php
```
- Reads the file, parses it to an AST with `nikic/php-parser` (`ParserFactory::createForNewestSupportedVersion()`).
- A node visitor collects every `ClassMethod`: name, visibility (public/protected/private), and its pretty-printed source.
- Each method is sent to the drupal/ai Chat operation (OpenAI provider dependency) for refactoring analysis; results are appended to a local log.

Requirements: drush >=9 and `nikic/php-parser` ^5.3 (dev requirements). The drupal/ai OpenAI provider must be configured with a working key (managed by the AI provider layer / Key module).

Note: the command accepts any local file path and transmits its method bodies to the AI provider — only run it against code you are permitted to share with the provider, in a trusted CLI environment.

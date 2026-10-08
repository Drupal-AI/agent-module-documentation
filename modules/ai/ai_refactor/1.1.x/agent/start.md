<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Refactor (ai_refactor) — agent index

**Drush-only developer tool that parses PHP methods and sends them to an AI provider for refactoring analysis.**

- **Version:** 1.1.x (dev-1.1.x checkout)  •  **Core:** ^10 || ^11  •  **Package:** Custom
- **Depends on:** ai_provider_openai (drupal/ai OpenAI provider)
- **Commands:** `ai_refactor:analyze <filePath>` (alias `ma:analyze`) in `src/Commands/MethodAnalyzerCommands.php`.
- **Dev requirements:** drush >=9, nikic/php-parser ^5.3.

**Security:** CLI-only, no web routes or permissions. Reads arbitrary developer-supplied file paths and sends code to an AI provider — run only in trusted developer environments. See [drush/commands.md](drush/commands.md).

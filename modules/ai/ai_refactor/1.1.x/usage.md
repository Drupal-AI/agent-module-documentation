<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Refactor is a developer Drush tool that parses PHP files with nikic/php-parser and asks an AI provider to analyze or suggest refactors for the methods it finds.
---
The module registers Drush commands (via `drush.services.yml`) implemented in `MethodAnalyzerCommands`. `ai_refactor:analyze` (alias `ma:analyze`) takes a file path, builds an AST, collects each class method (name, visibility, pretty-printed code) and sends it to the AI module's Chat operation (the OpenAI provider is a required dependency) for analysis, keeping a small log of results.

It is a CLI-only, developer-facing utility — no routes, permissions, forms or web-exposed surface. It requires drush (>=9) and nikic/php-parser (^5.3) as dev requirements, and reads arbitrary PHP file paths supplied on the command line, so it should only be run by trusted developers in a trusted environment.
---
- Analyze a PHP file's methods for refactoring opportunities.
- Run `drush ai_refactor:analyze <path>` from the CLI.
- Use the `ma:analyze` alias for brevity.
- Parse a file into an AST with nikic/php-parser.
- Enumerate class methods with their visibility.
- Pretty-print each method for the AI prompt.
- Send method code to an AI provider for review.
- Get AI suggestions on method structure.
- Keep a log of analysis results.
- Integrate with the ai_provider_openai backend.
- Script code-quality passes over a module's classes.
- Assist manual refactoring during upgrades.
- Review legacy methods for simplification.
- Feed method bodies to an LLM without hand-copying.
- Restrict usage to a developer CLI environment.
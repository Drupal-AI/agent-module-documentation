<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Batch Bar lets developers run Batch API operations from a Drush command and see a tidy Symfony Console progress bar instead of a flood of log lines.

---

You build your operations array as usual, then instantiate `DrushBatchCommands` with the operations, a title and an optional `finished` callback and call `execute()`; the base `DrushBatchBar` class drives the batch, updates the progress bar, and prints concise success/error summaries. You can subclass `DrushBatchBar` to define custom operation/process/finish methods (calling `parent::initProcess($context)`), and there is a `ProcessCommands` helper plus a `drush_batch_bar_example` submodule with runnable `drush drush-batch-bar` (alias `dbb`) examples. Requires PHP 8.4 and Drush 12+.

It is a CLI developer utility with no web routes, permissions, or config. One safe-by-default detail: where it deserializes batch state it uses `unserialize($data, ['allowed_classes' => FALSE])`, avoiding object-injection. Setup: enable the module, write a Drush command that uses `DrushBatchCommands`, and run it.

---
- Show a progress bar for a long Drush batch job.
- Wrap an existing operations array in `DrushBatchCommands`.
- Provide a custom `finished` callback for a batch.
- Subclass `DrushBatchBar` for custom batch logic.
- Keep CLI output clean instead of per-operation log spam.
- Monitor batch progress like the admin UI, but in the terminal.
- Run batches from cron/CI Drush invocations with feedback.
- Reuse the example submodule as a template.
- Run `drush dbb` to see a demo progress bar.
- Report success/error counts at batch completion.
- Integrate batch processing into custom Drush commands.
- Process large data migrations with visible progress.
- Use `ProcessCommands` for process-oriented batches.
- Standardize batch UX across a team's Drush commands.
- Avoid writing progress-bar boilerplate each time.
- Handle batch errors with a default error message.
- Target PHP 8.4 / Drush 12+ environments.
- Drive queue-style bulk work from the CLI.

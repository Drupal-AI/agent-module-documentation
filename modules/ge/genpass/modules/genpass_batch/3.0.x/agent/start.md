# genpass_batch — agent index

Part of **`genpass`** (see [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)).
Test-support submodule shipped under the project's `tests/modules/` (package `Testing`).
No config, permissions, routes, services, or plugins of its own.

What it does when enabled (`drush en genpass_batch -y`):
- Registers one OOP hook `#[Hook('user_insert')]` in
  `Drupal\genpass_batch\Hook\UserInsertBatch`, which calls `batch_set()` on every user
  insert with a single operation (`batchTask`) and a `batchFinished` callback.
- The operation does no real work — it records the new user's display name into the batch
  results and shows a status message when done. It exists purely to reproduce/verify genpass
  password generation while a Batch API process is in flight (regression harness; see the
  parent's `tests/src/Functional/BatchOnInsertTest.php`).

Depends on `genpass:genpass`. For the generator, settings, and hooks see the parent's
[api/password-generator.md](../../../../3.0.x/agent/api/password-generator.md) and
[configure/settings.md](../../../../3.0.x/agent/configure/settings.md).

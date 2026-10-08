Test-support submodule of Generate Password that starts a Batch API job on every user insert, used to reproduce/verify that genpass password generation behaves correctly when a batch is running during account creation.

---

Part of `genpass` (ships under `tests/modules/`, package `Testing`). Enabling it (`drush en genpass_batch -y`) registers a single OOP hook, `#[Hook('user_insert')]` in `Drupal\genpass_batch\Hook\UserInsertBatch`, which calls `batch_set()` with one operation (`batchTask`) and a `batchFinished` callback each time a user account is created. The operation just records the new user's display name into the batch results and reports a status message on completion; it performs no real work. Its purpose is to exercise the interaction between genpass's password generation on `user_insert` and an in-flight Batch API process (a regression harness for a genpass issue), so it depends on `genpass:genpass` and has no config, permissions, routes, or services of its own.

---

- Reproduce genpass behavior when a batch job runs during user creation.
- Regression-test that password generation survives an in-flight Batch API process.
- Verify `hook_user_insert` batch interactions in genpass's own test suite (`BatchOnInsertTest`).
- Demonstrate the OOP `#[Hook('user_insert')]` attribute pattern for starting a batch.
- Confirm a status message is shown after a batch completes on account creation.
- Trigger a batch automatically whenever a new account is inserted.
- Study a minimal `batch_set()` example with one operation and a finished callback.
- Exercise the batch progress messages (`init_message`, `progress_message`) on user insert.
- Check that `batchTask` records the new user's display name into `$context['results']`.
- Reference how a batch operation marks itself complete via `$context['finished'] = 1`.
- Model an error path with a `batchFinished` failure message for teaching purposes.
- Enable temporarily to debug ordering of genpass and batch hooks on account creation.
- Serve as a template for building your own user-insert batch integration.
- Validate that genpass does not interfere with Drupal's Batch API queue.
- See how `StringTranslationTrait` and `TranslatableMarkup` are used in a hook class.
- Isolate a genpass batch-timing bug without touching the main module code.
- Enable only in test/dev environments; it does no real work in production.
- Confirm the submodule cleanly declares its dependency on `genpass:genpass`.


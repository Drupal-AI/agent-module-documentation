<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hidden example submodule of Batch Service Interface: one form that queues a batch logging N random quotes, demonstrating the service-based batch pattern.

---

Batch Service Interface Example Module (`batch_example`, `hidden: true`, package "Developer (Examples)") is reference code, not a production feature. It registers the service `batch_example.example_batch` (class `ExampleBatchService` extending `AbstractBatchService`) and a form `ExampleBatchForm` at `/batch_example/form` (route `batch_example.example_form`, also linked under the admin config menu). The form asks for a number of messages; on submit, `generateBatchJob()` builds one `logMessage` operation per requested message and `batch_set()` runs them, each writing a randomly chosen quote to the `Batch Service: batch_example.example_batch` log channel, then `doFinishBatch()` reports how many were logged via the messenger. It exists to show developers how `generateBatchJob()`, per-operation methods, and `doFinishBatch()` fit together.

---

- Study a minimal, working example of the Batch Service Interface pattern.
- See how a service extends `AbstractBatchService` and sets `$serviceName`.
- See how `generateBatchJob()` turns form input into an operations list.
- See how one public method (`logMessage()`) implements a single batch operation.
- See how `doFinishBatch()` reports results through the messenger.
- Learn the `[['logMessage' => [...]]]` sequential operation-list shape consumed by `prepBatchArray()`.
- Enable it on a dev/test site to watch a batch progress through the core batch UI.
- Confirm per-service log-channel usage (`Batch Service: batch_example.example_batch`) in the log.
- Copy `ExampleBatchService` / `ExampleBatchForm` as a scaffold for a real batch service.
- Demonstrate injecting a batch service into a form via `create()` and `$container->get()`.
- Show how a form submit handler calls `generateBatchJob()` then `batch_set()`.
- Use as teaching material for onboarding developers to structured batches.
- Verify the module stack works end to end after installing `batch_service_interface`.
- Reference the admin menu link wiring (`batch_example.links.menu.yml`) for adding a batch form to the config tree.
- Keep it disabled in production (it is hidden and purely illustrative).

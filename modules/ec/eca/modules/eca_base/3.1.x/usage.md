ECA Base provides the foundational, subsystem-agnostic events, conditions, and actions that most ECA models rely on — cron/custom triggers, token and state manipulation, list operations, and temp/key-value storage.

---

This submodule ships the generic building blocks of ECA. Its events include a cron-scheduled event and a custom event you can raise from anywhere, letting models start on a timer or on demand. Its conditions compare scalars, check whether a token exists, inspect ECA state, and test list membership and counts. Its large action set covers token handling (set value, set random value, replace, set context), state read/write, key-value and expirable key-value stores, private and shared temp stores, list operations (add, remove, merge, sort, count, save/delete data), locking, translation, log-level control, and triggering custom events. These are the primitives you combine with the subsystem-specific submodules (content, form, user, etc.) to build real workflows. It defines no new plugin types — everything registers into ECA Core's Event/Condition/Action managers.

---

- Run a model on a schedule via the cron event.
- Raise and react to your own custom ECA events.
- Trigger a custom event from within another model.
- Set a token to a fixed or computed value.
- Generate a random token value.
- Replace tokens within a string.
- Set the current token context for later steps.
- Read and write values to Drupal state.
- Store and retrieve values in the key-value store.
- Use an expirable key-value store for temporary data.
- Read/write private tempstore per user.
- Read/write shared tempstore across users.
- Build and manipulate lists (add, remove, merge).
- Sort or count list items.
- Save or delete list data.
- Compare two scalar values in a condition.
- Check whether a token is defined.
- Test ECA state in a condition.
- Check list membership or item count.
- Acquire a lock to serialize work.
- Translate a string for output.
- Emit warning or error messages.
- Set the ECA log level for a run.
- Void an AND-condition branch deliberately.
- Provide reusable primitives for every other ECA submodule.

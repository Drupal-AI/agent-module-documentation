Devel PHP adds an "Execute PHP" page and block to Devel, letting privileged users run arbitrary PHP code from the admin UI. It is the successor to the PHP-execute feature that used to ship inside the Devel module.

---

Devel PHP provides a single form at `/devel/php` (route `devel_php.execute_php`, also linked in the Devel menu) where a trusted developer pastes PHP and clicks Execute. The submitted code is run with `eval()`; anything printed is captured via output buffering and shown through Devel's dumper (`devel.dumper` service), while thrown `Throwable`s are caught and displayed as error messages. The last-run snippet is stashed in the session (`devel_execute_code`) and re-populated into the textarea after redirect, so you can tweak and re-run. Do not wrap code in `<?php ?>` tags. Access is gated entirely by the single permission `execute php code` (marked `restrict access: TRUE`). The module also ships a block plugin, "Execute PHP Code" (`devel_execute_php`), that embeds the same form anywhere and enforces the same permission. There is no settings form, no config schema, and no Drush commands — it depends on Devel (`>=5.2`) purely for the dumper service. Because arbitrary PHP execution is equivalent to full server compromise, this is a development-only tool and the permission should never be granted on production.

---

- Run a one-off PHP snippet against the live site without writing a module or a Drush script.
- Load an entity and inspect its values: `$node = \Drupal::entityTypeManager()->getStorage('node')->load(1); return $node->label();`.
- Call an arbitrary service and dump the result while debugging.
- Test a small piece of business logic interactively before baking it into code.
- Clear or prime a cache bin ad hoc during debugging.
- Programmatically create or update a config object to reproduce a bug.
- Trigger a queue worker or run a callback manually to observe its behavior.
- Inspect the container: fetch a service and print its class or configuration.
- Query the database via the database API and dump the rows returned.
- Delete or fix a stray entity that has no admin UI path.
- Re-run the previous snippet after a tweak (the textarea keeps your last code from the session).
- Embed the Execute PHP form in a custom admin dashboard using the "Execute PHP Code" block.
- Place the block in a region on a non-production environment for quick repeated experiments.
- Print output that flows through Devel's dumper (Kint/var-dumper) for readable structured display.
- Reproduce a support ticket by executing the exact code path a user hit.
- Check the value of a state or `\Drupal::state()` key during an investigation.
- Verify a token or permission resolves as expected for a given account.
- Prototype an update hook body by running it manually before adding it to a `.install` file.
- Restrict PHP execution to a single trusted developer role via the `execute php code` permission.
- Confirm a third-party API client works by instantiating it and calling a method.
- Test entity access or field-level access logic against a loaded entity.
- Manually invoke a hook or event dispatcher to see what listeners fire.
- Inspect routing or menu link data by calling the relevant services inline.
- Batch-fix a handful of records during a data-migration debugging session.
- Use it as a lightweight REPL substitute when a full Drush `php:cli` shell is inconvenient.

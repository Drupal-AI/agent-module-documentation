<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron service override & scheduling logic

## Service swap (not a decorator)
`src/TimetableCronServiceProvider.php` — `ServiceProviderBase::alter(ContainerBuilder)` does:

    $definition = $container->getDefinition('cron');
    $definition->setClass('Drupal\timetable_cron\TimetableCron');

So the container's `cron` service becomes `Drupal\timetable_cron\TimetableCron`, which **extends
`Drupal\Core\Cron`** and overrides one protected method, `invokeCronHandlers()`. Constructor and
all other cron behaviour (locking, queue processing) are inherited unchanged. Because the class is
replaced outright, any other module that also swaps `cron` (Elysia Cron, Ultimate Cron) will
conflict — only one can win. `src/ProxyClass/TimetableCron.php` is the generated lazy-service
proxy implementing `CronInterface::run()`.

## Deciding whether a job runs — `TimetableCron::invokeCronHandlers()`
1. Reads "now" via PHP `date()`: `minute=i`, `hour=G`, `day=j`, `month=n`, `weekday=N` (ISO
   weekday 1–7). Note this uses the server/PHP timezone, not per-site config.
2. Loads all `timetable_cron` config entities (via `entityQuery`) into an array keyed by id, and
   loads runtime (`force`, `lastrun`) from `TimetableCronRuntime`.
3. **Auto-registration:** iterates every `hook_cron` implementation with
   `moduleHandler->invokeAllWith('cron', …)`. For a module `foo`, the job id is `foo_cron`. If no
   entity exists for that id, it **creates and saves** one defaulting to `* * * * *`, status on.
   This is why the schedule table is empty until the first cron run, then self-populates.
4. **Match test** per job (`$runnow` starts TRUE):
   - `status == 0` → `continue` (job skipped entirely).
   - minute: if `minute != now` and `minute != '*'`: if it contains `/` it is treated as an
     interval `*/N` — runs only when `now_minute % N == 0`; anything else (a fixed value that does
     not match, or a `/`-form not starting with `*`) sets `$runnow = FALSE`.
   - hour: same logic, including `*/N`.
   - day, month, weekday: exact match or `*` only — **no interval support** on these three.
   - `force == TRUE` → forces `$runnow = TRUE` regardless of the above.
5. If `$runnow`: records `lastrun = time()`, clears the force flag in the working runtime array,
   logs an info line, and calls `invokeCronJob($function)`.

## Executing a job — `invokeCronJob()` / `invokeCustomFunction()`
- If the id ends in `_cron` and that module exists and implements `hook_cron`, it calls
  `moduleHandler->invoke($module, 'cron')` — the standard handler path.
- Otherwise it treats the id as a plain function name: `ensureCallableFunction()` loads each
  module's `.module` include until the name is `is_callable`, then `call_user_func($function)`
  with **no arguments**. This is the "custom function on cron" feature; the form's id field is
  labelled *Function* and its description says the function must live in a `.module` file.
- Exceptions are caught and logged to the `cron` channel; a return of FALSE from `invokeCronJob`
  marks the entity `delete = TRUE`, and after the loop such entities (whose target can no longer
  be resolved) are deleted and dropped from runtime.

## Runtime state — `src/TimetableCronRuntime.php`
Not exported config; stored in Drupal **state** under `STATE_KEY = 'timetable_cron.runtime'` as
`[id => ['lastrun' => int|null, 'force' => bool]]`.
- `getAll()`, `get($id)` (defaults `lastrun=null, force=false`), `saveAll($runtime)`.
- `setForce($id, bool)` — used by the force form.
- `delete($id)` — used by the delete form.
- `create()` — static factory using `\Drupal::state()`.

`timetable_cron.install` `update_9001` migrates the old per-entity `force` config value and the
legacy `timetable_cron.runs` state into this unified `timetable_cron.runtime` state key.

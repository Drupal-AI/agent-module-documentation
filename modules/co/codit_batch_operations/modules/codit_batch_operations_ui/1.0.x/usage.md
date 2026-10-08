Codit: Batch operations UI is a submodule of Codit: Batch Operations that adds an admin web interface for listing and running BatchOperation scripts.

---

Enabling this submodule exposes an "Operations" screen under the Batch Operations admin section where a suitably-permissioned user can see every available script, review its title, description, item count, cron timing, and history of previous runs, and then run one through a two-step confirm flow that lets them choose to gracefully skip errors or fail on the first one. The run executes via Drupal's Batch API (with a progress bar) as the current operator's user, and each run is logged exactly as it would be if triggered from Drush, cron, or an update hook. Access is controlled by the parent module's restrict-access permission "execute codit batch operations in ui", and the submodule is intentionally kept as a separate on/off switch so production sites can keep the run surface closed until it is needed.

---

- Give a trusted operator a browser button to run a pre-written maintenance script without shell/Drush access.
- Browse all available BatchOperation scripts with their titles, descriptions, and last-run status in one table.
- Review a specific script's total item count, "run once only" flag, and cron schedule before running it.
- See the full run history (date, duration, method, run-by user, status) for a script and open any individual run's log.
- Run a script from the UI and choose per-run whether to skip failing items or stop on the first error.
- Watch a long operation progress via the Batch API progress bar instead of a blocking CLI command.
- Attribute a UI run to the actual logged-in operator for correct authorship on entity saves.
- Enable the UI only while performing maintenance, then disable it to close the run surface on production.
- Confirm, before executing, that no other batch operation is already running (the confirm form blocks concurrent runs).
- Hide the run button automatically for a "run once" script that has already completed.
- Let non-developers trigger vetted content operations while developers keep authoring the scripts in code.
- Quickly re-run or inspect a previously executed operation from its listing row.

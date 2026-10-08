<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Run Drush commands from an in-page overlay in the browser instead of a terminal.

---

Drush dialog adds a keyboard-driven overlay (opened with Ctrl+D) to every page for users with the "administer site configuration" permission. You type a Drush command into a single text field, press Enter, and the module runs `drush <your command>` on the server via Symfony Process and prints the command's output back into the overlay. Each command you run is saved to a per-user log table, and the up/down arrow keys walk back through your previous commands so you can re-run them. There is no settings form and no menu of preset operations — it is a free-text command box wired to Drush. It depends only on Drupal core (9.2+, 10, or 11) and a working Drush installation on the server.

---

- Open the command overlay on any page with Ctrl+D (Ctrl+K also opens it); close it with Esc or Ctrl+D.
- Run `cr` / `cache:rebuild` to clear caches without leaving the page you are on.
- Check site health with `status` or `core:requirements`.
- Run `cron` on demand.
- Inspect enabled extensions with `pm:list` or `pml`.
- Enable a module with `pm:install <module>` (arguments are space-separated).
- Uninstall a module with `pm:uninstall <module>`.
- Read a configuration value with `config:get <name>`.
- Set a configuration value with `config:set <name> <key> <value>`.
- Show or set state with `state:get <key>` / `state:set <key> <value>`.
- Run database updates with `updatedb` / `updb`.
- Export or import configuration with `config:export` / `config:import`.
- Look up a user with `user:information <name>`.
- Add a role to a user with `user:role:add <role> <user>`.
- Watch a log tail or run a maintenance command with `watchdog:show` / `wd-show`.
- Re-run a recent command by pressing the up arrow to recall it from history.
- Review your own recent command history (stored per user, most-recent first, capped at 100 entries).
- Give trusted operators a quick command runner on sites where terminal/SSH access is inconvenient.
- Teach or demonstrate Drush commands from within the site UI.

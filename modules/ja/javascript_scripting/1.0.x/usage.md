<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Javascript Scripting runs JavaScript inside Drupal via a script field and a Drush command.

---

Javascript Scripting adds a JavaScript engine to execute code inside Drupal — scripts are authored in a script field (with an execute action) and can be run from the CLI via a `javascript:execute` Drush command. It targets developers/site builders who want to run scripted logic without writing a module.

Executing code is a privileged capability: script authoring is the trust boundary — only users who can edit a script field (or run Drush) can execute JS, so restrict the script field to trusted roles and do not place it on content editable by untrusted users. Treat it like Drupal's PHP/scripting tools. Supports Drupal 10 and 11.

---

- Execute JavaScript inside Drupal.
- Author scripts in a script field.
- Run scripts via `javascript:execute` Drush.
- Provide an execute action.
- Target developers/site builders.
- Treat script authoring as the trust boundary.
- Restrict the script field to trusted roles.
- Avoid untrusted-editable script fields.
- Treat it like PHP/scripting tools.
- Support Drupal 10 and 11.
- Run scripted logic without a module.
- Execute from the CLI.
- Gate via field edit access
- Run server-side JS.
- Support scripting workflows.
- Handle code execution carefully.
- Provide a JS engine.
- Restrict execution to admins

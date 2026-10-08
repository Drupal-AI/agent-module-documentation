<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Behat javascript

One setting, at **Configuration → Development → Behat Javascript**
(`/admin/config/development/behat-javascript`, route `behat_javascript.settings`, permission
`administer site configuration`; menu link `behat_javascript.links.menu.yml` under
`system.admin_config_development`). Form: `Drupal\behat_javascript\Form\SettingsForm` (extends
`ConfigFormBase`, form id `behat_javascript_settings`).

| Field | Config key | Type | Meaning |
|---|---|---|---|
| Error messages to ignore | `behat_javascript.settings:ignored_errors` | string (textarea) | Newline-separated list of texts / **regular expressions**; matching JS errors are suppressed and do not fail scenarios. |

- Default (`config/install/behat_javascript.settings.yml`): `ignored_errors: ''` (nothing ignored — any
  JS error fails the step). Schema: `config/schema/behat_javascript.schema.yml` (`config_object` with one
  `string` mapping `ignored_errors`).
- Each non-empty line is compiled into `preg_match('/<line>/', $error)` by the Behat subcontext
  (`BehatJavascriptContext::__construct` splits the value on `\n` and `array_filter`s empties), so a line
  is a regex body inserted between `/.../` delimiters (mind unescaped `/` and regex metacharacters).

Set it with Drush:

```bash
ddev drush cset behat_javascript.settings ignored_errors "ResizeObserver loop limit exceeded
Script error\." -y
```

There is no other configuration — enabling the module is otherwise enough. Error capture happens only
inside Behat `@javascript` scenarios (see [../api/behat-context.md](../api/behat-context.md)).

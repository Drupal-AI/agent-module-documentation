<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attacher configuration — path-based library attachment

## Install & enable

```bash
drush en ach_attach_js_attacher -y
```

Pulls in the parent `ach_attach_js` (declared dependency `ach_attach_js:ach_attach_js`). Core-only
otherwise.

## Route, form, permission

`ach_attach_js_attacher.routing.yml`:

```yaml
ach_attach_js_attacher.config:
  path: '/admin/config/ach_attach_js'
  defaults:
    _title: 'ACH Attach JS Attacher Settings'
    _form: '\Drupal\ach_attach_js_attacher\Form\AchAttachJsAttacherConfig'
  requirements:
    _permission: 'administer ach_attach_js_attacher'
```

- Permission `administer ach_attach_js_attacher` is declared with **`restrict access: true`**
  (`ach_attach_js_attacher.permissions.yml`) — flagged as security-sensitive in the permissions UI.
  Grant it only to trusted admin roles.
- Menu link `ach_attach_js_attacher.config` (`.links.menu.yml`) sits under
  `system.admin_config_services`.

## Config object

- Name: **`ach_attach_js_attacher.settings`**. Editable names come from
  `AchAttachJsAttacherConfig::getEditableConfigNames()`.
- Single key **`request_path`** holding a core Request Path condition configuration.
- Install default (`config/install/ach_attach_js_attacher.settings.yml`):

  ```yaml
  request_path:
    id: request_path
    pages: "/admin\r\n/admin/*"
    negate: 1
  ```

  i.e. "attach on all pages **except** `/admin` and `/admin/*`".

- **No `config/schema/` is shipped.** Strict config-schema tooling (e.g. `config_inspector`, or
  test runs with schema checking) will warn about the untyped `request_path` mapping; the config
  still saves and functions.

## The form (`AchAttachJsAttacherConfig`)

`src/Form/AchAttachJsAttacherConfig.php`, extends `ConfigFormBase`, form id
`ach_attach_js_attacher_config_form`.

- `buildForm()` reads `request_path` from config, instantiates the core `request_path` condition
  via `\Drupal::service('plugin.manager.condition')->createInstance('request_path', $config)`,
  stashes the plugin in `$form_state->set('request_condition', …)`, and embeds the plugin's own
  `buildConfigurationForm([], $form_state)` as `$form['request_path']`. So the UI is exactly core's
  block-visibility Pages/Negate widget, plus a static help paragraph.
- `submitForm()` retrieves the stashed condition (`$form_state->get(['request_condition'])`), calls
  its `submitConfigurationForm($form, $form_state)`, then
  `$config->set('request_path', $condition->getConfiguration())->save()`.

## Runtime attach logic

`ach_attach_js_attacher.module` → `hook_page_attachments()`:

```php
function ach_attach_js_attacher_page_attachments(array &$page) {
  $config = \Drupal::configFactory()->get('ach_attach_js_attacher.settings');
  if (!empty($config)) {
    $request_path_config = $config->get('request_path');
    if (isset($request_path_config)) {
      $condition_manager = \Drupal::service('plugin.manager.condition');
      $request_condition = $condition_manager->createInstance('request_path', $request_path_config);
      $condition_met = $request_condition->evaluate();
      $negated = $request_condition->isNegated();
      if ($condition_met xor $negated) {
        $page['#attached']['library'][] = 'ach_attach_js/ach-attach-js';
      }
    }
  }
}
```

- `evaluate()` returns whether the current path matches `pages`; `isNegated()` returns the negate
  flag. The `xor` makes "match + not negated" and "no-match + negated" both attach — the standard
  block visibility semantics. When it attaches, the parent library loads and its behavior wires up
  the Acquia Lift `acquiaLiftContentAvailable` listener (see the parent's `api/library.md`).

## Operating notes

- Path syntax is core Request Path syntax: leading `/`, one path per line, `*` wildcard, `<front>`
  for the front page.
- Changing paths takes effect on the next request; clear caches if a page render is cached.
- This module only controls *where the library loads*; the actual DOM work is done client-side by
  the parent's `js/ach-attach-js.js`.

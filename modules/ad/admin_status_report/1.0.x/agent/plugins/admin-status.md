<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AdminStatus plugin type, bundled plugins & display subscriber

## The plugin type

`src/AdminStatusPluginManager.php` (`AdminStatusPluginManager extends DefaultPluginManager`, service
`plugin.manager.admin_status_report`):

- discovery subdir `Plugin/AdminStatus`,
- interface `Drupal\admin_status_report\AdminStatusInterface`,
- annotation class `Drupal\Component\Annotation\Plugin` (so plugins use `@Plugin(...)`),
- cache key `admin_status_info` on `cache.default`.

`AdminStatusInterface` methods:

| Method | Purpose |
|---|---|
| `description()` | Label/description markup shown on the settings form. |
| `configForm($form, $form_state, $configValues)` | Return a form-element array for this plugin's options (or `[]`). |
| `configValidateForm(...)` | Validate submitted option values. |
| `configSubmitForm(...)` | Return the option values to persist under `plugin_status[<id>]['config']`. |
| `message($configValues)` | Return the message(s) to display: an array `['status' => level, 'message' => string|render-array]`, or an array of such arrays. |

`AdminStatusPluginBase` (`src/Plugin/AdminStatus/AdminStatusPluginBase.php`) extends core `PluginBase`
and provides no-op defaults (`description()` → `''`, `configForm()` → `$form`, `configSubmitForm()`
→ `[]`, `message()` → `[]`), so a plugin only overrides what it needs.

## Bundled plugin: CoreStatusReport (`core_status_report`)

`src/Plugin/AdminStatus/CoreStatusReport.php`, annotation
`@Plugin(id="core_status_report", name="Core Status Report", admin_permission="administer admin status")`.

- `configForm()` — a `checkboxes` element `message_type` with options **Errors** / **Warnings**.
- `message($configValues)`:
  - `\Drupal::service('system.manager')->listRequirements()` (the same data as
    `/admin/reports/status`),
  - keeps requirements whose `severity` is in the admin-selected set
    (`REQUIREMENT_WARNING` / `REQUIREMENT_ERROR`),
  - renders each matching requirement via `#theme => 'status_report'` + `renderer->renderPlain()`,
  - returns one message per matching requirement, `status` mapped from severity
    (`translateSeverityToStatus()`).

## Bundled plugin: DefaultMsg (`default_message`)

`src/Plugin/AdminStatus/DefaultMsg.php`, annotation `@Plugin(id="default_message", name="Default
Message", admin_permission="administer admin status")`.

- `configForm()` — a `select` `type` (status / warning / error) and a `textfield` `message`.
- `message($configValues)` — returns a single `['status' => <type>, 'message' => <text>]`.

## The display subscriber

`src/EventSubscriber/AdminStatusEventSubscriber.php` (service `admin_status_report.eventsubscriber`,
constructor args: the plugin manager, `renderer`, `messenger`, `config.factory`).

- Subscribes to `kernel.request` → `kernelRequest()`.
- Reads `admin_status_report.settings:plugin_status`; for each entry with `enabled` truthy:
  - `adminStatusManager->createInstance($plugin_id, ...)`,
  - `$plugin->message($config)`, normalising a single message to a one-element list,
  - for each non-empty message: if `message` is a render array, flatten with
    `renderer->renderPlain()`; then `messenger->addMessage($text, $message['status'])`.

Messages are therefore emitted through Drupal's standard messenger and appear wherever the active
theme renders status messages.

## Writing your own AdminStatus plugin

1. Create `src/Plugin/AdminStatus/MyReport.php` in your module.
2. Annotate with `@Plugin(id="my_report", name="My Report")` and extend `AdminStatusPluginBase`.
3. Override `configForm()`/`configSubmitForm()` for any options and `message($configValues)` to
   return the message(s).
4. Clear caches; the plugin appears on the settings form for enabling.

## Notes

- `message()` may return either a single `['status'=>…, 'message'=>…]` array or a list of them; the
  subscriber handles both.
- `DefaultMsg` message text is entered by a user holding `administer admin status report`; it is
  passed to the messenger as a plain string and rendered through core's status-messages template
  (Twig auto-escaping applies).
- `CoreStatusReport::message()` produces trusted core markup (`status_report` theme), not
  user-supplied HTML.

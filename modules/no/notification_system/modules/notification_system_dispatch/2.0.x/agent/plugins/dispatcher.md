<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `notification_system_dispatcher` plugin type (delivery channels)

A dispatcher is a delivery channel. The parent framework gathers notifications; a dispatcher sends
one user's notifications out over one medium.

## Pieces
- Manager `NotificationSystemDispatcherPluginManager` (service
  `plugin.manager.notification_system_dispatcher`), discovery dir
  `Plugin/NotificationSystemDispatcher`, interface `NotificationSystemDispatcherInterface`,
  annotation `@NotificationSystemDispatcher(id,label,description)`, base
  `NotificationSystemDispatcherPluginBase`, alter `notification_system_dispatcher_info`,
  cache key `notification_system_dispatcher_plugins`.

## Interface (`NotificationSystemDispatcherInterface`)
- Constants: `SEND_MODE_IMMEDIATELY=1`, `SEND_MODE_DAILY=2`, `SEND_MODE_WEEKLY=3`.
- `id()`, `label()`, `description()`.
- `settingsForm(): array` — form fields shown inside the site settings form under a per-dispatcher
  fieldset (`configure_dispatcher_<id>`). Base returns `[]`.
- `settingsFormValidate(&$form, FormStateInterface $form_state)` — base no-op.
- `settingsFormSubmit(array $values)` — persist the dispatcher's own config. `$values` is the
  subtree `configure_dispatcher_<id>`.
- `dispatch(UserInterface $user, array $notifications)` — **send**. Receives the recipient and one
  or more `model/NotificationInterface` objects (more than one only when a bundle/summary is sent).

## Writing one
```php
/**
 * @NotificationSystemDispatcher(
 *   id = "slack",
 *   label = @Translation("Slack"),
 *   description = @Translation("Send notifications to Slack.")
 * )
 */
class SlackDispatcher extends NotificationSystemDispatcherPluginBase implements ContainerFactoryPluginInterface {
  public function settingsForm() { /* webhook url field, etc. */ }
  public function settingsFormSubmit(array $values) { /* save config */ }
  public function dispatch(UserInterface $user, array $notifications) { /* POST to Slack */ }
}
```
The two shipped implementations are `mail` (`notification_system_dispatch_mail`) and `webpush`
(`notification_system_dispatch_webpush`), both documented in their own submodule trees.

## How dispatchers are surfaced
- `SettingsForm` (site config) loops every dispatcher definition, embeds its `settingsForm()` under
  a `configure_dispatcher_<id>` fieldset, and on submit calls `settingsFormSubmit()` with that
  subtree.
- `UserSettingsForm` renders a checkbox per dispatcher (enable/disable) plus a checkbox per
  notification group per dispatcher; changes autosave over AJAX into `user.data`.
- The queue worker instantiates the dispatcher by id and calls `dispatch()`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend plugin type + the join API

The `meeting_api_backend` plugin type is the extension point of the whole module. A backend
encapsulates one conferencing technology and knows how to produce a join URL for a meeting.

## Plugin type definition

- **Discovery**: `Plugin/MeetingApiBackend` namespace.
- **Attribute**: `Drupal\meeting_api\Attribute\Backend` (`#[Backend(id, label, description, deriver,
  forms)]`). `TARGET_CLASS`.
- **Interface**: `Drupal\meeting_api\BackendInterface` (extends `ConfigurableInterface`,
  `DerivativeInspectionInterface`, `PluginWithFormsInterface`).
- **Base class**: `Drupal\meeting_api\BackendPluginBase` (uses `PluginWithFormsTrait`; standard
  `getConfiguration()`/`setConfiguration()` merging with `defaultConfiguration()`).
- **Manager**: `Drupal\meeting_api\BackendPluginManager` (service, autowired; alter hook
  `meeting_api_backend_info`, cache bin `meeting_api_backend_plugins`).

### Plugin id gotcha

Per the `Backend` attribute docblock, the plugin id must be **identical to its group or prefixed
with the group** — e.g. for group `foo` the id must be `foo` or `foo:bar` — or the plugin will not
be discovered. (An implementation quirk of the attribute-based discovery.)

### Two plugin forms

`BackendInterface` defines two form operation keys, wired through the plugin `forms` map:

- `PLUGIN_FORM_CONFIGURE` = `'configure'` — the backend's settings, shown on the **server** form
  (`ServerForm`). Stored in `Server::$backend_config`.
- `PLUGIN_FORM_MEETING` = `'meeting'` — per-meeting settings, shown on the **meeting** form via
  `BackendSettingsWidget`. Stored in `Meeting::$backend_settings`.

A backend may declare either, both, or neither.

### `joinMeeting()`

```php
public function joinMeeting(MeetingInterface $meeting, MeetingAttendeeInterface $user): string;
```

Returns the join URL for that user; throws `Drupal\meeting_api\Exception\OperationException` on
failure. This is the one behavioural method every backend must implement.

## The uniform entry point: `MeetingManager`

`Drupal\meeting_api\MeetingManagerInterface` (service `Drupal\meeting_api\MeetingManager`, autowired
via `meeting_api.services.yml`).

```php
$url = \Drupal::service(\Drupal\meeting_api\MeetingManagerInterface::class)
  ->joinMeeting($meeting, $attendee);
```

Internally (`MeetingManager::joinMeeting`): reads `$meeting->getServerId()`, loads the
`meeting_api_server`, creates the backend instance from `$server->backend` + `$server->backend_config`,
and calls `$backend->joinMeeting($meeting, $attendee)`. Throws `OperationException` if the server is
missing. Note: the manager operates on the interfaces (`MeetingInterface`,
`MeetingAttendeeInterface`), not the concrete entity, so callers can pass any implementation.

## Attendees

`Drupal\meeting_api\MeetingAttendee` (implements `MeetingAttendeeInterface`) wraps a
`UserInterface` + a role string: `getId()` (user UUID), `getName()` (trimmed display name),
`getMeetingRole()`. This is the "who is joining, in what role" value passed to a backend.

## Backends that call an external API

`Drupal\meeting_api\Contract\Backend\BackendWithClientInterface` (extends `BackendInterface`) adds:

```php
public function getClient(): object; // MUST return a new, configured client each call
```

This is the intended seam for real provider integrations (Zoom, Teams, Jitsi, BigBlueButton…): the
backend builds an API client configured from its `backend_config` secrets. **No such backend ships
in this project** — the interface is a contract for third-party/companion modules. If you implement
one:

- Store API credentials in `backend_config` behind a Key entity / environment variable; the
  framework does not manage secrets for you.
- Configure the client with TLS verification enabled (do not disable peer verification).
- The returned join URL is a capability — gate the code path that hands it to a user.

## Writing a backend (shape)

```php
#[Backend(
  id: 'jitsi',
  label: new TranslatableMarkup('Jitsi'),
  forms: ['meeting' => MyJitsiMeetingForm::class, 'configure' => MyJitsiServerForm::class],
)]
final class Jitsi extends BackendPluginBase implements BackendWithClientInterface {
  public function defaultConfiguration(): array { return ['base_url' => '']; }
  public function joinMeeting(MeetingInterface $meeting, MeetingAttendeeInterface $user): string {
    // build/return a join URL, e.g. from $meeting->getSettings() + $this->configuration
  }
  public function getClient(): object { /* new configured client each call */ }
}
```

See [../submodules/index.md](../submodules/index.md) for the trivial reference implementation
(`meeting_api_manual`).

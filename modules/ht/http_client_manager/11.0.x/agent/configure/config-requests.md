# HTTP Config Requests, settings & actions

## HTTP Config Request config entity

`http_config_request` is a config entity storing a **pre-configured call**: a service API +
command + fixed parameters you can execute or reuse.

Exported keys (`config_export`): `id`, `label`, `uuid`, `service_api`, `command_name`, `parameters`.
Config name: `http_client_manager.http_config_request.<id>`.

```yaml
# http_client_manager.http_config_request.find_post.yml
id: find_post
label: 'Find post'
service_api: example_services
command_name: FindPost
parameters:
  postId: '1'
```

Create/execute in PHP:

```php
use Drupal\http_client_manager\Entity\HttpConfigRequest;

$req = HttpConfigRequest::create([
  'id' => 'find_post_3',
  'label' => 'Find post 3',
  'service_api' => 'example_services',
  'command_name' => 'FindPost',
  'parameters' => ['postId' => '3'],
]);
$req->save();

$result = HttpConfigRequest::load('find_post_3')->execute();  // runs the call
```

Manage them in the UI under `/admin/config/services/http-client-manager/{serviceApi}/{command}/http-config-request`
(list/add/edit/delete/execute routes are provided by the entity). Parameters support tokens
(e.g. `postId: '[current-user:uid]'`).

Read one back:

```bash
drush cget http_client_manager.http_config_request.find_post
```

## Settings (`http_client_manager.settings`)

| Key | Default | Meaning |
|---|---|---|
| `enable_overriding_service_definitions` | `1` | Whether `settings.php` / `overrides` may override API definitions. |
| `overrides` | (sequence) | Per-API override definitions applied when overriding is enabled. |

Settings form route: `http_client_manager.settings` → `/admin/config/services/http-client-manager/settings`.

## Action plugins (run a call as an Action)

- `http_client_manager_command` — executes an arbitrary API command (deriver
  `CommandDeriver`; config schema `action.configuration.http_client_manager_command:*:*`).
- `http_client_manager_preconfigured_request` — executes a saved `http_config_request` and can
  store the result (`received_result_storage`, `received_result_key`).

Both are usable anywhere Drupal Actions run (VBO, ECA, etc.).

## Events

`\Drupal\http_client_manager\Event\HttpClientEvents` — subscribe to the pre-execute event to alter
params/headers, or the handler-stack event to add Guzzle middleware, around every call.

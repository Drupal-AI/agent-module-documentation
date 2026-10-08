# Managing API keys (the `api_key` config entity)

`api_key` is a `@ConfigEntityType` (`src/Entity/ApiKey.php`). Each entity is one credential: a key
string bound to a Drupal user. Config prefix `api_key`, so entities are stored as config objects
named `services_api_key_auth.api_key.<id>` (schema `services_api_key_auth.api_key.*`).

## Admin routes

| Route | Path | Access |
|---|---|---|
| `entity.api_key.collection` | `/admin/config/services/api-key-auth` | perm `administer services_api_key_auth` |
| `entity.api_key.add_form` | `/admin/config/services/api-key-auth/add` | `_entity_create_access: api_key` |
| `entity.api_key.edit_form` | `/admin/config/services/api-key-auth/{api_key}/edit` | `_entity_access: api_key.edit` |
| `entity.api_key.delete_form` | `/admin/config/services/api-key-auth/{api_key}/delete` | `_entity_access: api_key.delete` |

Entity access uses `admin_permission = "administer services_api_key_auth"`. The collection
list (`ApiKeyListBuilder`) shows a row per key with columns **Machine name**, **API Key**, **User
UUID**. The `configure` route in `.info.yml` is `entity.api_key.collection`.

## Fields (`ApiKeyForm`)

| Property | Form element | Notes |
|---|---|---|
| `id` | `machine_name` | Entity id; immutable once created. |
| `label` | textfield (titled "Machine Name") | Human label, required. |
| `key` | textfield, `#maxlength: 42`, required | The secret. Default value pre-filled with a freshly generated key (see below); an admin may overwrite it with any string. |
| `user_uuid` | `entity_autocomplete` (`target_type: user`, `include_anonymous: TRUE`) | The user the key authenticates as. The form shows a user picker; on save it converts the selected **uid → the user's uuid** (`ApiKeyForm::getUuid()`), and stores the uuid. |

The entity is a config entity (`services_api_key_auth.api_key.<id>`) holding `id`, `label`, and
`user_uuid`. Treat each key as a live credential and manage it the way you manage other sensitive
configuration.

### Key generation

The add form's default key is `substr(hash('sha256', random_bytes(16)), 0, 32)` — a 32-character
lowercase-hex string derived from 128 bits of CSPRNG entropy. It is only a *default*; the field is
editable and required.

### Which user it maps to

`authenticate()` loads the user whose `uuid` equals the entity's `user_uuid` and runs the request as
that account. `include_anonymous: TRUE` means the picker also offers the anonymous user; any user
(including administrators) can be selected. Deleting a key removes access for callers using it.

## Creating a key programmatically

The uid→uuid conversion lives in the form, so when creating an entity in PHP set `user_uuid` to the
target user's **UUID** directly:

```php
$user = \Drupal\user\Entity\User::load(42);
\Drupal::entityTypeManager()->getStorage('api_key')->create([
  'id'        => 'partner_import',
  'label'     => 'Partner import job',
  'key'       => substr(hash('sha256', random_bytes(16)), 0, 32),
  'user_uuid' => $user->uuid(),
])->save();
```

To read an existing key value: `\Drupal::entityTypeManager()->getStorage('api_key')->load('partner_import')->key;`
(the `key` and `user_uuid` properties are public on the entity).

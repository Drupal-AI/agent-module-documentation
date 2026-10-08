# Managing consumer entities

`consumer` is a fieldable `@ContentEntityType` (`src/Entity/Consumer.php`). Manage instances at
the Consumers collection (route `entity.consumer.collection`); add via the
`AddConsumerAction` local action. There is no config-schema settings object — configuration is
the entities themselves (plus any fields you add).

Base fields:

| Field | Type | Purpose |
|---|---|---|
| `client_id` | string | The client identifier used to negotiate this consumer (auto-generated if empty). |
| `label` | string | Human name of the client app. |
| `description` | string_long | Free-text description. |
| `image` | image | Logo. |
| `third_party` | boolean | Marks an external/3rd-party client. |
| `is_default` | boolean | Exactly one consumer is the default; set via the **Make default** form (`MakeDefaultForm`). |
| `status` | boolean | Enable/disable the consumer. |

Because it is fieldable, attach extra fields (scopes, secret, allowed origins) through the
normal Field UI or in code — this is how modules like Simple OAuth extend the consumer. Access
is governed by `AccessControlHandler` and the permissions in
[../permissions/permissions.md](../permissions/permissions.md).

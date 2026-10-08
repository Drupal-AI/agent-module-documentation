<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePayco factory config entity

`epayco_factory` is a config entity holding one set of ePayco account settings. Create several to support
multiple merchant accounts or per-store overrides.

## Entity (`src/Entity/Factory.php`)

`@ConfigEntityType(id = "epayco_factory", config_prefix = "factory", admin_permission = "administer epayco factory")`.
`config_export`: `id`, `label`, `client_id`, `client_key`, `api_public_key`, `api_private_key`, `language_code`,
`mode`. Handlers: `list_builder` = `Controller\FactoryListBuilder`; forms `add`/`edit`/`delete` under `src/Form/`.

Getters: `getClientId()`, `getKey()`, `getApiPublicKey()`, `getApiPrivateKey()`, `getLanguageCode()`,
`isTestMode()`. `getFactoryClientInstance()` builds an `\Epayco\Epayco` SDK client from
`apiKey`=public key, `privateKey`=private key, `lenguage`=language code, `test`=mode (note the SDK's misspelled
`lenguage` key). Implements `FactoryInterface`.

## Fields (map to ePayco dashboard values)

| Property | ePayco name | Form label | Notes |
|----------|-------------|-----------|-------|
| `client_id` | `p_cust_id_cliente` | Client ID | max 15 chars, required |
| `client_key` | `p_key` | Key | required |
| `api_public_key` | `public_key` | Public key | required |
| `api_private_key` | `private_key` | Private key | required |
| `language_code` | — | Language code | 2 chars, e.g. `ES`/`EN`, required |
| `mode` | — | Test mode | boolean |

Schema: `config/schema/epayco.schema.yml` (`epayco.factory.*`).

## Forms (`src/Form/`)

- `FactoryFormBase` — shared build/validate/save; groups the two "Secret keys" details (`basic`: client id + key)
  and "Secret keys Api Rest" (`api`: public + private key). `save()` messages and redirects to the list.
- `FactoryAddForm`, `FactoryEditForm` (extend base), `FactoryDeleteForm` (confirm form).

## Routes (`epayco.routing.yml`) and links

- `entity.epayco_factory.list` — `/admin/config/services/epayco/factory`, `_permission: administer epayco factory`
  (this is the module `configure` route; menu link under *Configuration → Web services*).
- `entity.epayco_factory.add_form` — `.../add`, `_entity_create_access: epayco_factory`.
- `entity.epayco_factory.edit_form` — `.../{epayco_factory}/edit`, `_entity_access: epayco_factory.update`.
- `entity.epayco_factory.delete_form` — `.../{epayco_factory}/delete`, `_entity_access: epayco_factory.delete`.
- Action links (`epayco.links.action.yml`): "Add factory" / "List factories".

`FactoryListBuilder` shows label, machine name, and a "Data" item-list of the stored ePayco values plus mode.

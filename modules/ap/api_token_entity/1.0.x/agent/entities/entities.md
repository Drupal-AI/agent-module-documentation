<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities & fields

Two SQL-backed content entity types, both defined with PHP attributes and the core `AdminHtmlRouteProvider`. Entity keys for both: `id` => `id`, `label` => `name`. Both use `ApiTokenEntityAccessControlHandler` and are gated by `administer api_token_entity entities`.

## `api_token_entity_api_token` — API token

`src/Entity/ApiToken.php` (`#[ContentEntityType]`). Base table `api_token_entity_api_token`, data table `api_token_entity_api_token_field_data`. Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `type` | entity_reference → `api_token_entity_api_token_type` | required; `options_select` widget |
| `name` | string (255) | label "Consumer ID", required; constraints `UniqueField` + `MachineName`; identifies the consumer the token belongs to |
| `value` | string (255) | label "Token Value", required; auto-generated; **stored hashed** (see below); once set it cannot be retrieved |
| `expiration_date` | datetime (`datetime_type: date`) | required; defaults to `+1 year` on the create form |

**Token generation.** `ApiTokenManager::generateSecureApiTokenValue()` (static) returns `base64_encode(random_bytes(40))` — a CSPRNG-backed, ~320-bit value.

**Hashing on save.** `ApiToken::preSave()` hashes the stored value: `if (!empty($current_value) && (strlen($current_value) !== 32 || !ctype_xdigit($current_value))) { $this->set('value', md5($current_value)); }`. In other words, a plain value is `md5()`-hashed before storage; a value that already looks like a 32-char hex hash is left as-is (so re-saving does not double-hash). The plaintext is therefore only ever visible at creation/rotation time.

## `api_token_entity_api_token_type` — API token type

`src/Entity/ApiTokenType.php`. Base table `api_token_entity_api_token_type`. Single base field:

| Field | Type | Notes |
|---|---|---|
| `name` | string (255) | label "Name", required; `machine_name` widget; constraints `UniqueField` + `MachineName` |

The type's `name` is the identifier a protected route references (see [validation](../api/validation.md)).

## Forms

- **`ApiTokenEntityForm`** (`src/Form/ApiTokenEntityForm.php`, add/edit handler):
  - *New:* prefills `value` with `generateSecureApiTokenValue()` (rendered read-only) and `expiration_date` with `+1 year`.
  - *Edit:* disables `name` and `type`, hides the `value` field (`#access = FALSE`), and adds a **Rotate Token** submit. `rotateToken()` generates a fresh value, saves `md5($token)`, and shows the plaintext once via a message ("copy it now, it cannot be recovered").
  - `save()` redirects to the token collection.
- **`ApiTokenType`** uses core `ContentEntityForm` for add/edit (only the machine-name `name`).

## List builders

- **`ApiTokenListBuilder`** (`src/ApiTokenListBuilder.php`): columns Name / Type / Value / Expiration. The value is always masked (`••••••••••••••••`); rows whose `expiration_date` is in the past are prefixed with a `⛔` marker in the Name column. `render()` adds a "Create" button and an embedded **Validate Token** details form (`ApiTokenCheckerForm`).
- **`ApiTokenTypeListBuilder`** (`src/ApiTokenTypeListBuilder.php`): single Name column + "Create" button.

## Validation constraint

`MachineName` (`src/Plugin/Validation/Constraint/MachineNameConstraint*.php`) — rejects any name not matching `^[a-z0-9_.]+$` (lowercase letters, digits, underscore, dot). Applied to both entities' `name` fields alongside core `UniqueField`.

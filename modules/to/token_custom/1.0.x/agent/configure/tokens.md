<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create and manage custom tokens

Configure route: `entity.token_custom.collection` → `/admin/structure/token-custom`.

## Entity model

| Entity type | Kind | Purpose | Config/table |
|---|---|---|---|
| `token_custom` | Content entity (translatable) | one token | base table `token_custom` |
| `token_custom_type` | Config bundle entity | a token *type* (group) | `token_custom.type.<machineName>` |

A default type **`custom`** ships in `config/install/token_custom.type.custom.yml`. Tokens
resolve as `[<type_machineName>:<token_machine_name>]`, e.g. `[custom:greeting]`.

`token_custom` base fields: `name` (admin label), `machine_name` (id, ≤64 chars, `[a-z0-9_-]`),
`type` (entity_reference → token_custom_type; the bundle), `description`, `content`
(`text_long`: `value` + `format`), `langcode`.

## UI

- **Add a token:** `/admin/structure/token-custom` → *Add Token*. Enter Name, Machine name,
  pick the Token Type, write Content (with a text format), Save.
- **Add a token type:** *Custom Token Types* tab (`/admin/structure/token-custom/type`) →
  *Add Token Type*. Enter a Name and Machine name.
- Edit: `/admin/structure/token-custom/manage/{id}/edit`;
  delete: `.../manage/{id}/delete`.

## In code

Create a token:

```php
use Drupal\token_custom\Entity\TokenCustom;
TokenCustom::create([
  'machine_name' => 'company_name',
  'name'         => 'Company name',
  'type'         => 'custom',                 // the bundle (token type machine name)
  'description'  => 'Legal company name',
  'content'      => ['value' => 'Example Co., Ltd.', 'format' => 'plain_text'],
])->save();

// Use it:
$text = \Drupal::token()->replace('[custom:company_name]');   // "<p>Example Co., Ltd.</p>"
```

Create a new token type, then a token under it:

```php
use Drupal\token_custom\Entity\TokenCustomType;
use Drupal\token_custom\Entity\TokenCustom;
TokenCustomType::create(['machineName' => 'department', 'name' => 'Department', 'description' => 'Org data'])->save();
TokenCustom::create([
  'machine_name' => 'manager', 'name' => 'Manager', 'type' => 'department',
  'content' => ['value' => 'Jane Doe', 'format' => 'plain_text'],
])->save();
// [department:manager]  ->  "<p>Jane Doe</p>"
```

Note: `content` returned by tokens is run through `check_markup()` (the chosen text format),
so `plain_text` wraps the value in `<p>…</p>`. Use `getRawContent()` for the unformatted value.
Creating a token type invalidates the `token_custom.allowlist` cache so new types resolve
without a manual cache clear.

## Config export

A token *type* exports as config (`token_custom.type.<machineName>`). The tokens themselves
are **content entities**, not config — seed them with an update/hook or a default-content
mechanism, not `config/install`.

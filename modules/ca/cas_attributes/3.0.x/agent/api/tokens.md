<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAS attribute tokens

Implemented in `cas_attributes.tokens.inc` (two functions).

## Format

```
[cas:attribute:<attribute-name>]
[cas:attribute:<attribute-name>:<array-modifier>]
[cas:attribute:?]                 ← prints "Available attributes: a, b, c"
```

- The **attribute name must be lower-case** in the token; the module lower-cases the incoming
  attribute keys with `array_change_key_case()` before matching.
- CAS always stores attribute values as **arrays**. Without a modifier the module appends
  `:join`, so a multi-value attribute renders as a joined string.
- Any core "array" token modifier works, because the replacement is delegated to
  `\Drupal::token()->generate('array', …)`: `:first`, `:last`, `:count`, `:join`,
  `:keys`, `:reversed`, `:value:N`.

`cas_attributes_token_info_alter()` only *adds* the dynamic `attribute` token to the existing
`cas` token type provided by the CAS module — there is no new token type.

## Where the values come from

`cas_attributes_tokens()` looks in two places, in order:

1. `$data['cas_attributes']` — attributes passed explicitly into the token replacement. This
   is what `CasAttributesSubscriber::getFieldMappings()` does, which is why **user field
   mappings work even when sitewide token support is off**.
2. `$_SESSION['cas_attributes']` — written by `CasAttributesSubscriber::onPostLogin()` **only
   when `sitewide_token_support` is TRUE**, filtered through `token_allowed_attributes` when
   that list is non-empty.

So:

| Use case | Needs `sitewide_token_support` |
|---|---|
| `field.mappings` on the settings form | **no** |
| Token in a webform default value, block, view, mail body… | **yes** |
| `/admin/config/people/cas/attributes/available` page | **yes** (and you must be logged in via CAS) |

## Calling it from code

```php
$text = \Drupal::token()->replace(
  '[cas:attribute:mail]',
  ['cas_attributes' => $casPropertyBag->getAttributes()],
  ['clear' => TRUE]
);
```

`['clear' => TRUE]` removes tokens that have no value — the subscriber uses this and then
`trim()`s and `html_entity_decode()`s the result, and skips the field entirely when the
result is empty.

## The "Available Attributes" page

Route `cas_attributes.available_attributes` → `/admin/config/people/cas/attributes/available`
(`CasAttributesListController::content()`). It renders a table of *Name / Token / Value* for
the current session, cached per `session`. It shows errors instead when
`sitewide_token_support` is off, or when the session is not `is_cas_user`.

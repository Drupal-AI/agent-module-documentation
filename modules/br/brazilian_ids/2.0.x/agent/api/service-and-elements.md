<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service + Form API elements

Install/enable: `drush en brazilian_ids`. Core-only; no config to import. Optional: enable
`drupal/mask` for live input masks on the CPF/CNPJ inputs.

## The `brazilian_ids` service

Defined in `brazilian_ids.services.yml`; class `Drupal\brazilian_ids\BrazilianIdsService`
implementing `BrazilianIdsServiceInterface` (uses `StringTranslationTrait`). Get it with
`\Drupal::service('brazilian_ids')` or inject the `brazilian_ids` service id.

Methods (all take a raw string; validators fill `&$error['message']` on failure):

- `clean($value)` — returns `str_replace([' ', '.', '-', '/'], '', $value)`, or `NULL` if unset. This
  is what strips the mask/separators before storage.
- `validateCpf($value, &$error = [])` → bool. Requires exactly 11 digits (`/^[0-9]{11}$/`), rejects the
  ten all-same-digit sequences (`00000000000`…`99999999999`), then verifies the two CPF check digits
  (mod-11). Empty/unset value returns FALSE without an error message.
- `validateCnpj($value, &$error = [])` → bool. Requires exactly 14 digits, rejects all-same-digit
  sequences, then verifies the two CNPJ check digits.
- `validateCpfCnpj($value, &$error = [])` → bool. 11 digits → `validateCpf`, 14 digits → `validateCnpj`,
  anything else → error "does not match a CPF or a CNPJ number".
- `formatCpf($value)` — if 11 digits, returns `000.000.000-00`; otherwise returns the value unchanged.
- `formatCnpj($value)` — if 14 digits, returns `00.000.000/0000-00`; otherwise unchanged.
- `formatCpfCnpj($value)` — dispatches to `formatCpf`/`formatCnpj` by digit count.

Validation is purely numeric (regex + arithmetic); no external calls, no I/O.

## Form API render elements (`src/Element/`)

Use these `#type`s in any form array.

### `brazilian_ids_cpf` / `brazilian_ids_cnpj` / `brazilian_ids_cpf_cnpj`

`CpfElement`, `CnpjElement`, `CpfCnpjElement` all extend `CpfCnpjBase extends
Drupal\Core\Render\Element\Textfield` (implements `ContainerFactoryPluginInterface`, injects
`module_handler`). Shared behaviour in `CpfCnpjBase::getInfo()`:

- `#size = 20`; adds `#element_validate => [[class, 'validateElement']]`.
- `valueCallback()` runs the raw input through `\Drupal::service('brazilian_ids')->clean()` — so the
  form value is already digits-only.
- `validateElement()` calls `static::validateValue()` and, on failure, `$form_state->setError()` with
  `$error['message']`.
- `validateValue()` is overridden per type: CPF → `validateCpf`, CNPJ → `validateCnpj`, base/combined →
  `validateCpfCnpj`.
- Per-type `getInfo()`: CPF `#maxlength = 14`; CNPJ `#maxlength = 18`; combined `#maxlength = 18`.
- Masking: `CpfElement`/`CnpjElement` supply a static mask via `getMaskDefaults()` and, when `mask` is
  enabled, call `\Drupal\mask\Helper\ElementHelper::elementInfoAlter()`. `CpfCnpjElement` instead adds a
  `#process` callback `processMask()` that, when `mask` is enabled, attaches CSS class
  `brazilian-ids-cpf-cnpj-mask` + library `brazilian_ids/brazilian_ids_mask` (JS chooses the CPF vs CNPJ
  mask by length).

They otherwise accept the same properties as a core textfield. Example:

```php
$form['cpf'] = ['#type' => 'brazilian_ids_cpf', '#title' => t('CPF'), '#required' => TRUE];
$form['cpf_cnpj'] = ['#type' => 'brazilian_ids_cpf_cnpj', '#title' => t('CPF or CNPJ')];
```

### `brazilian_ids_rg`

`RgElement extends Drupal\Core\Render\Element\FormElement`. Extra `#` properties (from `getInfo()`):

- `#default_value` — assoc array with `number`, `agency`, `state`.
- `#number_only` (bool, default FALSE) — when TRUE, only the number sub-field is rendered (as a plain
  container instead of a fieldset).
- `#clean_number` (bool, default FALSE) — when TRUE the submitted number is run through the service's
  `clean()`; otherwise only spaces are removed.
- `#state_options` — assoc array of state codes; defaults to all 27 Brazilian UF codes (AC…TO).

`processElement()` builds a `#tree` sub-form with `number` (textfield, maxlength 20), and when not
number-only `agency` (textfield, maxlength 60) and `state` (select with `#empty_value => ''`).
`valueCallback()` cleans/trims the parts. `validateElement()` enforces all-or-nothing: if any property
is filled, every empty one raises a "must be provided" error.

```php
$form['rg'] = ['#type' => 'brazilian_ids_rg', '#title' => t('RG'), '#clean_number' => TRUE];
```

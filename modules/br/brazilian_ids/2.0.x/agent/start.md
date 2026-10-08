<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brazilian IDs (brazilian_ids) — agent index

Validated **CPF / CNPJ / RG** support for Brazilian identification numbers, as **Field UI widgets**,
an **RG field type**, **field formatters**, and **Form API render elements**. Package `Field`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.1.

- **No dependencies** (core only). Optional runtime integration with **`mask`** (input masking).
- **No routes, no permissions, no settings page, no Drush, no hooks, no `.install`.** All config is
  per-field via the standard Field UI. Provides config schema only.

## What it provides (all grounded in `src/`)

- **One service** `brazilian_ids` (`BrazilianIdsService`, interface `BrazilianIdsServiceInterface`):
  `clean()`, `validateCpf()`, `validateCnpj()`, `validateCpfCnpj()`, `formatCpf()`, `formatCnpj()`,
  `formatCpfCnpj()`. All validation/formatting logic lives here.
- **Four Form API render elements** (`src/Element/`): `brazilian_ids_cpf` (`CpfElement`),
  `brazilian_ids_cnpj` (`CnpjElement`), `brazilian_ids_cpf_cnpj` (`CpfCnpjElement`) — all extend
  `CpfCnpjBase` (a core `Textfield`) — and `brazilian_ids_rg` (`RgElement`, a `FormElement` with
  number/agency/state sub-fields).
- **Three widgets for the core `string` field** (`src/Plugin/Field/FieldWidget/`): `brazilian_ids_cpf`
  (`CpfWidget`), `brazilian_ids_cnpj` (`CnpjWidget`), `brazilian_ids_cpf_cnpj` (`CpfCnpjWidget`) — each
  wraps the matching render element.
- **One field type** `brazilian_ids_rg` (`RgItem`) with widget `brazilian_ids_rg_default`
  (`RgDefaultWidget`).
- **Formatters** (`src/Plugin/Field/FieldFormatter/`): for `string` fields — `brazilian_ids_cpf`,
  `brazilian_ids_cnpj`, `brazilian_ids_cpf_cnpj` (extend core `StringFormatter`, format via the service);
  for `brazilian_ids_rg` fields — `brazilian_ids_rg_default`, `brazilian_ids_rg_number`,
  `brazilian_ids_rg_agency`, `brazilian_ids_rg_state`.
- **JS library** `brazilian_ids/brazilian_ids_mask` (`js/brazilian_ids_mask.js`, deps `core/once` +
  `mask/mask_plugin`) — only attached when the `mask` module is enabled.

## Solution docs

- **Service, Form API elements, and how validation/cleaning/formatting work** →
  [api/service-and-elements.md](api/service-and-elements.md)
- **The string-field widgets, the RG field type, and all formatters (Field UI + display)** →
  [fields/widgets-and-formatters.md](fields/widgets-and-formatters.md)

## Notes

- Values are **cleaned** (spaces, `.`, `-`, `/` stripped) before validation/storage; CPF stores as 11
  digits, CNPJ as 14.
- These are personal/tax identifiers — treat stored values as sensitive data.

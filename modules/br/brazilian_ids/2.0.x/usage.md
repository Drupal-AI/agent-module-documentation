<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brazilian IDs provides validated CPF/CNPJ text-field widgets, an RG field type, matching field formatters and CPF/CNPJ/RG Form API element types for Brazilian identification numbers.

---

Brazilian IDs adds first-class support for the three common Brazilian identifiers — CPF (individual
taxpayer number), CNPJ (company registration number) and RG (state identity card) — to both entity
fields and custom forms. On the Field UI it offers three widgets for the core `string` field
(`brazilian_ids_cpf`, `brazilian_ids_cnpj`, `brazilian_ids_cpf_cnpj`) plus a dedicated `brazilian_ids_rg`
field type that stores number, issuing agency and two-letter state. It ships a family of field
formatters that render CPF/CNPJ with their canonical separators (`000.000.000-00` /
`00.000.000/0000-00`) and RG in default/number/agency/state variants. For the Form API it registers
four render-element types (`brazilian_ids_cpf`, `brazilian_ids_cnpj`, `brazilian_ids_cpf_cnpj`,
`brazilian_ids_rg`) so developers can drop validated ID inputs into any form. All CPF/CNPJ validation
and formatting lives in the reusable `brazilian_ids` service. Values are validated server-side using
the official check-digit algorithms; input is "cleaned" (spaces, dots, hyphens and slashes stripped)
before storage. If the optional Mask module is enabled, the CPF/CNPJ inputs gain a live input mask.
The module has no routes, no permissions and no settings page — configuration happens per field via the
standard Field UI. Note that CPF/CNPJ/RG are personal/tax data; handle and store them with appropriate
privacy care.

---

- Add a validated CPF (individual taxpayer) widget to a text field.
- Add a validated CNPJ (company) widget to a text field.
- Accept either a CPF or a CNPJ in one combined widget.
- Collect a full RG (number, issuing agency, state) with the dedicated RG field type.
- Store only the RG number by enabling the field's "Number only" storage setting.
- Display CPF/CNPJ values formatted with separators via the CPF, CNPJ or CPF/CNPJ formatters.
- Display an RG as number-only, agency-only or state-only using the per-property formatters.
- Add a CPF input to a custom form with `'#type' => 'brazilian_ids_cpf'`.
- Add a CNPJ input to a custom form with `'#type' => 'brazilian_ids_cnpj'`.
- Add a combined CPF/CNPJ input with `'#type' => 'brazilian_ids_cpf_cnpj'`.
- Add an RG input (number/agency/state) with `'#type' => 'brazilian_ids_rg'`.
- Reuse the `brazilian_ids` service to validate an arbitrary CPF string programmatically.
- Reuse the service to validate a CNPJ string, or to auto-detect CPF vs CNPJ by digit count.
- Format a raw 11/14-digit string into its canonical CPF/CNPJ display form in your own code.
- Strip masks from a user-entered number with the service's `clean()` helper before persisting.
- Collect CPF/CNPJ on user registration or profile forms for Brazilian sites.
- Capture a customer's CNPJ on a checkout or order form.
- Reject sequences of repeated digits (e.g. `11111111111`) and wrong check digits automatically.
- Enable the Mask module to give editors a live CPF/CNPJ input mask.
- Have the RG widget optionally strip dots/hyphens/slashes from the number on submission ("Clean number").
- Require all RG sub-fields together (partial RG entries are rejected during validation).
- Build Brazil-specific address, HR or membership forms that need tax-ID capture.

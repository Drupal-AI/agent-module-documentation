<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Business Identity Local - Italy (business_identity_local_it) — agent index

Submodule of **Business Identity** that adds an **Italy** section to the parent's *Local Laws*
tab. Depends on `business_identity:business_identity`. Package `Business Identity`. Core `^11`.
License GPL-2.0-or-later. Version 1.0.2. **No routes, no permissions, no services, no block** — it
is purely hook implementations in `business_identity_local_it.module`, plus config schema and a
(form) library.

## Hooks it implements (all invoked by `BusinessIdentityForm` in the parent)

- `hook_business_identity_local_laws()` — region metadata: name *Italy*, code `IT`, icon 🇮🇹,
  description, and a `regulations` list (GDPR, Italian Privacy Code, electronic invoicing, AML).
- `hook_business_identity_local_laws_fields()` — Italian Form-API fields, grouped into fieldsets:
  **Business Identification** (`cin` with `IT` prefix), **VAT/IVA** (`iva_number`, `iva_regime`,
  `iva_rate` 22/10/5/4), **Electronic Invoicing** (`fatturazione_enabled`, `sdi_code`,
  `pec_email`), **Privacy & GDPR** (`gdpr_compliant`, `privacy_policy_it`, `cookie_policy_it`,
  `dpo_required`, `dpo_contact`), **Additional** (`rea_registration`, `rea_office`,
  `share_capital`, `ateco_code`). Several use `#states` for conditional visibility/required.
- `hook_business_identity_local_laws_tokens()` — token labels shown in the parent's Tokens tab.
- `hook_business_identity_local_laws_validate($values, $form_state)` — returns field→error:
  CIN must be 11 digits and pass `_business_identity_local_it_validate_cin()` (mod-10 check
  digit); Partita IVA validated the same way (`_business_identity_local_it_validate_iva()` is an
  alias); SDI code `^[A-Z0-9]{7}$`; PEC email valid + typically ends `.pec.it`/`.pec.com`; DPO
  contact email; ATECO `^[0-9]{2}(\.[0-9]{2}){0,2}$`.

## Real token integration (unlike the base module, these work)

- `hook_tokens()` (`business_identity_local_it_tokens`) and `hook_token_info()`
  (`business_identity_local_it_token_info`) implement `[business:local_laws_it_*]` tokens
  (`cin`, `cin_full` = `IT`+value, `iva_number`, `iva_regime` label, `iva_rate`, `sdi_code`,
  `pec_email`, `gdpr_compliant` yes/no, `rea_registration`, `ateco_code`), reading from
  `business_identity.settings:local_laws.business_identity_local_it`.

## Config & storage

- Schema `config/schema/business_identity_local_it.schema.yml` defines the mapping
  `business_identity.local_laws.business_identity_local_it` (all the fields above).
- Values are persisted by the **parent** form under
  `business_identity.settings:local_laws.business_identity_local_it` — this submodule writes no
  config of its own.
- `business_identity_local_it.libraries.yml` defines a `form` library (CSS/JS under `css/`, `js/`).

## Access / security note

No routes or callbacks of its own; all data entry and display go through the parent module's
admin-only form (`administer business identity`) and tokens. Validation is server-side. Nothing
here is reachable anonymously.

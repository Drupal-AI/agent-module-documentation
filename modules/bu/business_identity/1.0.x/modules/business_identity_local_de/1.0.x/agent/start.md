<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Business Identity Local - Germany (business_identity_local_de) — agent index

Submodule of **Business Identity** that adds a **Germany** section to the parent's *Local Laws*
tab. Depends on `business_identity:business_identity`. Package `Business Identity`. Core `^11`.
License GPL-2.0-or-later. Version 1.0.2. **No routes, no permissions, no services, no block** — it
is purely a set of hook implementations in `business_identity_local_de.module`, plus config schema
and a (form) library.

## Hooks it implements (all invoked by `BusinessIdentityForm` in the parent)

- `hook_business_identity_local_laws()` — region metadata: name *Germany*, code `DE`, icon 🇩🇪,
  description, and a `regulations` list (TMG, DSGVO, UStG, Impressum, Streitschlichtung).
- `hook_business_identity_local_laws_fields()` — the German Form-API fields, grouped into
  fieldsets: **Company Identification** (`ust_idnr` with `DE` prefix, `handelsregisternummer`),
  **VAT** (`vat_number`, `vat_regime`, `vat_rates` checkboxes 19/7/0), **Impressum**
  (`impressum_required`, `gesetzlicher_vertreter`, `aufsichtsbehoerde`, `berufsbezeichnung`),
  **Privacy/DSGVO** (`dsgvo_compliant`, `datenschutzerklaerung_url`, `datenschutzbeauftragter`,
  `dsb_contact`), **E-Commerce** (`agb_url`, `widerrufsrecht_url`, `streitschlichtung`,
  `streitschlichtungsstelle`), **Industry** (`industrie_kennzeichen`, `kammerzugehoerigkeit`),
  **Financial** (`stammkapital`, `umsatzsteuer_id`, `bank_name`, `iban`, `bic`). Many use
  `#states` for conditional visibility/required.
- `hook_business_identity_local_laws_tokens()` — token labels shown in the parent's Tokens tab.
- `hook_business_identity_local_laws_validate($values, $form_state)` — returns field→error:
  USt-IdNr must be 9 digits and pass `_business_identity_local_de_validate_ust_idnr()` (weighted
  mod-10 check digit); German VAT number pattern; IBAN `DE` + 20 digits validated by
  `_business_identity_local_de_validate_iban()` (mod-97); BIC pattern; URL / DPO-email checks.

## Real token integration (unlike the base module, these work)

- `hook_tokens()` (`business_identity_local_de_tokens`) and `hook_token_info()`
  (`business_identity_local_de_token_info`) implement `[business:local_laws_de_*]` tokens
  (`ust_idnr`, `ust_idnr_full` = `DE`+value, `handelsregisternummer`, `vat_number`, `vat_regime`
  label, `gesetzlicher_vertreter`, `datenschutzerklaerung_url`, `agb_url`, `widerrufsrecht_url`,
  `dsgvo_compliant` yes/no, `kammerzugehoerigkeit`, `stammkapital` + €), reading from
  `business_identity.settings:local_laws.business_identity_local_de`.

## Config & storage

- Schema `config/schema/business_identity_local_de.schema.yml` defines the mapping
  `business_identity.local_laws.business_identity_local_de` (all the fields above).
- Values are persisted by the **parent** form under
  `business_identity.settings:local_laws.business_identity_local_de` — this submodule writes no
  config of its own.
- `business_identity_local_de.libraries.yml` defines a `form` library (CSS/JS under `css/`, `js/`).

## Access / security note

No routes or callbacks of its own; all data entry and display go through the parent module's
admin-only form (`administer business identity`) and tokens. Validation is server-side. Nothing
here is reachable anonymously.

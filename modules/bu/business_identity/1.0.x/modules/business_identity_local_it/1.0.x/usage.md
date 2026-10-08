Business Identity Local - Italy adds Italian legal-requirement fields (CIN, Partita IVA, electronic invoicing, PEC, GDPR, REA/ATECO) into the Business Identity "Local Laws" configuration tab.

---

This submodule of Business Identity plugs an Italy section into the parent module's Local Laws tab through the `hook_business_identity_local_laws*` hooks. It contributes Italian-specific fields — CIN (Codice Identificativo Nazionale), Partita IVA (VAT number), VAT regime and rate, electronic-invoicing settings (SDI destination code, PEC certified email), GDPR/privacy compliance (privacy and cookie policy URLs, data-protection-officer contact), and additional registry data (REA registration number and office, share capital, ATECO activity code). It validates CIN/VAT with the Italian mod-10 checksum and checks SDI, PEC and ATECO formats, and exposes the stored values as `[business:local_laws_it_*]` tokens via a real `hook_tokens` implementation. It has no routes, permissions or UI of its own; everything is administered through the parent module's admin form and stored in the parent's config object. Requires the `business_identity` module.

---

- Record an Italian business's CIN (Codice Identificativo Nazionale, IT + 11 digits).
- Store the Partita IVA (Italian VAT number, 11 digits).
- Select the applicable VAT regime (Ordinario, Forfettario, Agricolo, Semplificato, etc.).
- Set the standard VAT rate (22% / 10% / 5% / 4%).
- Enable electronic invoicing (Fatturazione Elettronica) as required for B2B/B2C.
- Record the SDI destination code (Codice Destinatario, 7 characters) for e-invoicing.
- Store the PEC certified email address for official communications.
- Configure GDPR / Italian Privacy Code (D.Lgs. 196/2003) compliance status.
- Store Italian privacy-policy and cookie-policy URLs.
- Record whether a Data Protection Officer (DPO) is required and their contact email.
- Capture the REA registration number and the Chamber of Commerce office of registration.
- Record share capital (Capitale Sociale) in euros.
- Store the ATECO business-activity classification code.
- Validate the CIN / Partita IVA with the Italian check-digit algorithm before saving.
- Validate SDI code (7 uppercase alphanumerics), PEC email and ATECO code (XX.XX.XX) formats.
- Output any Italian legal value into content, blocks or mails via `[business:local_laws_it_*]` tokens (e.g. `[business:local_laws_it_cin_full]`, `[business:local_laws_it_sdi_code]`).

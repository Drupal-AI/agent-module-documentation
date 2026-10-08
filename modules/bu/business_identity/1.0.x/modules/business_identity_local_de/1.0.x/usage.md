Business Identity Local - Germany adds German legal-requirement fields (VAT IDs, commercial register number, Impressum, GDPR/DSGVO, e-commerce policy URLs) into the Business Identity "Local Laws" configuration tab.

---

This submodule of Business Identity plugs a Germany section into the parent module's Local Laws tab through the `hook_business_identity_local_laws*` hooks. It contributes a form of German-specific fields — USt-IdNr (EU VAT ID), Handelsregisternummer, domestic VAT number/regime/rates, Impressum details (legal representative, supervisory authority, professional title), DSGVO/GDPR settings (privacy policy URL, data-protection-officer contact), e-commerce policy URLs (AGB, Widerrufsrecht, dispute resolution), industry certifications, chamber membership, share capital and optional bank details (IBAN/BIC). It validates several of these (USt-IdNr checksum, German IBAN mod-97, BIC pattern, URL formats) and exposes the stored values as `[business:local_laws_de_*]` tokens via a real `hook_tokens` implementation. It has no routes, permissions or UI of its own; everything is administered through the parent module's admin form and stored in the parent's config object. Requires the `business_identity` module.

---

- Record a German company's USt-IdNr (EU VAT identification number, DE + 9 digits) for B2B/EU transactions.
- Store the commercial register number (Handelsregisternummer, HRB/HRA) from the local Amtsgericht.
- Capture the domestic VAT number (Umsatzsteuernummer) and the applicable VAT regime.
- Select applicable VAT rates (19% standard, 7% reduced, 0% exempt).
- Flag whether an Impressum (legal notice under TMG §5) is required for the website.
- Record the legal representative (Geschäftsführer/Vorstand) and supervisory authority for the Impressum.
- Configure DSGVO/GDPR compliance status and the Datenschutzerklärung (privacy policy) URL.
- Record whether a Data Protection Officer (Datenschutzbeauftragter) is required and their contact email.
- Store e-commerce policy URLs: AGB (terms) and Widerrufsrecht (right of withdrawal).
- Indicate participation in consumer dispute resolution (Streitschlichtung) and the responsible body.
- Select industry-specific certifications/licenses (Handwerksrolle, BaFin, Heilberufe, etc.).
- Record chamber membership (IHK, Handwerkskammer).
- Capture share capital (Stammkapital) for GmbH/UG entities.
- Optionally store German bank details (bank name, IBAN, BIC) with format validation.
- Validate the USt-IdNr with its check-digit algorithm before saving.
- Validate a German IBAN (DE + 20 digits, mod-97) and BIC (8/11 characters) on input.
- Output any German legal value into content, blocks or mails via `[business:local_laws_de_*]` tokens (e.g. `[business:local_laws_de_ust_idnr_full]`, `[business:local_laws_de_agb_url]`).

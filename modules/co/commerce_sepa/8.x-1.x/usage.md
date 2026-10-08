<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce SEPA is an on-site SEPA Single Euro Payments Area payment method.

---

Commerce SEPA provides an **on-site SEPA direct-debit payment method** for Drupal Commerce — collecting the
customer's IBAN and a SEPA mandate at checkout so funds can later be pulled via the SEPA scheme. It depends on
Commerce Payment, in the Commerce (contrib) package.

Use it to accept SEPA direct debit. It is an e-commerce/payment feature with an important nuance: SEPA direct
debit is **asynchronous and mandate-based** — the module records the IBAN + mandate at checkout, but actual
settlement (and any failure/chargeback) happens later through the banking system, not confirmed online at
checkout, so an order marked "processing" is not yet guaranteed paid. Handle the **IBAN/mandate data** as
sensitive customer/bank data (store/transmit securely, HTTPS), and reconcile settlement out of band. It has no
access-control role. Configure the SEPA creditor/mandate settings.

---

- Accept SEPA direct debit.
- Collect IBAN + a SEPA mandate.
- Pull funds via the SEPA scheme.
- Depend on Commerce Payment.
- Record the mandate at checkout.
- KNOW SEPA is asynchronous/mandate-based.
- Know an order isn't guaranteed paid at checkout.
- Reconcile settlement out of band.
- Handle IBAN/mandate as sensitive data (HTTPS).
- Have no access-control role.
- Configure the creditor/mandate settings.
- Handle SEPA payments.
- Collect mandates.
- Configure the gateway.
- Take direct debits.
- Handle the mandate.
- Process SEPA.
- Store IBANs securely.
- Configure SEPA.
- Provide SEPA payment.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce MAIB provides Commerce integration for the MAIB Gateway.

---

Commerce MAIB provides a Drupal Commerce payment gateway for MAIB (Moldova Agroindbank) — an offsite
redirect gateway where the customer pays on MAIB and the result is confirmed via MAIB's API. It depends on
Drupal Commerce, in the Commerce (contrib) package.

Use it to accept MAIB payments. Its security model is certificate-based and server-authoritative: it
authenticates to MAIB using a **client certificate (extracted from the bank-provided PFX)** and RSA public/
private keys, and confirms the transaction by querying MAIB's API (server-side) rather than trusting a
client-side result — the correct pattern. When adopting: store the **certificate/private key and the PFX
password securely** (readable only by the server, never web-exposed or committed), keep the private key file
outside the web root, and operate over HTTPS. Configure the MAIB certificate/keys.

---

- Provide a MAIB payment gateway.
- Redirect the customer to MAIB.
- Confirm the transaction via MAIB's API.
- Depend on Drupal Commerce.
- Authenticate with a client certificate (from the PFX).
- Use RSA public/private keys.
- Confirm server-side (not a client result).
- Store the certificate/private key + PFX password securely.
- Keep the private key outside the web root.
- Operate over HTTPS.
- Have no access-control role.
- Configure the MAIB certificate/keys.
- Handle MAIB payments.
- Process payments securely.
- Configure the gateway.
- Handle keys securely.
- Accept card payments.
- Confirm transactions.
- Handle the certificate.
- Process MAIB charges.

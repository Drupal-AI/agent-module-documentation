# Configuration

Configuring the module is a two-way exchange of trust: your Drupal IdP publishes
metadata (an entity ID, SSO/SLO URLs and a signing certificate) that each Service
Provider imports, and in return you register each SP's details in Drupal. Get those
two halves right and SSO works; the security of the whole setup rests on protecting
the signing key and registering only the SPs you intend.

## Open the IdP setup

Log in as an administrator and open the module's **IdP Setup** configuration (route
`miniorange_saml_idp.idp_setup`), under the miniOrange section of the admin menu.

## 1. Publish your IdP metadata to each Service Provider

The setup screen exposes Drupal's **IdP metadata** — the entity ID, the SSO
endpoint (and Single Logout endpoint), and the X.509 signing certificate. Give this
metadata (or its individual values) to each Service Provider so it can trust
assertions coming from Drupal. Many SPs accept a metadata URL or file directly.

## 2. Register a Service Provider

For each application you want to connect, add a Service Provider entry and provide:

- **SP entity ID / issuer** — the SP's unique identifier.
- **ACS (Assertion Consumer Service) URL** — where Drupal posts the SAML response
  after authenticating the user. Enter this **exactly** as the SP specifies;
  registering a wrong or attacker-controlled ACS URL would send assertions to the
  wrong place, so treat this field with care.
- Optionally the SP's certificate, and whether the response is signed and the
  assertion encrypted.

Register **only** SPs you actually intend to trust. The community tier supports a
single SP; connecting multiple SPs is a premium capability.

## 3. Choose SP- or IdP-initiated SSO

The module supports both **SP-initiated** SSO (the user starts at the app, which
redirects to Drupal) and **IdP-initiated** SSO (the user starts at Drupal and
launches into the app). Enable whichever flow your SPs use — IdP-initiated and
Single Logout are premium capabilities.

## 4. Map and release attributes

Decide which user information Drupal sends in the assertion — typically name, email
and roles, plus any constant or profile-module attributes the SP expects. Map
Drupal user fields to the SAML attribute names the SP wants, and **release only the
minimum** each SP needs. Over-sharing attributes is a privacy risk with no upside.

## 5. Signing, encryption, and the private key

The IdP **signs** assertions so SPs can verify they came from Drupal; you can also
**encrypt** assertions and generate a **custom certificate** for signing/encryption
(encryption and custom certificates are premium).

> **Protect the signing private key.** Whoever holds it can forge assertions for any
> SP. Keep it out of version control. Where you supply key material or SP secrets
> from outside the module, store them as secrets — for example an environment
> variable exposed through a Key entity:
>
> ```bash
> ddev dotenv set .ddev/.env --saml-idp-secret=<value>
> ddev restart
> ```
>
> Never paste a long-lived secret into a file that gets committed.

## 6. (Optional) Two-factor after SSO

Premium tiers can add a Two-Factor Authentication step around SSO login (for
example an OTP by phone or email) via miniOrange's TFA module.

## Save and test

Save your configuration, then run a test login from the SP side (SP-initiated) or
launch the app from Drupal (IdP-initiated). Confirm the user is signed in at the SP
with the expected attributes, and — if you enabled it — that Single Logout ends the
session across connected apps.

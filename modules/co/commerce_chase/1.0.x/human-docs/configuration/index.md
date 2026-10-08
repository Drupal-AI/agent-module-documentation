# Configuration

Commerce Chase is configured like any Commerce payment gateway: you add a gateway
and provide the Chase / Orbital details for your merchant account.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a name and display label, and choose the **Orbital® Hosted Payment
   Form** plugin.
3. Enter your Orbital account details:
   - **Secure Account ID** — your Hosted Payment account (the `hostedSecureID`).
   - **API Username** and **API Password** — your Orbital connection credentials.
   - **Terminal ID** — your Orbital Gateway TerminalID (defaults to `001`).
   - **Merchant ID** — found under the Account tab in your Chase Orbital account;
     this is *not* the username you log in with.
   - **Bin Number** — `Stratus` (`000001`) or `PNS` (`000002`), per your account.
4. Optionally set which **card brands** show on the form and whether the card
   fields are the minimum set or **all** mandatory.
5. Choose **test** or **live** mode and save. Test mode uses Chase's `-var` /
   `wsvar1` sandbox endpoints; live mode uses the production endpoints.

## How it works

The gateway embeds Orbital's **Hosted Payment Form** in an iframe. The customer
enters their card details in that Chase-hosted form, which tokenizes the card and
returns a token plus a masked card number — the raw card number and security code
stay on Chase's page and are never posted to your server. The gateway then calls
Chase's **Orbital SOAP API** to authorize, capture, and void the charge, using the
Merchant ID, Terminal ID, BIN, and (for stored-profile operations) the API
username and password you configured.

## Keep your credentials safe

The Orbital API username, password, Merchant ID and Secure Account ID are
sensitive. Handle them with care:

- **Restrict who can administer payment gateways.** Anyone with that permission can
  view and change the gateway configuration.
- **Keep credentials out of version control.** If you export configuration
  (config sync), review what you commit and use per-environment overrides or
  environment variables for secret values rather than committing them.
- **Serve checkout — and the admin — over HTTPS** end-to-end.
- **Match your PCI configuration to the card-data flow.** The hosted form keeps
  raw card data off your server, but you are still responsible for a PCI-compliant
  setup around it.

## Test before you go live

- Chase Paymentech requires **individual merchant certification** before live use.
- Run end-to-end transactions in Chase's **test** environment first, and reconcile
  them against Chase's reporting.
- **This is alpha, minimally maintained software.** Pin your version and keep an
  eye on the project for updates before relying on it in production.

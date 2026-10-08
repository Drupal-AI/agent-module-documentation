# Configuration

Commerce CardPointe is configured as a Commerce payment gateway; there is no
separate settings page.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, give it a **Name**, and under **Plugin** choose
   the CardPointe gateway you want:
   - **Hosted iFrame** — for online card payments, using CardPointe's Hosted
     iFrame Tokenizer.
   - **Terminal** — for card‑present transactions via a Clover Flex device.

## Fields to fill in

Enter the credentials from your CardPointe / CardConnect account:

- **API credentials** — the site/merchant credentials (for example the CardPointe
  site name, merchant ID, and API username/password, depending on the release)
  that let the module call CardPointe's authenticated API. Treat these as secrets
  (see below).
- **Tokenizer / iFrame settings** — for the Hosted iFrame gateway, the settings
  that point at CardPointe's hosted tokenizer.
- **Terminal / device settings** — for the Terminal gateway, the settings that
  identify your Clover Flex device.
- **Mode (Test / Live)** — start in **Test** and validate the flow against
  CardPointe's test environment before switching to **Live**. Make sure your
  credentials match the mode you select.

Save the gateway.

## Managing payments

Once live, you can **void**, **capture**, and **refund** payments from the
order‑management interface, and the gateway's own permissions control who can do
so — grant them to the right roles.

## Storing credentials securely

CardPointe API credentials are payment secrets and must not be committed to code
or exported config in plain text. On DDEV, store them as environment variables:

```bash
ddev dotenv set .ddev/.env --cardpointe-api-password='<your-secret>'
ddev restart
```

Reference the value through a **Key** entity where supported rather than pasting
the raw value into the form, and keep `.ddev/.env` out of version control.

## Security and compliance notes

- Card data is collected through CardPointe's **Hosted iFrame Tokenizer** on
  Clover's servers and tokenized — keeping raw card data off your server where
  possible.
- Authorization and capture happen **server‑side** against CardPointe's
  authenticated API, so the module does not trust a client‑side result.
- Always run the site over **HTTPS**, and confirm **test vs live** mode before
  taking real payments.
- On **PCI‑DSS**, the maintainers state the module is intended to work within
  **SAQ A‑EP** requirements (the exact designation depends on your integration),
  but PCI compliance ultimately remains **your** responsibility.

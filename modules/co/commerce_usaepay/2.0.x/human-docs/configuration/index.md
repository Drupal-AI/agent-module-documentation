# Configuration

Commerce USAePay is configured as a standard Drupal Commerce payment gateway.

## The settings, field by field

The USAePay gateway plugin has three required credential fields plus the standard
Commerce **mode** (test/live) and **display label**:

- **WSDL Key** — the SOAP endpoint key (e.g. `ABCD1234`) you generated in the
  USAePay developer console; it forms the WSDL URL the module connects to.
- **Source Key** — the merchant-account source key from the USAePay Merchant
  Console.
- **PIN for Source Key** — the PIN that pairs with the source key. It is required
  here because USAePay's `sale` API path requires it.

## Add the USAePay payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** and choose the **USAePay** plugin.
3. Enter your **WSDL key**, **source key**, and **PIN**.
4. Set the gateway **mode** to **Test** while you set up (this uses USAePay's
   **Sandbox**), then switch to **Live** for production.
5. Save.

## Keep your credentials secret

Your USAePay **WSDL key**, **source key**, and **PIN** are credentials — treat them
like passwords:

- Don't commit them to version control (keep them out of committed store config).
- Prefer storing them in environment variables and referencing them from
  `settings.php` (e.g. `getenv('USAEPAY_SOURCE_KEY')`) rather than hard-coding. With
  DDEV you can set them once with the built-in dotenv command, then restart:

  ```bash
  ddev dotenv set .ddev/.env --usaepay-source-key='<your source key>' --usaepay-pin='<your pin>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## Test vs live

Use USAePay's sandbox credentials and the gateway's test mode first. Place a
**test order** and complete a card payment; because the outcome is read from the
API's `ResultCode`, an approved test transaction confirms the wiring end to end.
Then switch to live credentials and live mode.

## Security recap

- Payment handling is **server‑authoritative**: the transaction is submitted to
  USAePay's API server‑side and the outcome is read from the API `ResultCode`, not
  from a client‑supplied field.
- This is an **on‑site** gateway: card details are entered on your site and sent
  server‑side to USAePay — serve over **HTTPS** and meet the **PCI** obligations
  that apply to your store.
- Keep the **WSDL key, source key, and PIN** in environment variables / a settings
  override, never in committed config.

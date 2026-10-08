<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce N-Genius lets a Drupal Commerce store take card payments through Network International's N-Genius hosted checkout (widely used in the Middle East / UAE). Shoppers are redirected to the N-Genius hosted page and returned to the store, where the module queries the N-Genius API for the transaction's 3-D Secure result.

---

Install the module and enable it (depends on commerce_payment). Create a Commerce payment gateway of type 'N-Genius', supplying the Outlet reference and API key from your N-Genius dashboard and selecting live or test mode. The gateway is offsite: at checkout the customer is redirected to N-Genius, and on return the module exchanges credentials for an access token and fetches the order's payment status over HTTPS. Store the API key as a secret and restrict who can configure payment gateways.

---

- Accept card payments via N-Genius hosted checkout.
- Provide an offsite redirect payment gateway.
- Configure Outlet reference and API key per gateway.
- Toggle live and UAT/test endpoints.
- Obtain an OAuth client-credentials access token.
- Fetch the order's 3-D Secure status on return.
- Complete checkout when 3DS status is SUCCESS.
- Abort the transaction on FAILED or missing status.
- Log payment success and failure responses.
- Redirect shoppers to N-Genius payment pages.
- Return shoppers to the Commerce checkout flow.
- Support the standard credit-card payment method type.
- Integrate with Commerce order workflow.
- Use HTTPS for token and order API calls.
- Keep the API key out of version control.
- Restrict payment-gateway administration to trusted roles.

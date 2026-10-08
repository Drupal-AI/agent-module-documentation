# Configuration

## Enter your Buckaroo credentials

1. Log in as a user with the restricted **administer buckaroo integration**
   permission (grant it only to trusted admins).
2. Go to **Configuration → Web services → Buckaroo**, or navigate directly to
   `/admin/config/services/buckaroo`.
3. Enter your Buckaroo **website key** and **secret key**, and choose the
   **mode** — **test** or **live**.
4. Save. The module validates the credentials with the SDK before they are used.

Start in **test mode** and only switch to **live** once you have confirmed a
payment completes end to end.

### Handling the secret key safely (PCI)

These are payment credentials, so treat them as highly sensitive:

- The secret key is the credential an attacker would want most — keep it out of
  any configuration that is committed to public version control.
- On DDEV, keep the value in an environment variable rather than typing it into
  files you commit: `ddev dotenv set .ddev/.env --buckaroo-secret-key=<value>`
  then `ddev restart`, and never commit `.ddev/.env`. You can then feed the
  value into the module's configuration via a settings.php config override using
  `getenv('BUCKAROO_SECRET_KEY')`, so the live secret never lands in exported
  config.
- Follow your normal PCI obligations for the environment that holds these keys.

## Review payments

Recorded transactions appear at `/admin/buckaroo/payments`, behind the restricted
**buckaroo integration payments overview** permission. Each payment is stored as
a `buckaroo_payment` entity, so the records stay queryable for reconciliation and
reporting.

## Take payments from a webform (optional)

If you enabled the **Buckaroo Webforms** submodule:

1. Edit a webform and add the **Buckaroo payment** handler.
2. Configure the handler: choose the payment method, the currency (for example
   EUR or USD), and the **form element that holds the amount**.
3. On submission the customer is redirected to Buckaroo's hosted payment page to
   pay.

## How payment status is updated

There is no inbound "payment succeeded" callback route. On each **cron** run the
module polls the Buckaroo API — over the authenticated SDK connection — for the
status of each pending transaction and updates the local `buckaroo_payment`
records. Make sure cron runs regularly so payment statuses stay current.

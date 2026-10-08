# Configuration

There are two parts to configuring this module: entering your Authorize.Net merchant
credentials, and locking down who can use the CIM creation form. Both matter for
security.

## Merchant credentials

The module's settings — the **API login ID**, **transaction key**, and **environment**
(sandbox or production) — are configured under the **Administer site configuration**
permission. Start against the **sandbox** environment to test, then switch to
**production** only once you have verified the flow.

### Keep the transaction key out of committed config

The transaction key is a secret. Do not paste it into configuration that gets exported
to code and committed to version control. Keep it in an environment variable and read it
from there:

1. Store the secret with DDEV's dotenv helper (keeps it out of version control):

   ```bash
   ddev dotenv set .ddev/.env --authnet-transaction-key=your-transaction-key
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.)

2. Where the module reads the value from settings, reference the environment variable —
   for example via `getenv('AUTHNET_TRANSACTION_KEY')` in `settings.php`, or through a
   [Key](https://www.drupal.org/project/key) entity using the env provider — rather than
   storing the raw key in the database or exported config.

Use a **sandbox** credential in development and a separate **production** credential in
production; never share one across environments.

## Restrict the CIM creation form

The CIM creation form is exposed at **`/authnet-cim-manager/cim-creation-fom`** and, as
shipped, is gated only by the **`access content`** permission. That permission is granted
to almost every role (including, on many sites, anonymous), so **out of the box far too
many users can reach a form that submits card details to your gateway.** Treat tightening
this as a required setup step, not an optional one:

- At minimum, confirm exactly which roles hold `access content` on your site and whether
  that is acceptable for a payment-profile form.
- Preferably, place the form behind a proper, restricted permission or otherwise limit
  access to the specific staff/roles that should be creating CIM profiles (for example
  with an access-control or route-permission approach), so it is not reachable by
  general content-viewing users.

## PCI implications

Card data entered into the creation form **passes through your server** on the way to
Authorize.Net. That brings your site into scope for **PCI-DSS**. Make sure you:

- Serve everything over **HTTPS**.
- Do **not** log or persist raw card data.
- Understand and meet the PCI responsibilities that come with handling card data
  server-side, and consider whether a hosted/tokenized flow better fits your compliance
  posture.

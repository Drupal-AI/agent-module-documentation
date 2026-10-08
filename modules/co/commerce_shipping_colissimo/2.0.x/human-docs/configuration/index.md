# Configuration

Setup has three parts: enter your Colissimo credentials and label settings on the
module's settings form, add a Colissimo shipping method, and add the Colissimo
pane to your checkout flow.

## 1. Credentials and API (the settings form)

Go to **Commerce → Configuration → Shipping → Colissimo Settings**
(`/admin/commerce/config/colissimo`, requires *Administer site configuration*).

- **Login** (`user`) — your Colissimo account login.
- **Password** — your Colissimo account password.
- **API base URL** — defaults to `https://ws.colissimo.fr`; leave it unless
  Colissimo tells you otherwise.
- **Debug mode** — logs the full request and response bodies (which include your
  credentials) to the `commerce_shipping_colissimo` log channel. **Use only in
  non-production**, and turn it off again afterwards.

### Keep the credentials out of committed config

Colissimo credentials are stored in the `commerce_shipping_colissimo.settings`
config object **as plain text**. To avoid committing them to version control,
override them from `settings.php` using an environment variable rather than
saving production secrets into exported configuration:

```php
// settings.php
$config['commerce_shipping_colissimo.settings']['user'] = getenv('COLISSIMO_USER');
$config['commerce_shipping_colissimo.settings']['password'] = getenv('COLISSIMO_PASSWORD');
```

Set those variables with DDEV's dotenv helper (never commit `.ddev/.env`):

```bash
ddev dotenv set .ddev/.env --colissimo-user=<login> --colissimo-password=<value>
ddev restart
```

## 2. Label generation settings

Still on the settings form, adjust how PDF labels are produced:

- **Label size** — A4 or A5.
- **Label format** — PDF (and other supported formats).
- **Default parcel weight (kg)** — used when order items lack a weight.
- **Average preparation delay (days)** — feeds delivery estimates.
- **Label sender parcel-id source** — the strategy for sourcing the sender parcel
  id.

Generated labels are produced through La Poste's label web service and saved as
files.

## 3. Add the Colissimo shipping method

Go to **Commerce → Configuration → Shipping methods** and add a shipping method
using the **Colissimo** plugin. Its options include:

- **Shipping type** — home delivery, home delivery *with signature*, or **relay**
  (pickup point).
- **Rate label** — what the customer sees.

For **relay**, the module authenticates against Colissimo's widget API to render
the pickup-point map at checkout.

## 4. Add the checkout pane

Add the **Colissimo** checkout pane to your checkout flow (**Commerce →
Configuration → Checkout flows**). For relay shipping, customers pick a point on
the map and the chosen point is copied into their shipping profile.

You can also map **which customer-profile field supplies the recipient phone
number**, or source it from the billing profile.

## Save and test

Save the settings and the shipping method, then run a test checkout. Confirm home
delivery and (if enabled) the relay map both work, and that a label can be
generated for a shipment.

## Security notes

- Outbound Colissimo calls use Drupal's HTTP client with **TLS verification on**.
- Credentials are stored **plaintext in config** — override them from
  `settings.php` as shown above so they never land in committed configuration.
- **Debug mode logs credentials** — keep it off in production.

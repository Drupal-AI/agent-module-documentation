# Configuration

Getting live FedEx rates takes two things: your products must carry weight and
dimensions, and you must configure the FedEx shipping method with your account
credentials.

## 1. Add weight and dimension fields to products

Live rating uses the real weight and size of the cart, so every shippable product
needs those values:

1. Using the **Commerce Physical** module's field types, add **dimensions** and
   **weight** fields to all of your shippable product (variation) types.
2. Populate the dimensions and weight for all products. Rating will be wrong or
   fail for products that are missing these values.

## 2. Configure the FedEx shipping method

1. Go to **Administration → Commerce → Configuration → Shipping → Shipping
   methods** and add (or edit) the FedEx method
   (`/admin/commerce/config/shipping/methods/fedex/edit`).
2. Enter your **FedEx account credentials** and choose which FedEx **services** to
   offer (Ground, Home Delivery, 2 Day, Express Saver, the Overnight tiers, Smart
   Post, and the International Economy/First/Priority levels).
3. Set any origin/handling options your store needs. On a multi‑warehouse site,
   the module's address resolver decides the origin address used for rating.

## Handle FedEx credentials as secrets

Your FedEx credentials are live secrets. Do not put them in exported
configuration. Store them in environment variables and surface them through a
**Key** entity:

```bash
ddev dotenv set .ddev/.env --fedex-api-key=<value>
ddev restart
```

## Plan for rating in the checkout path

Because rates are fetched from FedEx on every cart change, the external call
happens right in the checkout path. Two things matter in practice:

- **Cache rate responses** where you can, to keep checkout responsive.
- **Configure a fallback rate**, so that if FedEx is slow or unavailable the
  customer still sees a shipping option — a checkout that fails because FedEx
  timed out is worse than one showing an estimate.

## Customising rates (optional, via events)

Real deployments almost always need site‑specific logic — filtering which returned
rates to show, adding a handling surcharge, or making packaging decisions. These
are done by subscribing to the events in the module's `src/Event/` code rather
than through the settings form. This is the place to look when, for example, rates
come back for the wrong origin on a multi‑warehouse site.

## Regulated shipments

If you enabled the **dangerous goods** or **dry ice** submodules, remember that
the declarations they add are legal obligations for those consignments — configure
and use them according to the carrier's and the law's requirements, not merely as
optional fields.

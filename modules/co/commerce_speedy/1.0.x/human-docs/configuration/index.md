# Configuration

Commerce Speedy talks to Speedy's live API, so setup has two halves: get credentials from
Speedy, then create and configure the shipping method in Commerce.

## 1. Register with Speedy and get API credentials

Create a Speedy account at [myspeedy.speedy.bg/signup](https://myspeedy.speedy.bg/signup)
and obtain your API credentials (username and password) from Speedy. You enter these directly
on the Speedy shipping method in the Commerce admin, and they are saved as part of that shipping
method's configuration.

### A note on exported configuration

Because the credentials are saved with the shipping method's configuration, they become part of
your site's exported config. As with any secret that ends up in exported configuration, don't
commit that export to a public repository.

## 2. Create the Speedy shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
2. Choose the **Speedy** plugin.
3. Enter your Speedy **API credentials**.
4. Choose which delivery options to offer customers at checkout: **delivery to address**,
   **delivery to a Speedy office**, and **delivery to a Speedy automat (parcel box)**.
5. (Optional) Add a **Google Maps key**. When set, the office/automat picker at checkout
   displays a map so customers can select a pick-up point directly on it.
6. Save the shipping method.

## 3. Choose where you ship from

In your store configuration, set whether orders are sent from an **address**, an **office**,
or an **automat (box)**. This origin is used when the shipment is generated in Speedy's
system.

## What happens at checkout and beyond

- At checkout, the module calculates the Speedy shipping cost for the chosen delivery type
  and validates the customer's address (this validation also applies in the user's address
  book and in the store address).
- When an order is **placed**, the module generates the corresponding shipment in Speedy.
- When you **finalize** the shipment, the module produces a **Print label** (waybill) as a
  PDF.

## Save and test

After saving, place a test order and step through checkout to confirm rates are returned and
the delivery-point picker behaves as expected. Because this is a beta, uncovered-by-security-
advisory release, test thoroughly before going live.

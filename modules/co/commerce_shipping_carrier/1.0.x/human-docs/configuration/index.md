# Configuration

## Create a carrier

1. Go to **Commerce → Configuration → Shipping → Carriers**
   (`/admin/commerce/config/shipping_carriers`) and add a carrier.
2. Give it a **label** (for example "UPS", "DHL", "Royal Mail").
3. Set the **URL pattern** — the carrier's public tracking URL, with the
   placeholder **`[tracking_code]`** wherever the tracking number belongs. For
   example:

   ```
   https://www.ups.com/track?tracknum=[tracking_code]
   ```

   When you later record a tracking number on a shipment, the module substitutes
   it into this pattern to build the customer's tracking link.

Repeat for each carrier you use.

## Use a carrier on a shipment

When you create or edit a **shipment** on an order, the carriers you defined are
available to select. Choose the carrier and enter the tracking number the carrier
gave you; the number is then formatted into a tracking link using that carrier's
URL pattern.

## Optional: show the carrier in the shipment confirmation email

The carrier is available in the shipment entity, so you can display it in the
shipping-confirmation email template. In a custom module's
`commerce-shipment-confirmation.html.twig`, add something like:

```twig
{% if shipment_entity.shipping_carrier.target_id is not null %}
  Shipping carrier: {{ shipment_entity.shipping_carrier.entity.label }}
{% endif %}
```

## Save

Save each carrier. There are no further global settings — the configuration is
simply the list of carriers and their tracking URL patterns.

# Configuration

CRM Core Commerce needs one setting before it can do its job: which CRM Core contact
bundle it should use when creating contacts from orders. Everything else happens
automatically once that is chosen.

## Choose the contact bundle

1. Log in as an administrator.
2. Go to **Configuration → CRM Core → Commerce Settings**, or navigate directly to
   `/admin/config/crm-core/commerce/settings`.
3. Select your preferred **CRM Core individual bundle** — the contact type that new
   or updated contacts created from Commerce orders should use.
4. Save the form.

Once this is set, the module works on its own: whenever an order is placed, it
creates or updates a CRM Core contact of the chosen bundle for that customer.

## For developers: customizing the mapped data

If you need to control exactly what gets written onto the contact, the module offers
two extension points:

- **`hook_crm_core_individual_data_alter(array &$data, OrderInterface $order)`** —
  implement this hook to alter the data saved on the individual contact for a given
  order.
- **Extend the mapper service** — override or extend `crm_core_commerce.individual_mapper`
  for deeper control over how order data maps to contact fields.

These are optional; the default mapping works without any code.

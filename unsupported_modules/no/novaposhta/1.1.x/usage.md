NovaPoshta API integrates Nova Poshta — Ukraine's dominant parcel carrier — with the Basket online-store module: warehouse and address selection at checkout, delivery-cost calculation, express-waybill creation and shipment tracking against the Nova Poshta REST API.

---

The drupal.org project is packaged as `basket_novaposhta` but the module machine name is **`novaposhta`**, which matters when enabling it or writing config. It depends on the `basket` store module and core `views`, targets PHP 8.1 and core `^10 || ^11 || ^12`, and stores its API key and behaviour options in the `novaposhta.settings` form at `/admin/config/development/novaposhta`. Its work splits into two layers: a raw transport client (`NovaPoshtaApi2`) that POSTs to the Nova Poshta API v2.0 (`api.novaposhta.ua/v2.0/json/`), and a higher-level facade (`NovaPoshtaAPI`) that adds file-based caching, database reference tables and the store-specific helpers. Because Nova Poshta is warehouse-based, checkout exposes Region -> City -> Warehouse (branch) selectors (the `novaposhta` Basket delivery plugin), with alternative courier-to-address delivery (`novaposhta_address`) and public settlement/street autocomplete endpoints. Area and city reference lists plus the store's waybill list are refreshed on cron (`hook_cron`) or via the shipped drush commands, shipments are recorded in `novaposhta_en` / `novaposhta_lists` tables and surfaced through a bundled View, and interface translations ship for a primarily Ukrainian-language audience.

---

- Offer Nova Poshta delivery inside a Basket store checkout.
- Let customers pick a Nova Poshta branch (warehouse) rather than typing a street address.
- Provide Region -> City -> Warehouse cascading selectors at checkout.
- Offer courier-to-address delivery via the `novaposhta_address` plugin.
- Autocomplete Ukrainian settlements and streets from the carrier API.
- Calculate delivery cost through the Nova Poshta API (`getDocumentPrice`).
- Compute and display cash-on-delivery (redelivery) fees for selected payment methods.
- Store city/warehouse reference data locally for fast selection.
- Create express waybills (internet documents) for orders.
- Update and delete existing waybills from the admin surface.
- Track shipment status and estimated delivery dates.
- Generate Nova Poshta print/marking PDF links for dispatched parcels.
- Manage sender counterparties and contact persons.
- Auto-create a recipient counterparty from order data using tokens.
- Refresh area/city reference lists on cron.
- Run scheduled status updates via `drush novaposhta:status_update`.
- Rebuild area or city lists on demand via `drush novaposhta:list <type>`.
- Surface waybill number, cost, weight and address columns in an admin View.
- Configure parcel seat sizes (height/width/length) for shipments.
- Choose the checkout select-widget style (Chosen or Select2).
- Support Ukrainian-language checkout via shipped translations.
- Keep all Nova Poshta shipping logic in one dedicated module.
- Migrate a Ukrainian store onto its main carrier without custom code.

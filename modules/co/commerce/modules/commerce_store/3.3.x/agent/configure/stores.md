# Stores & store types

## Stores (content entity `commerce_store`)
Manage at **Admin → Commerce → Stores** (`entity.commerce_store.collection`,
`/admin/commerce/config/store`). Fields: name, email, default **currency**, supported
**billing countries**, address, timezone. Mark one store **default** — it is used when an
order/product does not specify a store. Products reference one or more stores; orders belong
to a store, which drives currency, tax and address handling.

## Store types (config entity `commerce_store_type`)
Manage at `/admin/commerce/config/store-types`. Bundles for stores; add fields via Field UI
and toggle Commerce **entity traits**. Default type: `online`.

## Permissions (`commerce_store.permissions.yml` + dynamic)
- `administer commerce_store_type` — manage store types and their fields (restricted).
- Per-store-type access permissions (view/update/delete/create) are generated dynamically
  per store type.

Config schema in `config/schema/commerce_store.schema.yml`.

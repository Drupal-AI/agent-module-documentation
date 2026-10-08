# Commerce License — agent index

Sell access via **License** entities: buying a licensed product variation creates a
`commerce_license` for the buyer, granting something (a role) for a configured period, tracked
by a state-machine workflow and expired by cron.

- **Set up license-selling products (entity traits, license type, license period), the admin
  routes, the workflow** → [configure/setup.md](configure/setup.md)
- **License type plugins (`CommerceLicenseType`, the `role` plugin, implement one)** →
  [plugins/license-type.md](plugins/license-type.md)
- **License period plugins (`CommerceLicensePeriod`: unlimited / rolling_interval /
  fixed_reference_date_interval)** → [plugins/license-period.md](plugins/license-period.md)
- **The License entity (fields, states, storage), events, cron expiry, subscription type** →
  [api/license-entity.md](api/license-entity.md)
- **Alter hooks** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity: `commerce_license`; **bundle = a License type plugin** (built-in `role`). Admin at
  `/admin/commerce/licenses` (configure route `entity.commerce_license.collection`).
- Workflow `license_default` (group `commerce_license`): states include `new`, `pending`,
  `active`, `renewal_in_progress`, `suspended`, `expired`, `revoked`, `canceled`.
- Product integration via **entity traits**: `commerce_license` ("Provides a license") on a
  product variation type, `commerce_license_order_item_type` on its order item type.
- Two plugin types: `commerce_license_type` (grant logic) and `commerce_license_period`
  (expiration). Expiry runs on **cron → Advanced Queue** (`commerce_license_expire` job).
- Permission `administer commerce_license` (+ per-bundle perms via `LicensePermissionProvider`).

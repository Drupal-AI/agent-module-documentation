Commerce License lets a Drupal Commerce store sell access to something (a role, a resource, a remote service) by creating a **License** entity for the buyer when they purchase a licensed product variation, with configurable expiration and optional subscription-based renewal.

---

The module adds a `commerce_license` content entity whose bundles are **License type plugins** (`CommerceLicenseType`), the built-in one being `role` (grants a Drupal role while active). A product variation type opts in by enabling the **"Provides a license"** entity trait (`commerce_license`), and its order item type enables the **"…for use with licenses"** trait; the variation then stores a configured License type and a **License period** plugin (`CommerceLicensePeriod`: `unlimited`, `rolling_interval`, or `fixed_reference_date_interval`) that sets expiration. When an order containing such an item is placed/completed, event subscribers create and activate the license; a `license_default` **state-machine workflow** (states: new, pending, active, renewal_in_progress, suspended, expired, revoked, canceled, …) tracks its lifecycle, and each license type's `grantLicense()`/`revokeLicense()` applies/removes the granted access. Expiry is processed by cron, which enqueues `commerce_license_expire` jobs on an **Advanced Queue**. Optional integration with `commerce_recurring` provides the `license` subscription type so a license renews with a billing schedule. Licenses are managed at `/admin/commerce/licenses` (the `configure` route `entity.commerce_license.collection`), license types at `/admin/commerce/config/licenses/license-types`, with a dashboard at `/admin/commerce/config/licenses/dashboard`. Everything is extensible: implement a `CommerceLicenseType` to grant something other than a role, a `CommerceLicensePeriod` for custom expiry, and use the `LicenseEvents` and two alter hooks.

---

- Sell a membership that grants a Drupal role for a fixed period, then expires automatically.
- Offer time-limited access (e.g. 30 days) using a rolling-interval license period.
- Grant access until a fixed reference date (e.g. end of the calendar year) for all buyers.
- Sell perpetual/unlimited access with the `unlimited` license period.
- Turn a product variation into a license-selling product by enabling the "Provides a license" trait.
- Automatically add/remove a user role when a license activates/expires.
- Renew a license automatically each billing cycle via Commerce Recurring subscriptions.
- Track a license through its lifecycle (new → pending → active → expired/revoked/canceled).
- Suspend or revoke a user's access by transitioning their license state.
- Expire overdue licenses automatically through cron + Advanced Queue jobs.
- Notify users before a license expires (the notify queue/job type).
- List and manage all issued licenses at /admin/commerce/licenses.
- Configure allowed license types per product variation type.
- Prevent buying a license the user already effectively has (existing-rights checking).
- Block adding multiples of the same license to the cart.
- Renew a license before it expires within a configurable renewal window.
- Sell access to a remote resource by implementing a synchronizable license type that provisions it.
- Implement a custom License type plugin to grant something other than a role.
- Implement a custom License period plugin for bespoke expiration logic.
- Grant a role-based license that locks the granted role from manual removal on the user form.
- Show a license's expiration on the customer's account via the expiration field formatter.
- Migrate legacy Ubercart role expirations into licenses (d6 migration source included).
- React to license grant/expire/renew via the LicenseEvents event subscribers.
- Alter the available license type or period plugins with the provided alter hooks.
- Provide an admin dashboard summarizing license configuration/status.

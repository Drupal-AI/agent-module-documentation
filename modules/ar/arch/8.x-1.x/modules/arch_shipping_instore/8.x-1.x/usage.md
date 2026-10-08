Offer click-and-collect: customers order online and pick up their goods for free at a predefined store address.

---

`arch_shipping_instore` is an Arch Shipping submodule that adds an in-store pickup (click-and-collect) shipping method. It registers the `instore` ShippingMethod plugin (`InStoreShippingMethod`), whose `getShippingPrice()` always returns a zero/free price built through the Arch price factory, and a small admin UI — under *Store → Shipping methods → In store* — for managing the list of pickup addresses. Addresses are created/edited/deleted with standard forms (machine-name id) and stored in a KeyValue collection; the whole UI is gated by the parent module's `administer shipping methods` permission.

---

- Add a free in-store pickup option to the Arch checkout shipping choices.
- Let customers order online and collect goods at a physical store.
- Charge zero shipping for the in-store method (server-computed, never client-supplied).
- Maintain a list of pickup/pickup-point addresses in the admin UI.
- Add a pickup address (`/admin/store/settings/shipping-methods/instore/address/add`).
- Edit or delete existing pickup addresses.
- View all pickup addresses in an overview form.
- Store pickup addresses in a KeyValue collection keyed by a machine-name id.
- Gate all address management behind the `administer shipping methods` permission.
- Present the in-store method through the shipping method framework (`arch_shipping`).
- Configure the method from the shipping methods settings page.
- Combine in-store pickup with other shipping methods on the same store.
- Reuse the Arch price value objects for the (free) shipping cost.
- Provide predefined collection points for regional stores.

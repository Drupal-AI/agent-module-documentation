Let Arch customers store and reuse billing and shipping addresses as a per-user address-book entity.

---

`arch_addressbook` adds a customer address book to the Arch commerce suite. It defines the `addressbookitem` content entity — a fieldable, revisionable, user-owned record holding an Address-module address field plus a VAT id field — with full own/any view/edit/delete permissions and an admin listing. Customers add addresses from their user page (`/user/{user}/addressbook/add`) or `/address/add`, view them at `/address/{addressbookitem}`, and reuse them during ordering; the `addressbookitem.user_addresses` service resolves the addresses that belong to a given user. Views `addressbook` and `addresses` provide ready-made listings.

---

- Give each customer a personal list of saved billing/shipping addresses.
- Store structured international addresses via the contrib Address field.
- Record a VAT identification number alongside each address.
- Let a customer add an address from their own user page.
- Let a store admin add an address on behalf of any user (`add addressbookitem entity to any user`).
- View, edit and delete individual addresses through dedicated routes/forms.
- Restrict customers to their own addresses with the `view/edit/delete own addressbookitem entity` permissions.
- Grant staff access to all customers' addresses with the non-own permissions.
- Keep a revision history of address changes.
- Reuse saved addresses when placing an order (integrates with `arch_order`).
- List all addresses in the admin UI at `/admin/store/settings/addressbook/list`.
- Provide the `addressbook` and `addresses` Views for theming address lists.
- Resolve a user's addresses programmatically through the `addressbookitem.user_addresses` service.
- Configure address-book behaviour at `/admin/store/settings/addressbook`.
- Move the address-book admin under the store admin section via a route subscriber.
- Support translated addresses (the entity is translatable).

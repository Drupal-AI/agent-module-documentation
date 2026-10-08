# Configuration

Setting up Address Autocomplete is two moves: configure the module's settings
(above all, the lookup provider), then switch an Address field to use the
autocomplete widget.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration** and open the Address Autocomplete settings at
   `/admin/config/…/address_autocomplete`.

The settings form is where you point the module at your address-data **lookup
provider** and tune the lookup behavior. Because address data is licensed, this
provider is the heart of the setup — see the three planning points below before you
save.

## Turn on autocomplete for a field

1. Go to **Structure → Content types**, pick the content type that has your
   Address field, and open **Manage form display**.
2. Change that Address field's widget to the Address Autocomplete widget.
3. Save. On that form, editors (or visitors) now get type-ahead suggestions that
   fill the address fields.

## Three things to plan

Address lookup isn't quite "install and forget" — three things deserve a decision:

1. **The provider is a contract and a cost.** Address data is licensed, so a
   provider is either paid per lookup or free with restrictions. A form that fires
   a request on every keystroke can multiply that cost dramatically. The levers
   are **debouncing** (wait until the user pauses typing) and a **minimum
   character count** before the first lookup fires. Set these conservatively.

2. **What the user types is sent to the provider.** That's the beginning of a
   person's home address leaving your site for a third party. However routine it
   feels, it's a disclosure — mention it in your privacy notice.

3. **The manual path must remain.** No address database is complete: new-build
   streets and unusual addresses are missing from all of them. If your form only
   accepts a chosen suggestion, you shut out exactly the people whose address is
   already hardest to deliver to. Always let someone type their address by hand.

> **Note on this documentation.** The upstream module is a beta and its settings
> form is not documented field-by-field in the source notes this guide is built
> from, so the exact field labels may differ from your install. The provider
> setup, the debounce/minimum-characters levers, and the field-widget switch above
> are the parts to look for on the form.

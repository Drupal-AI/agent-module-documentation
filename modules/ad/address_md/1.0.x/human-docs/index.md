# Address for Rep. of Moldova — manual setup guide

**Address for Rep. of Moldova** (`address_md`) teaches the core
[Address](https://www.drupal.org/project/address) module how addresses in the
Republic of Moldova are structured. It adds a **city** field and a predefined list
of Moldova's **districts** (the country's administrative divisions), so Moldovan
addresses can be entered with the correct local subdivisions.

Once enabled, any Address field on your site that is set to Moldova will pick up
the added city field and district list automatically. This improves address
accuracy for sites collecting Moldovan addresses — the module is a localization
enhancement for the Address module and has no content or access-control role of
its own.

There is no settings page and no admin screen. The module is purely additive: it
enriches Moldova addresses while enabled, and reverts to the Address module's
defaults when disabled. It depends on the Address module and works on Drupal 8.8,
9, 10, and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no configuration screen. After you install and enable the module:

1. Go to any entity that has (or will have) an **Address** field — for example
   **Structure → Content types → [your type] → Manage fields**.
2. Add or edit an Address field as usual.
3. When someone fills in that field and chooses **Moldova** as the country, the
   city field and district list apply automatically.

That is the whole feature. It also works anywhere Address fields are used by other
modules, such as Drupal Commerce checkout addresses.

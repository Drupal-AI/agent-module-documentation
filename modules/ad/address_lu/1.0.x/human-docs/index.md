# Address for Luxembourg — manual setup guide

**Address for Luxembourg** (`address_lu`) teaches the core
[Address](https://www.drupal.org/project/address) module how Luxembourg addresses
are structured. It adds a **city** field and a predefined list of Luxembourg's
**cantons** (the country's administrative divisions), so addresses entered for
Luxembourg use the correct local subdivisions instead of a plain free-text field.

Once enabled, any Address field on your site that is set to Luxembourg will pick
up the added city handling and canton list automatically. This improves address
accuracy for Luxembourg-focused sites — the module is a localization enhancement
for the Address module and nothing more.

There is no settings page and no admin screen. The module is purely additive: it
enriches Luxembourg addresses while enabled, and reverts to the Address module's
defaults when disabled. It depends on the Address module and works on Drupal 9,
10, and 11.

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
3. When someone fills in that field and chooses **Luxembourg** as the country, the
   city field and canton handling apply automatically.

That is the whole feature. It also works anywhere Address fields are used by other
modules, such as Drupal Commerce checkout addresses.

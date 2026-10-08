# Address Iran — manual setup guide

**Address Iran** (`address_iran`) teaches the core [Address](https://www.drupal.org/project/address)
module how Iranian addresses are structured. Out of the box the Address module
knows the formats of many countries, but Address Iran fills in the Iran-specific
details: it sets the correct address format for Iran (`IR`) and supplies a
built-in list of Iran's provinces and their cities.

Once the module is enabled, any Address field on your site that is set to Iran
will automatically show a **province** field and a **city** field, each populated
from the module's predefined lists, and the address will be laid out in the order
Iranians expect. You do not pick anything from a settings page — the module works
silently in the background by responding to the Address module's events.

There is nothing to configure and no admin screen. It is purely additive: enabling
it enriches Iran addresses, and disabling it simply reverts Iran back to the
Address module's built-in defaults. It depends on the Address module and works on
Drupal 9 and 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no configuration screen. After you install and enable the module:

1. Go to any content type, taxonomy, or other entity that has (or will have) an
   **Address** field — for example **Structure → Content types → [your type] →
   Manage fields**.
2. Add or edit an Address field as usual.
3. When someone fills in that field and chooses **Iran** as the country, the
   province and city fields appear automatically, drawn from the module's built-in
   lists, and the address is formatted the Iranian way.

That is the whole feature. It also works anywhere Address fields are used by other
modules, such as Drupal Commerce checkout addresses.

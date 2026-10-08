# Address suggestion — manual setup guide

**Address suggestion** (`address_suggestion`) adds autocomplete to
[Address](https://www.drupal.org/project/address) fields. Instead of typing a full
address into several separate boxes, a person starts typing and picks the right
address from a live suggestion list backed by a real address-lookup service. This
speeds up entry and cuts down on typos.

The lookup service is pluggable. The module defines an `AddressProvider` plugin
type, and you choose which provider to use **per field**, in that field's widget
settings — so different address fields can use different lookup services. It also
ships a CKEditor integration so an address can be inserted directly into rich-text
content.

Two lightweight JSON endpoints power the suggestions. They are intentionally open
to anonymous visitors, because a public form (a contact or registration form, say)
may be filled in by someone who is not logged in. The provider is always read from
the field's saved settings, never from the request, so a visitor cannot redirect
the lookup at some other service. The one thing worth knowing: because the
endpoints are open, anyone who can load your site can consume your address-lookup
quota, so if your provider bills per query, consider rate-limiting those requests.

This is an editor/developer-facing widget with no central settings page — you set
it up per field. It works on Drupal 9.2 through 12.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no central settings page. You enable autocomplete on a specific
Address field through the entity's form display:

1. Go to the entity's **Manage form display** — for example **Structure → Content
   types → [your type] → Manage form display**.
2. Find the **Address** field and choose the Address suggestion widget for it.
3. Open the widget settings (the gear icon) and pick the **address provider** you
   want that field to use (and any provider-specific options, such as restricting
   suggestions to one country), then save.

Now, when someone fills in that address field, typing offers live suggestions they
can select. If your chosen provider bills per lookup, remember that the suggestion
endpoints are reachable by anonymous visitors — add a rate limit if quota cost is
a concern.

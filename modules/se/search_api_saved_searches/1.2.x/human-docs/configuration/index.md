# Configuration

Setting up saved searches is mostly a matter of configuring one or more
**saved-search types**. A type is where the behaviour lives — the notification
schedule, how anonymous subscriptions are activated, and which search index (or
indexes) the saved searches are bound to. Because behaviour lives on the type,
you can run several different alert offerings on one site, each with its own
rules.

## Open the settings

1. Log in as a user with the **Administer Search API saved searches** permission
   (`administer search_api_saved_searches`) — an administrator by default.
2. Go to the saved-search **type** collection under the Search API
   administration area (`entity.search_api_saved_search_type.collection`). You'll
   see the types that exist, starting with the default one the module ships.

From here you can edit the default type or add your own.

## What a saved-search type controls

Editing a type is where you decide how that family of saved searches behaves:

- **Notification settings** — how alerts are delivered and how often. Delivery is
  handled by a *notification plugin* (email is the built-in option, and the
  plugin system means other delivery methods can be added). This is where you set
  the sending frequency — for example an immediate, daily or weekly digest — and
  whether users are allowed to change the frequency of their own saved searches
  or whether it is fixed by you.
- **Activation** — the rules for confirming a saved search. This matters most for
  anonymous visitors: an anonymous saved search is confirmed by an emailed
  activation link before any notifications are sent, which is what prevents
  someone from subscribing an email address that is not theirs.
- **Index binding** — which Search API index the type's saved searches draw their
  new results from.

Save the type when you are done, and repeat for any additional alert products you
want to offer.

## Permissions

Beyond the site-wide **Administer Search API saved searches** permission, the
module generates a **per-type permission for each saved-search type** you create,
so you can control which roles are allowed to use each one. Review these at
**People → Permissions** (`/admin/people/permissions`) after you have created
your types.

## Making saved searches available to visitors

The saved-search creation form is typically surfaced alongside a search — for
example on a search View — so visitors can save the search they have just run.
Remember the two operational rules that keep this reliable: any search View used
with saved searches should have **caching disabled**, and if that View also uses
facets it should **not use AJAX**.

# Configuration

Shortcut per Role has one job, and it is all done on a single form: match each
user role to a shortcut set.

## Before you start — create your shortcut sets

The mapping form can only offer shortcut sets that already exist. If you have not
made any yet, go to **Shortcuts** first (core's shortcut‑set collection) and
create the sets you want — for example an "Editors" set of content links and an
"Admins" set of configuration links. Give each one the links you want its users
to see in the toolbar.

## Open the mapping form

1. Log in as a user with the **Administer shortcut per role** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Shortcuts → Shortcuts Per Role**, or
   navigate directly to `/admin/config/user-interface/shortcut/roles`.

## Map roles to shortcut sets

The form lists **every role on your site**, each with a drop‑down that contains
all the shortcut sets you have created. For each role, pick the set you want its
users to see by default. Leave a role on the empty/default option if you want it
to keep Drupal's core "default" set. Click **Save** when you are done.

Behind the scenes the choices are stored in a single configuration object,
`shortcutperrole.settings`, as a simple `role → set` map — which makes the whole
setup easy to export and deploy with your configuration.

## How a user's set is chosen — highest‑weight role wins

A user often has more than one role, so the module needs a tie‑breaker. The rule
is simple: it looks at all the roles the user holds, and uses the mapping of
their **highest‑weight** role (the one that sits lowest in your role list on the
People → Roles screen, which core treats as the "heaviest").

For example, a user who is both an **authenticated user** and an
**administrator** will get the set you mapped to *administrator*, because that
role outweighs the authenticated role. If the winning role has no set mapped to
it, the user falls back to core's "default" set.

Keep in mind that the mapping only produces a visible difference for users who
already have permission to use the toolbar and its shortcuts — that is core's
own access control, not something this module changes.

## Automatic cleanup

You do not need to maintain this list by hand when your roles change. If you
delete a role, the module automatically removes that role's entry from the
mapping, so no stale settings are left behind.

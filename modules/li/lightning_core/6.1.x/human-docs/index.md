# Lightning Core — manual setup guide

**Lightning Core** (`lightning_core`) is the shared base module for the Lightning
distribution — but it is a normal contrib module you can install on any Drupal
9.3/10/11 site. Rather than a single end‑user feature, it supplies a set of
cross‑cutting APIs and conveniences that other modules and site builders build on, plus
a handful of optional turnkey submodules.

Its main additions are: **descriptions** on user roles and on entity view/form modes
(so editors can see what each is for), the ability to flag a view/form mode as
*internal* or give a form mode a *revision UI* toggle, and an **`_is_administrator`**
route access check so custom routes can be gated on "is this user in an admin role".
It also hangs a **Lightning** settings landing page in the admin menu that gathers the
config links of its submodules, ships a *Long (12‑hour)* date format, adds a description
field to the role edit form, and provides bulk add/edit forms for display modes.

For developers there are helper services — reading and modifying entity view displays,
swapping an entity class or form handler from a hook, and reading/writing config‑entity
descriptions through a shared interface — and a couple of Drush command hooks (a
`base-profile` field on `drush core:status`, and a plugin‑cache clear before
`drush updatedb`). Most of Lightning Core's value is this plumbing that other things
consume.

Lightning Core has **no settings form of its own** and defines no permissions. This
guide is written for a **human**; if you want terse, token‑cheap references for an AI
coding agent — the interfaces, services, and overridden entity classes — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and pick the optional submodules you want.

## Where it lives in the admin menu

Lightning Core adds a **Lightning** landing page at **Configuration → System →
Lightning** (`/admin/config/system/lightning`). It is not a settings form — it is a menu
page that collects the configuration links of any enabled Lightning submodules, and it
is gated by the module's *administrator role* access check (any user in an admin role
can reach it). Role descriptions appear on the role add/edit form under **People →
Roles**, and view/form‑mode descriptions on the display‑mode forms under **Structure →
Display modes**.

## How to use it

Most of what Lightning Core provides is consumed by other modules or by site‑builder
config rather than clicked in a UI:

- **Role and display‑mode descriptions** — edit a role at **People → Roles** and you can
  now give it a human‑readable description; the same goes for view modes and form modes.
- **Internal / revision‑UI flags** — the view‑mode and form‑mode edit forms expose an
  *internal* toggle (hide the mode from normal display UIs) and a *revision UI* toggle.
- **`_is_administrator` route check** — developers can require an admin‑role user on any
  route by adding `_is_administrator: 'true'` under the route's `requirements`.
- **The `Long (12-hour)` date format** — installed automatically, available anywhere a
  date format is chosen.

See the [`agent/`](../agent/start.md) docs for the service names, interfaces, and code
examples behind these.

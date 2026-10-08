# Configuration

Getting value from Form Mode Manager is a two-part job: first you **create and
activate** a form mode (this is core Drupal work), then Form Mode Manager
automatically wires it up. After that, two small settings forms let you fine-tune
behaviour, and generated permissions let you control access by role.

## Step 1 — Create a form mode

1. Go to **Structure → Display modes → Form modes**
   (`/admin/structure/display-modes/form`).
2. Click **Add form mode** and choose the entity type it applies to (for example
   *Content* for nodes).
3. Give it a name, e.g. "Contributor", and save. This creates a form mode with an
   id like `node.contributor`.

At this point the form mode exists but is not yet used anywhere.

## Step 2 — Activate the form mode on a bundle

A form mode only becomes "live" when you enable it on a specific bundle:

1. Go to that bundle's **Manage form display**, e.g.
   *Structure → Content types → Article → Manage form display*
   (`/admin/structure/types/manage/article/form-display`).
2. Scroll to the bottom and open **Custom Display settings**.
3. **Tick** your form mode (e.g. "Contributor") and **Save**.
4. You'll now see a tab for that form mode at the top of the Manage form display
   page — click it and arrange the fields the way you want this form to look
   (hide fields, reorder them, change widgets), then save again.

Enabling the form mode here is exactly what Form Mode Manager treats as an
**active** form mode. As soon as it is active, the module generates everything for
it: an add route, an edit route, tabs, local action buttons, operations links on
the content admin listing, and the access permissions described below.

## Step 3 — Use the generated forms

- **Add** content in that form mode at `entity/add/{bundle}/{mode}`, for example
  `node/add/article/contributor`.
- **Edit** existing content in that mode via the tab that now appears on the entity's
  edit page, or via the operations links on *Content* (`/admin/content`).

## The per-mode permissions

For every entity type that has form modes, Form Mode Manager generates permissions
you'll find on **People → Permissions** (`/admin/people/permissions`):

- **`use <entity_type>.<form_mode> form mode`** — grants access to that specific
  form mode's add/edit routes, e.g. *use node.contributor form mode*. Give this to
  the roles that should be allowed to use that form.
- **`use <entity_type>.default form mode`** — grants access to the **default**
  add/edit form for that entity type, e.g. *use node.default form mode*. Because
  this gates the default form, you can *remove* it from a role to hide the default
  form entirely and force that role to use a specific form mode only.

A common pattern: give the "Contributor" role only *use node.contributor form mode*
(and not *use node.default form mode*) so contributors can only ever use the simpler
form.

## Settings form 1 — Exclude form modes

Go to **Configuration → Content authoring → Form Mode Manager**
(`/admin/config/content/form_mode_manager`). This form lets you **exclude** specific
form modes from Form Mode Manager entirely — an excluded mode gets no routes, tabs,
links, or permissions.

By default the module already excludes the user *register* form mode and Commerce's
*add to cart* form mode (these have special handling in core / Commerce and should
not be turned into ordinary add/edit routes). Tick or untick modes here to change
what Form Mode Manager manages, then save. (This form requires the *administer site
configuration* permission.)

## Settings form 2 — Local task (tab) position

At **Configuration → Content authoring → Form Mode Manager → (Links task)**
(`/admin/config/content/form_mode_manager/links-task`) you control **where the
generated tabs appear** for each entity type: at the **primary** tab level (the same
row as *View* / *Edit*) or the **secondary** level.

Promoting a mode's tasks to the **primary** level is useful when you've restricted
the default form for a role and want the form-mode tabs to be prominent rather than
tucked away as sub-tabs.

## Supporting custom entity types (advanced)

Form Mode Manager knows how to build routes for **nodes, users, taxonomy terms, and
block content** out of the box, and it has a **generic** fallback that works for most
other standard content entities automatically. If you have a bespoke content entity
with unusual route names, a developer can add a small `entity_routing_map` plugin to
teach the module its add/edit route names — see the
[`agent/`](../agent/plugins/entity-routing-map.md) docs for the plugin details.

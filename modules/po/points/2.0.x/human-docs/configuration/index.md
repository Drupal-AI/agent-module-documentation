# Configuration

Points does not have a single "settings" form. Instead, you configure it by
managing point entities and point types in the admin UI and by attaching points to
the entities you want to track. This page walks through that setup.

## Administer point entities and types

1. Log in as a user with the **Administer point entities** permission. This
   permission is flagged **restricted**, so grant it only to trusted roles.
2. Go to **`admin/structure/points`**. From here you manage the **Point** entities
   and the **Point type** bundles.

### Point types

Point types are configuration bundles that let you define different kinds of points
(for example "Loyalty points", "Store credit", "Reputation"). The module installs a
**default** point type on enable; create additional types here if you need to track
more than one kind of balance.

### Point entities

A **Point** is a content entity that holds a numeric value. You can create point
entities directly, or — more usefully — reference them from other entities (see
below) so each user or piece of content gets its own balance.

## Attaching points to other entities

The real power of the module comes from linking points to the things you want to
track, using core's **Entity Reference** field:

1. Go to the entity type you want to attach points to — for example **People →
   (account settings) → Manage fields** for users, or a content type's **Manage
   fields**.
2. Add a new field of type **Reference → Other…** (entity reference).
3. On the "Type of item to reference" step, choose the **Point** content entity
   type.
4. Save the field. Because the module generates a movements route for every
   entity-reference field that targets **Point**, each referencing entity now gets a
   point balance and its own movement history.

The bundled **Inline Entity Form** widget lets you create and edit the referenced
point directly inside the host entity's form, so editors do not have to manage
points as a separate step.

## The movement ledger

Every time a point's value changes, the module writes a **point movement** record
capturing the delta. A dynamic per-entity page (gated by the **View point
entities** permission) embeds a bundled View that shows that entity's movement
history — a running ledger of how the balance changed over time.

## Updating points via the API or web services

If you update points programmatically, the module uses a state-tracking mechanism
to prevent conflicting concurrent writes. Before writing a new value you must set
the point entity's **state** to the exact value you retrieved. If another client
changed the point in the meantime, your update is rejected rather than silently
overwriting theirs — so always read the current value immediately before updating.

## Permissions

Grant the granular permissions to the appropriate roles:

- **Administer point entities** *(restricted)* — full management at
  `admin/structure/points`.
- **Create / View / Edit / Delete point entities** — fine-grained control over who
  can do what with points.

Assign these at **People → Permissions** (`/admin/people/permissions`).

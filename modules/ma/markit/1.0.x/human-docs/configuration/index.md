# Configuration

Setting up MarkIt is a four‑step routine: create your mark types, enable them on the
entities you want, choose the allowed actions per bundle, then set permissions.

## Step 1 — Create your MarkIt types

1. Go to **Structure → MarkIt**.
2. Create each type of marking you want to use — for example **viewed**,
   **started**, **read**, **ranked**, or **completed**. These become the marks you
   can apply to content.

## Step 2 — Enable MarkIt for the entities and bundles you want

1. Go to **User Interface → MarkIt**.
2. In the **Target entities** field, choose the entity bundles that should allow any
   marking at all.
3. **Save** the form.

## Step 3 — Choose the allowed actions per entity bundle

1. On the same form as Step 2, open the **Actions per entity** collapsible
   fieldset.
2. For each entity bundle, choose which MarkIt types are enabled for it. This lets
   different bundles support different marks.
3. **Save** the form, then **clear caches** (`drush cr`) so the changes take effect.

If a bundle is not configured to support a given mark type, MarkIt's endpoints will
return **403 Access Denied** for that combination.

## Step 4 — Set user permissions

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Set the permissions you want. MarkIt provides:
   - **administer markit entities** — manage MarkIt configuration and entities.
   - **mark markit entities** — apply marks.
   - **unmark markit entities** — remove marks.
   - plus **per‑type permission callbacks**, so you can control marking on a
     type‑by‑type basis.

The per‑type control is the useful part: you might, for example, allow users to
**mark** a node as "viewed" but **not** allow them to **unmark** it, so a view is
recorded permanently.

## After configuring

With types created, bundles enabled, actions chosen, and permissions set, your
front‑end (theme or JavaScript) can call MarkIt's HTTP endpoints to mark, unmark,
and read totals. See the [overview](../index.md#how-to-use-the-endpoints) for the
endpoint list — remember that mark/unmark are `POST` requests and require the
`X-CSRF-Token` header, whose value comes from a `GET` request to `/session/token`.

# Configuration

Everything you do with ECK starts at **Structure → Entity Construction Kit**
(`/admin/structure/eck`). From there you create entity types, add bundles to
them, and attach fields. The content itself is then created and managed under
**Content**.

## Step 1 — Create an entity type

1. Log in as a user with the **Administer ECK entity types** permission (an
   administrator by default).
2. Go to **Structure → Entity Construction Kit** (`/admin/structure/eck`) and
   click **Add entity type**.
3. Give it a label (e.g. "Event") — ECK derives a machine name from it.
4. Choose which **base fields** the type should have. These are optional and you
   pick only what you need:
   - **Title** — a human label for each entity. Turning this on makes the title
     the entity's label.
   - **Author** — records who owns each entity. Turning this on is what enables
     the "edit own" / "delete own" style permissions later.
   - **Created** — a created-timestamp field.
   - **Changed** — a changed-timestamp field.
   - **Status** — a published/unpublished flag; turning it on enables the "view
     unpublished" permission.
   - Keeping a type lean (say, just Title and Status) keeps its tables simple.
5. There is also a **standalone URL** option (on by default): when on, each
   entity gets its own canonical page at `/{type}/{id}`; turn it off if the
   entities are only ever embedded/referenced and should not have their own page.
6. Save. ECK now installs a real content entity type behind the scenes,
   including its database tables.

## Step 2 — Add bundles

Bundles are the variants within a type (like content types are variants of a
node). A type can have one or many.

1. From the entity type list, open your type's **bundles** (or go to
   `/admin/structure/eck/{type}/bundles`).
2. Click **Add bundle**, give it a name and optional description, and save.
3. Repeat for each variant you need (e.g. "Conference" and "Webinar" under an
   "Event" type).

Managing bundles requires the **Administer ECK entity bundles** permission.

## Step 3 — Add fields to a bundle

ECK bundles use the standard **Field UI**, exactly like node content types.

1. From a bundle, click **Manage fields** (route
   `/admin/structure/eck/entity/{type}/bundles/{bundle}/fields`).
2. Add whatever fields you need — text, entity reference, date, media, and so on.
3. Configure **Manage form display** and **Manage display** as usual.

## Step 4 — Create content

Editors work under **Content**:

- List a type's entities at **Content → (your type)** (`/admin/content/{type}`).
- Add one at `/admin/content/{type}/add/{bundle}`.

## The global setting

ECK has one site-wide setting, **Use admin theme** (`eck.settings`,
`use_admin_theme`, on by default): whether the admin theme is used when creating
and editing ECK entities. You can change it with Drush:

```bash
drush config:set eck.settings use_admin_theme false -y
```

## Permissions

ECK provides a set of fixed permissions plus a set generated for each entity
type you create. Set them at **People → Permissions**
(`/admin/people/permissions`).

**Fixed permissions:**

- **Administer ECK entity types** — create, edit and delete entity types and
  reach the `/admin/structure/eck` UI. Trusted, site-builder level.
- **Administer ECK entity bundles** — create, edit and delete bundles.
- **Administer ECK entities** — create, edit and delete any ECK entity of any
  type.
- **Bypass ECK entity access** — view/edit/delete *all* ECK entities regardless
  of per-type grants. Grant sparingly.
- **View unpublished ECK entities** — view entities whose Status base field is
  unpublished.

**Per-type permissions** (generated automatically for every type — shown here
for an example type called "event"):

- **Create event entities**
- **Edit any event entities**, **Delete any event entities**, **View any event
  entities**
- **Access event entity listing**
- If the type has the **Author** base field, also the "own" variants: **Edit own
  event entities**, **Delete own event entities**, **View own event entities**.

Grant them like any other permission — for example, with Drush:

```bash
drush role:perm:add editor 'create event entities'
drush role:perm:add editor 'edit any event entities'
drush role:perm:add authenticated 'view any event entities'
```

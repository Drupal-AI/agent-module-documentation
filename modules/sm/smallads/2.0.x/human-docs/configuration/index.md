# Configuration

Smallads works the moment it is enabled — the vocabularies, views, block and
entity are all created for you. This page covers the pieces you may want to tune:
the settings form, ad types, permissions and the two vocabularies.

## The settings form

Go to **Structure → Smallads → Settings**
(`/admin/structure/smallads/settings`) — you'll need the **Administer site
configuration** permission. This is where module-wide behaviour for the
marketplace is configured. Adjust it to taste and save.

## Ad types (bundles)

The `smallad` entity works like a content type: it has bundles called **smallad
types**, which behave like content-type buckets for your ads. Manage them under
**Structure → Smallads** (`/admin/structure/smallads`), where you can **add**,
**edit** and **delete** types. Each of these forms also requires the **Administer
site configuration** permission.

## Permissions

Access to ads is entirely permission-driven. Grant these at **People →
Permissions** according to who should do what — all three are marked
*restrict access*, so hand them out deliberately:

- **view smallad** — see ads. Give this to whoever should be able to browse the
  marketplace (often authenticated users, sometimes anonymous visitors).
- **post smallad** — create and manage one's *own* ads. This is the "member"
  permission that lets people list their offers and wants.
- **edit all smallads** — moderate, prune and manage the whole catalogue. This is
  a trusted-moderator permission: it also lets a user see ads that have expired
  into private scope.

Administrative routes (the settings form and type management) additionally require
**Administer site configuration**.

## The two vocabularies

Enabling the module creates two taxonomy vocabularies you can populate:

- **categories** — the primary, hierarchical classifier (yellow-pages style).
  Build out your category tree here; the nested-categories navigation block lets
  visitors drill into it.
- **smallads_types** — a second classification dimension. Add terms such as
  *offers*, *wants* and *notices*; extra terms activate the tabs shown on the
  listing pages.

One caveat worth knowing: the three generated views only keep tracking changes to
the **smallads_types** vocabulary automatically if you have *not* hand-edited the
views. Once you customise a view, you take over responsibility for keeping its
type filters in step with the vocabulary.

## Scope and expiry

Every ad has a **visibility scope** and an **expiry date**. After the expiry date
passes, the ad automatically reverts to *private* scope — visible only to its
owner and to users with **edit all smallads**. A queue worker handles expiry
notification emails. There is nothing to configure for this to work; it is part
of how ads behave.

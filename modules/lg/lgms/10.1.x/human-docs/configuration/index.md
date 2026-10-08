# Configuration

Most of setting up LGMS is about **who can do what** and **how guides are
categorized**, rather than a long settings form. This page covers the settings
form location, the permission model, and the categorization vocabularies.

## The settings form

The module's own settings live under **Configuration → System → LGMS**
(`/admin/config/system/lgmsmodule`), behind the **Administer site configuration**
permission — so only trusted administrators reach it. This is where general
module settings are kept; the substance of running LGMS is in the dashboard and
the permissions below.

## Permissions — who can build and browse guides

Grant these under **People → Permissions** (`/admin/people/permissions`). LGMS
separates public browsing from staff work:

- **Access content** — controls the public browsing routes (the guide listings by
  subject, type, and group, the databases page, and viewing a published guide).
  This is core's standard "can see published content" permission, so anonymous
  visitors typically already have it.
- **Access dashboard** — lets a user reach the staff dashboard where guides are
  managed. Give this to your library staff roles.
- **Create guide content** — lets a user create new guides and guide content
  from the dashboard. Pair it with **Access dashboard** for anyone who authors
  guides.

Beyond these, the guide/page/box **edit and delete** forms enforce standard node
**update** and **delete** access on the specific guide being changed. That means
even a user who can reach the dashboard can only modify the guides they are
actually permitted to modify — a sound, per‑item access model.

## Categorization vocabularies

LGMS organizes guides using predefined taxonomy vocabularies:

- **Guide Types** — the kind of guide (subject guide, course guide, how‑to, and
  so on).
- **Subjects** — the topic or discipline a guide covers.
- **Groups** — a grouping used for browsing and organizing guides.

Populate these vocabularies with the terms your library uses under **Structure →
Taxonomy**. The terms you add become the facets visitors browse by, so it is
worth agreeing on your list of subjects and guide types before staff start
building guides in earnest.

## Media

Because content items in a box use core **Media** and the **Media Library**,
review your media types and any file‑size or allowed‑extension limits under
**Structure → Media types** so that staff can add the images and video their
guides need.

# Redirect Options — manual setup guide

**Redirect Options** (`redirect_options`) lets you **classify** each redirect by
type, so a large redirect set can record not just where each redirect goes but
what *kind* of redirect it is and why it exists. It extends the contrib Redirect
module and is a lightweight organisation aid — it does **not** change how
redirects resolve; it only records metadata alongside them.

On install it creates a taxonomy vocabulary called **Type of Redirect**, seeded
with two terms, **Template** and **Server**, and adds a *Select redirect type*
dropdown to the redirect add/edit form. The chosen type is stored on the redirect
and mirrored into a small companion table keyed by source path, and it is also
written into the redirect entity's otherwise-unused title column so that the "To"
column on the redirect listing shows the redirect's type.

The Template/Server terms come from the module's origin (a headless Va.gov setup
distinguishing server-level from template-based legacy redirects), but they are
just starting points — edit the vocabulary to whatever categories fit your site.
The module adds no permissions of its own; access follows the Redirect module's
existing form permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Redirect
   module it depends on, and enable it.

There is **no dedicated settings page** for this module — you classify redirects
on the standard redirect form and manage the categories as a taxonomy, described
in "How to use it" below.

## How to use it

1. **Adjust the categories to suit you.** On install the module creates the *Type
   of Redirect* vocabulary with **Template** and **Server** terms. Manage it under
   **Structure → Taxonomy → Type of Redirect** — rename these terms or add your
   own to match how you want to classify redirects.
2. **Classify redirects as you create or edit them.** On any redirect add/edit
   form (under **Configuration → Search and metadata → URL redirects**,
   `/admin/config/search/redirect`), pick a value in the **Select redirect type**
   dropdown. It is saved when you submit the redirect.
3. **Read the type in the listing.** The chosen type is written into the redirect's
   title column, so it appears in the "To" column on the redirect listing. If you
   prefer different output there, you can adjust the Redirect view at
   `admin/structure/views/view/redirect`.
4. **Query it if you need to.** The type is also stored in a companion
   `redirect_options` table keyed by source path, which external tooling (for
   example a headless/GraphQL front end) can read.

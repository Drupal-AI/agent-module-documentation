# Find Text — manual setup guide

**Find Text** (`find_text`) is an administrator/editor tool that searches **every
text field on the site** for a given string — or a regular expression — and shows you
exactly which entities and which fields contain it, with the match highlighted. It
queries the database directly rather than a search index, so it finds content that
site search would miss: menu link titles and URLs, taxonomy term names and
descriptions, and text stored inside paragraphs and Layout Builder blocks (results
point at the real host node in those cases).

This is the tool you reach for before renaming a product, cleaning up broken links,
hunting down a deprecated shortcode or placeholder, or preflighting a content
migration — anywhere you need to know "where does this string appear?" across all
your content. You can use `_` and `%` as single‑ and multi‑character wildcards in a
plain search, or switch to a full regular‑expression search. Results can optionally
render the matched HTML for readability and be exported to CSV for audit or
bulk‑edit planning.

Because it reads content directly from the database and can be resource‑intensive, it
is meant for **trusted content managers**, not as a public site search. Both of its
routes are protected by restricted permissions, so only roles you explicitly trust
can use it.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the search form, the settings that
   control what is searchable, caching, and CSV export, plus the permissions.

## Where it lives in the admin menu

The search form is at `/admin/find-text` (**Access find text** permission), and its
settings are at **Configuration → Content authoring → Find Text settings**
(`/admin/config/find-text/settings`, **Administer find text configuration**
permission). Both permissions are marked as restricted.

## How to use it

1. Grant the **Access find text** permission to trusted content managers.
2. Go to `/admin/find-text`, type the text you are looking for, and (optionally)
   switch on **regexp** for a regular‑expression search, or **render markup** to see
   matched HTML rendered.
3. Read the results table: each row shows the entity, the field the match is in, and
   the surrounding text with the match highlighted. Export to CSV if you enabled that
   option.

See [Configuration](configuration/index.md) to tune which field types, entity types,
and bundles are searchable, and to manage caching and CSV export.

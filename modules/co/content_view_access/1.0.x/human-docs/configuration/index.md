# Configuration

Content View Access is configured on a single form that presents a grid: every
node content type and taxonomy vocabulary, crossed with every user role. For each
cell you pick what should happen when a user in that role opens that bundle's
canonical page.

## Open the settings form

1. Log in as an administrator who can reach the form (see the
   [permission‑mismatch caveat](../installation/index.md) — until it is fixed,
   that is **user 1**).
2. Go to **Configuration → People → Content View Access**, or navigate directly
   to `/admin/config/people/content-view-access`.

## The bundle × role grid

For each **content type** and each **vocabulary**, you get a select per role.
The available actions are:

- **‑ None ‑** *(default)* — no change; the page behaves normally. This is also
  how you disable a rule: set its select back to *None* and save.
- **Access Denied (403)** — the visitor gets a 403 *Access denied* response.
- **Not Found (404)** — the visitor gets a 404 *Not found* response. Use this
  when you would rather not reveal that the content exists at all.
- **Front page** — the visitor is redirected to the site's front page (`/`).
  Handy for funnelling people to a landing page instead of showing a bare error.
- **Blank page** — the visitor gets an empty page (a 200 response with no body).

You can configure different actions for different roles on the same bundle, and
set rules across many content types and vocabularies in one save. The settings
are stored as a matrix (`access[entity_type][bundle][role] = action`); only cells
with a non‑*None* action are saved.

## Save

Click **Save configuration**. Rules take effect on subsequent page requests to
the affected canonical pages.

## What this protects — and what it does not

This is the part to internalise before you rely on the module. Enforcement is a
request subscriber that runs **only** on the node and taxonomy‑term **canonical
(HTML) page routes**. It resolves the entity, looks up your grid for that
bundle, and applies the first configured action for one of the current user's
roles.

Because it hooks the request rather than Drupal's access system, it does **not**
gate any of these:

- **JSON:API** (`/jsonapi/node/…`) or **REST** (`/node/{nid}?_format=json`),
- **Views** listings, **search** results, and **RSS** feeds,
- **edit / delete / revision** routes, previews, and entity references or embeds.

In other words, content you "deny" here remains fully reachable through those
other channels. Use Content View Access for **presentation and redirect control**
— steering who lands on which page — not as a security boundary for sensitive
data. For genuine protection, pair it with a module that provides real node
access (`hook_node_access` or node access grants), such as Entity Bundle
Permissions, Node View Permissions, or Rabbit Hole, and **audit that blocked
bundles are actually protected at the data layer**.

# Node Link Report — manual setup guide

**Node Link Report** (`node_link_report`) adds a per‑node block that checks every
link on a node and flags the ones that are broken, redirected, pointing at
unpublished content, skipped, or have accessibility problems. When the block
renders, it renders the node into HTML, pulls out every anchor, and sends a
request to each unique link, then presents a tidy report right on the page — so
editors can catch bad links before (or after) publishing without leaving the
node.

The block only appears on node **view**, **edit**, and/or **preview** screens
(you choose which), and only for users who hold the **View Node Link Report**
permission. It issues fast parallel HEAD requests to each link, falling back to a
full GET when a server rejects HEAD. Links returning a success or redirect status
are "good" (or "redirected" if they actually land somewhere else); internal
failures are cross‑checked against the path system to detect links to unpublished
entities; and a separate accessibility pass flags empty links, undescriptive link
text, and images‑as‑links missing meaningful `alt` text. Reports are cached for
24 hours per node (and cleared when the node or the settings are saved); previews
are never cached.

One caveat worth knowing up front: links are tested **anonymously**, so any link
that points at content only visible to logged‑in users will show up as broken.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Node Link Report**
(`/admin/config/content/node_link_report`), gated by the **Administer content**
permission. You place the block itself through **Structure → Block layout**, and
you grant visibility with the **View Node Link Report** permission at **People →
Permissions**.

## How to use it

Setup is three steps:

1. **Grant the permission.** Give **View Node Link Report** to the roles that
   should see the report (at **People → Permissions**).
2. **Place the block.** Add the **Node Link Report** block to a region at
   **Structure → Block layout**. The block automatically limits itself to node
   view/edit/preview screens according to the settings below. (Pairing it with
   BigPipe lets the slow link‑checking stream in without blocking the page.)
3. **Tune the settings** at **Configuration → Content authoring → Node Link
   Report** (needs **Administer content**).

### Settings

The settings form (config object `node_link_report.settings`) covers, among
others:

- **Which screens** the block appears on — node view, node edit, node preview
  (each a separate toggle).
- **External link checking** on/off, and whether to also list **good** links and
  **skipped** links (mailto/tel/sms and deliberately excluded ones).
- The **accessibility** pass on/off, plus an optional guidance URL and link text
  shown next to accessibility issues.
- A custom **User‑Agent** for the link‑checking requests.
- **Additional domains treated as internal** (for multi‑domain sites), **domains
  to skip** (e.g. login‑walled sites that falsely read as broken), and **path
  patterns to skip** (like `/node/*/edit`, `/user/*`) to cut noise and load.
- An alternate **decoupled/headless frontend** domain to re‑check "broken"
  internal links against.

(The [agent docs](../agent/start.md) list every setting key exhaustively if you
need the precise names.)

### Requirements to know about

The link checker relies on PHP's **cURL** and **DOM** (`DOMDocument`) extensions,
and the module depends on core's **Path Alias** module. Because links are tested
as an anonymous visitor, content that isn't visible to anonymous users will be
reported as broken — that's expected, not a bug.

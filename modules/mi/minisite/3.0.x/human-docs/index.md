# Minisite — manual setup guide

**Minisite** (`minisite`) lets an editor upload a ZIP or TAR archive of a static
website — HTML, CSS, JavaScript and assets — and serve it straight from your
Drupal site while keeping the minisite's own look and feel. It's the practical
answer to a recurring need: an annual report produced as a static build, an
agency-made campaign microsite, an interactive data visualisation, a preserved
legacy site, a conference programme delivered as a folder of files. Rather than
rebuilding each one in Drupal or hosting it elsewhere, you attach it to a node as a
field value, so it gains an owner, a revision history and your normal editorial
workflow, and it keeps your URL, TLS certificate and analytics in one place.

Minisite works as a **custom field type**, not a settings screen. You add a
"Minisite" field to a content type; editors then upload an archive on each node.
The module extracts the archive into the files directory, serves its pages
(optionally under the parent node's URL alias), enforces an allowed-extension list
so disallowed files abort the whole upload, and cleans up the extracted files when
the node is deleted. Note that it does **not** import the pages as Drupal nodes —
they are served as-is. Each archive must have a single root directory containing an
`index.html`.

It depends only on core's **File** module and adds a `manage minisites`
permission, which is correctly marked as restricted.

> **Important — treat this permission as equivalent to deploying front-end code.**
> Extracted files are served from your site's own origin, and the allowed
> extensions include `html`, `js` and `svg` because a minisite is made of them — so
> anything in an archive executes as your site. Only let trusted users hold
> `manage minisites`. Two things are worth deciding deliberately: applying a
> **Content-Security-Policy** to minisite paths (the main thing that constrains what
> uploaded code can do), and, where your requirements allow, serving minisites from
> a **separate origin** to remove the risk entirely. Scanning uploads with an
> antivirus/ClamAV-style tool also guards against malicious or ZIP-bomb archives.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page**; all the setup happens on a Minisite
field, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types**, pick (or create) a content type, and open
   **Manage fields**.
3. Add a new field of type **Minisite**. In the field settings, set the allowed
   file extensions for the archive contents (this list is enforced per field —
   keep it as tight as the minisite genuinely needs).
4. Grant `manage minisites` (under **People → Permissions**) only to trusted
   editors.
5. Create or edit a node of that type, upload a ZIP/TAR archive whose root
   directory contains an `index.html`, and save. The extracted pages are served
   from the files directory or under the node's alias, keeping their original look
   and feel.

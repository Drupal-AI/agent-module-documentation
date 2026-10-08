# LLMs.txt Gen — manual setup guide

**LLMs.txt Gen** (`llms_txt_gen`) automatically fills your site's `llms.txt` with
sections listing every published node, grouped by content type, as markdown links
to each node's `.md` (markdown) URL. It gives large language models a clean,
structured index of your content without any manual section management — one
section per content type, content types and nodes each sorted alphabetically.

It builds on two other modules: it populates the file through the **LLMs.txt**
module (which owns `/llms.txt` and its section entities), and it links to each
node's markdown rendering via the **Markdownify** module. The sections regenerate
automatically on cron to stay current, an initial run happens on install, and you
can rebuild or clear them on demand with Drush.

Security is handled deliberately, which matters because `/llms.txt` is served
without authentication. For speed the node query skips the per‑query access check,
but every node is then re‑checked with an **anonymous‑user view‑access check**
before it's included — so access‑restricted content (including content protected
only by `hook_node_access()`) is not leaked to anonymous consumers. Node titles are
also escaped so a crafted title can't inject markdown links into the public output.

It targets Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   with Composer and enable it.
2. [Configuration](configuration/index.md) — choose which content types are
   included, and regenerate on cron or with Drush.

## Where it lives in the admin menu

The settings live at **Configuration → Search and metadata → LLMs.txt Gen**
(`/admin/config/search/llms-txt-gen`), gated by the **administer llms_txt_gen**
permission. There you choose which content types are indexed.

## How to use it

1. Install and enable the module (it runs an initial generation on install).
2. At `/admin/config/search/llms-txt-gen`, choose which content types to include.
3. Sections regenerate automatically on cron. To rebuild or clear them immediately,
   use the Drush commands:

```bash
drush llms-gen   # regenerate all sections (e.g. after a content import)
drush llms-del   # delete all generated sections
```

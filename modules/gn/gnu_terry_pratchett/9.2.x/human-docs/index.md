# GNU Terry Pratchett — manual setup guide

**GNU Terry Pratchett** (`gnu_terry_pratchett`) adds a single HTTP response header
to your Drupal site:

```
X-Clacks-Overhead: GNU Terry Pratchett
```

That is the whole module. It is a long-standing internet tribute to the author
Terry Pratchett. In his Discworld novel *Going Postal*, messages sent along the
"clacks" semaphore towers carried the codes **G**, **N**, and **U** — an
instruction to pass a name up and down the line forever, keeping it alive, because
"a man is not dead while his name is still spoken." Adding this header is a way for
a website to join that tradition.

The header is harmless: it adds one static value to your responses and does nothing
else. It stores no data, defines no permissions, and has no effect on content or
access control. It will not change how your site looks or behaves for visitors —
it is only visible to anyone who inspects the raw HTTP response headers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **nothing to configure** — the module has no settings form. The header is
sent as soon as the module is enabled.

## How to check it is working

After enabling the module, load any page and inspect the response headers. You can
do this in your browser's developer tools (Network tab → pick the document request
→ Response headers) or from the command line:

```bash
curl -sI https://your-site.example | grep -i x-clacks-overhead
```

You should see `X-Clacks-Overhead: GNU Terry Pratchett` in the output.

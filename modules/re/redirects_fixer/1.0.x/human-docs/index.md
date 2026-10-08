# Redirects Fixer — manual setup guide

**Redirects Fixer** (`redirects_fixer`) tackles a problem many publisher sites
share: content that links to old URLs which now only *redirect* somewhere else.
Every such link costs an extra hop, and long **redirect chains** are bad for
performance and SEO. This module scans your content, finds links that point at
redirected paths, and rewrites them to their final destination — provided that
destination returns an HTTP **200 OK**.

Along the way it can also tidy links up: convert plain links into their
[Linkit](https://www.drupal.org/project/linkit) equivalents, turn absolute
internal links into appropriate relative links, and collapse redirect chains down
to the real target. It can do all of this **without** bumping the node's *changed*
date, so a bulk clean‑up doesn't make everything look freshly edited.

A couple of limitations are worth knowing up front:

- It currently works with **Nodes** and **Custom Blocks** only.
- It only processes the **Body** field. (The maintainer welcomes help making the
  set of fields configurable.)

Because it scans and rewrites content links, this is a **privileged maintenance
tool** — keep it in the hands of trusted operators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Linkit/Views dependencies.

There is no elaborate settings form — the one thing you **must** set after
installing is the **Site domain**, described under "How to use it".

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. **Define the Site domain.** In the module's settings, set the **Site domain**
   URL. This is essential and slightly counter‑intuitive: *regardless of where you
   run the module*, it always queries the domain you enter here to determine each
   link's real destination. Point it at the environment whose live redirects and
   200‑responses you want to resolve against (usually your production URL).
3. Run the fixer over your content. It scans the **Body** field of nodes and
   custom blocks, replaces links that resolve through a redirect with the final
   destination URL (only when that URL returns 200), optionally converts links to
   their Linkit form and absolute internal links to relative ones, and removes
   redirect chains.

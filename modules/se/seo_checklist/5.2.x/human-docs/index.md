# SEO Checklist — manual setup guide

**SEO Checklist** (`seo_checklist`) gives you a fillable, persistent checklist of the
search‑engine‑optimization tasks a Drupal site should tackle — which SEO modules to
install, and which technical steps to configure — and keeps track of which ones you've
completed. It's less a feature and more a **guided to‑do list**: a curated, ordered set
of best‑practice tasks so nothing gets forgotten during a site launch or SEO audit.

The checklist groups its items into sections such as Clean URLs, Meta tags and
Schema.org, Search engines, Optimizing content, On‑page optimization, Security and
performance, and Mobile. Each item that recommends a contrib module (Redirect,
Pathauto, Metatag, Simple XML Sitemap, RobotsTxt, Google Tag, Easy Breadcrumb,
Real‑time SEO / Yoast, Security Review, and more) shows handy **Download**, **Install**,
**Configure** and **Configure permissions** links, and items whose module is already
installed are **pre‑checked automatically** — so the list reflects work you've already
done. Some items also link to an external "SEO training camp" resource for extra
guidance.

The module has almost no logic of its own — it's built on **Checklist API**, which
supplies the checklist page, the progress bar, the vertical‑tab layout, the per‑checklist
permissions, and the saving of who checked each item and when. SEO Checklist just
registers the SEO task list. An optional submodule, **SEO Checklist Optional Modules**,
pulls in the recommended contrib modules as dependencies for convenience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in Checklist
   API), enable it, and pick the submodule if you want it.
2. [Configuration](configuration/index.md) — where the checklist lives and how progress
   and auto‑detection work.

## Where it lives in the admin menu

The checklist is at **Configuration → Search and metadata → SEO Checklist**
(`/admin/config/search/seo-checklist`). Access is governed by Checklist API's
per‑checklist permissions (view / edit the SEO checklist); SEO Checklist itself defines
no permissions.

## How to use it

Open the checklist, work through the sections, and tick off each task as you complete
it — then click **Save** (progress isn't stored until you save). For any item that
recommends a module, use its links to jump straight to the project page (Download), the
modules install page (Install), that module's settings form (Configure), or its
permissions page. Items whose module is already enabled come pre‑checked, so the list
auto‑detects work you've already done, and you can leave and resume later without losing
your place.

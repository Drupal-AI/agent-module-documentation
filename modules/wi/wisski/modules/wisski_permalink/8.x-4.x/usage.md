<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Permalink presents an entity's URI as a stable permalink and puts it in the browser's address bar.

---

A WissKI entity has a URI — that is what makes it a thing in a semantic graph rather than a row in a table — but a Drupal site will happily display it at a path derived from a title, which is neither stable nor the identifier anyone should cite.

This submodule surfaces the real identifier: the URL bar shows the permalink, so what a researcher copies is the thing that will keep resolving rather than a path that changes when the title is corrected.

That is a small change with disproportionate effect on how a collection is used. People cite what they can see and copy. If the visible URL is `/node/1234/some-old-title`, that is what appears in publications, and it breaks the first time anyone tidies the titles.

It pairs naturally with `wisski_doi` — permalinks for everything, DOIs for the subset that warrants formal registration — and with the general obligation any linked-data publisher takes on: **cool URIs don't change**, and a project that publishes identifiers is committing to resolve them.

---

- Show an entity's URI in the address bar.
- Give researchers a stable link to copy.
- Cite a record by its permanent identifier.
- Avoid citing a title-derived path.
- Survive a title correction without breaking links.
- Publish resolvable identifiers.
- Pair permalinks with DOIs.
- Meet linked-data publishing expectations.
- Redirect an old path to the permalink.
- Audit which URLs are being cited.
- Plan URI stability for a project.
- Explain identifiers to researchers.
- Keep identifiers resolving after a migration.
- Check permalinks resolve externally.
- Document a project's URI policy.

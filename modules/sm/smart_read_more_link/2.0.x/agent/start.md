<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Read More Link (smart_read_more_link) — agent index

Field formatter emitting a "Read more" link **only when the teaser is actually shorter than the
full text**. Core requirement `^9 || ^10 || ^11`. No routes, permissions or configuration.

> **Documented from a dev checkout.** Composer resolved this to **`2.0.x-dev`** (a git clone) in
> this environment, despite tagged releases up to **2.0.7** existing. Consequences of that:
> the installed info file has **no `version:` line** (drupal.org's packaging script adds it), and a
> **`.git` directory** sits in the module folder. Drupal's shipped web-server config blocks it —
> verified: nginx returned **403** for `/modules/contrib/smart_read_more_link/.git/config` — but a
> misconfigured server would expose repository history. **Pin a tagged version** rather than
> letting composer take the dev branch.

Key facts:
- The whole idea is one comparison: trimmed output vs full value, link emitted only when they
  differ.
- Why it matters beyond tidiness: an unconditional read-more link leads to a page identical to the
  teaser, which is noise for everyone and a genuine nuisance for screen-reader users navigating by
  links.
- Chosen per field display, so it is reversible with one setting.
- Compare `readmore_extrafield` (wave 63), which makes the core link positionable in Manage
  Display. Different concerns — one decides *whether*, the other *where* — and they can coexist.

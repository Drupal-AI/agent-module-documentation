# Smart Read More Link — manual setup guide

**Smart Read More Link** (`smart_read_more_link`) is a field formatter that shows a
"Read more" link **only when there is actually more to read** — that is, only when
the trimmed teaser is genuinely shorter than the full text.

The problem it fixes is a small but persistent one. Drupal's built-in read-more
link is unconditional: it appears on every teaser, including ones where the body is
just a sentence or two and the teaser already shows all of it. Clicking such a link
loads a page identical to what the visitor was already looking at — pointless noise
on any listing of mixed-length content, and a genuine nuisance for screen-reader
users who navigate by links. Smart Read More Link behaves like core's Summary or
Trimmed Text formatter, except it compares the trimmed output against the full
value and only emits the link when the two differ.

That single comparison is the whole module. It is best suited to simple content
types with a single long-text (body) field, and the maintainers describe it as more
of a proof of concept than a fully fledged module. It has no routes, permissions,
or configuration screen — you turn it on by choosing it as a field's format. It
runs on Drupal 9, 10, and 11.

> **A note if you are installing it.** When this module was documented, Composer
> resolved `drupal/smart_read_more_link` to the **`2.0.x-dev`** branch — a git clone
> rather than a packaged release — even though tagged releases exist up to 2.0.7. A
> dev checkout has no `version:` line in its info file and leaves a `.git` directory
> in the module folder; Drupal's shipped web-server config blocks access to it (an
> nginx server returned 403 for `.git/config`), but a misconfigured server could
> expose the repository history. **Pin a tagged version explicitly** when installing
> it for real, rather than letting Composer take the dev branch.

This guide is written for a **human** configuring a field display through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure globally. On the **Manage display** tab of a content
type with a long-text/body field, set that field's **Format** to the Smart Read
More Link formatter and save. It then works like the trimmed/summary display, but
the "Read more" link only appears on items whose teaser is shorter than the full
body. Because it is chosen per field display, it is fully reversible with a single
setting change.

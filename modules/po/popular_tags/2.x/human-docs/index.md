# Popular Tags — manual setup guide

**Popular Tags** (`popular_tags`) makes tagging easier by letting authors **pick
existing tags with a click** instead of typing them into an autocomplete or picking
from a select box. On the node edit form, right below a tag field, it shows a list
of clickable tag links sorted by **popularity** — defined as how many nodes are
already tagged with each term — up to a maximum number you configure.

This solves a real editorial problem. When authors have to retype tags, they end up
creating lots of near-duplicate, closely related terms. By showing the most
commonly used tags a click away, Popular Tags nudges everyone toward a tighter,
shared vocabulary and helps authors reuse a term that already exists rather than
inventing a new one. Hovering over a listed tag even shows how many times it has been
used.

It is an editorial-UX feature with no security surface — it simply suggests existing
terms from the vocabulary for a term-reference field. It requires nothing beyond
Drupal core (just the **Taxonomy** module).

> **Naming note:** this project was originally named "popular-tags" and later
> renamed to "popular_tags". If one form does not resolve for you (in Composer or
> Drush), try the other.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no central settings form**. You switch it on per field, on the
content type's field settings — see "How to use it" below.

## Where it lives in the admin menu

Popular Tags adds no admin page of its own. You enable it on a term-reference field
from **Structure → Content types → *(your type)* → Manage fields → *(the tag
field)***, where a **Popular Tags** fieldset appears in the field's settings.

## How to use it

1. Make sure your content type has a **term-reference (tags) field** pointing at the
   vocabulary you want.
2. Go to that field's settings: **Structure → Content types → *(your type)* → Manage
   fields**, then edit the tag field.
3. Under the **Popular Tags** fieldset, tick **Use Clickable Popular Tags?** and set
   the maximum number of tags to display.
4. Save. Now when someone creates or edits a node of that type, a list of clickable
   popular tags appears right under the tag field (as long as some tags already
   exist), ordered by how often each has been used. Clicking one adds it to the
   field.

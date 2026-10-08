# Taxonomy Internal — manual setup guide

**Taxonomy Internal** (`taxonomy_internal`) lets you mark a taxonomy vocabulary
as "internal". Some vocabularies exist purely for behind‑the‑scenes organisation
— a workflow tag, an editorial category — and their term pages are not meant for
the public. When a vocabulary is marked internal, the canonical page of each of
its terms changes in two ways: it becomes accessible **only to users who are
allowed to update the term**, and it is **displayed using the administrative
theme** rather than the front‑end theme.

You turn this on per vocabulary, right on the vocabulary's edit form — there is
no separate settings page. It requires nothing outside Drupal core, depends on
core **Taxonomy**, and works on Drupal 9, 10 and 11.

It is worth being precise about what "internal" protects. The module restricts
the **canonical term page** (the term's own `/taxonomy/term/{id}` view). That is
real access control for that page. It does not, however, claim to strip the term
out of every other place it might surface — a term referenced on a node, or its
field value returned by JSON:API, is a separate question. So if your goal is
simply to keep certain term *pages* out of public view and off the front‑end
theme, this does exactly that; if your goal is to keep the term *data* itself
fully confidential everywhere, verify how those terms are exposed elsewhere on
your site rather than assuming "internal" hides them completely. For a more
general, more configurable take on controlling entity pages, the
[Rabbit Hole](https://www.drupal.org/project/rabbit_hole) module is a
more flexible (and more complex) alternative. Note that Taxonomy Internal is not
covered by Drupal's security advisory policy.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You mark a vocabulary internal on its edit
form: **Structure → Taxonomy** (`/admin/structure/taxonomy`), then **Edit** the
vocabulary.

## How to use it

1. Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`).
2. Click **Edit** on the vocabulary you want to make internal.
3. Tick the option that marks the vocabulary as **internal**, and save.

From then on, the canonical page of each term in that vocabulary is available
only to users who can update the term, and it renders in the admin theme. To
reverse it, edit the vocabulary again and clear the internal option.

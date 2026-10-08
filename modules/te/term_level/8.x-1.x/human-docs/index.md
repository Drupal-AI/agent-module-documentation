# Term Level — manual setup guide

**Term Level** (`term_level`) is a field type that stores a taxonomy term
*together with a level*, so a single reference carries both a subject and a
degree. The classic example: add the term "Java" with the level "Expert" to a
person's profile, or "French" with "Conversational."

The pattern shows up wherever a tag is not simply yes‑or‑no. A person's skills are
not just a list of technologies but a list of technologies *with proficiencies*. A
course's prerequisites have required levels; a supplier's certifications have
grades; a job's requirements have minimums. Modelling that with a plain term
reference throws away the half of the information people actually search on — a
directory that can find everyone tagged "French" but not everyone *fluent* in it
has not really answered the question. Term Level stores the term and its level in
one field item, which is the correct shape: the two alternatives (a separate term
for every subject‑and‑level combination, or two parallel fields) either explode
your vocabulary and make "any level of French" unaskable, or lose track of which
level belongs to which term once there is more than one.

You define the available levels in the field's settings — each level is a numeric
key plus a human‑readable label (for example `1 = Beginner`, `2 = Intermediate`,
`3 = Expert`). The vocabulary you reference must be either a flat list or a single
two‑level hierarchy in which the parent terms act as grouping headings. The
current widget presents the terms and their levels in a table (one table per
group), with an optional "tag cloud" row for the remaining terms, and adding or
removing terms happens over AJAX.

This is a pure **field type** — it works as soon as you add the field to an
entity and there is no site‑wide settings page. It has **no dependencies beyond
core**, ships no submodules, provides no permissions, and supports **Drupal 9.1,
10, and 11**.

Two things worth keeping in mind. Your **level scale should be a controlled,
ordered list** rather than free text, because the whole value of the field is
comparison — "at least intermediate" is a query that needs a shared, ordered
scale. And **self‑assessed levels are self‑assessed**: a skills directory built on
them records what people say about themselves, which is useful but is not a
qualification record — anything consequential (a competency framework, a
compliance register) needs a separate notion of who assessed the level and when.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no global configuration. You use Term Level by adding a field:

1. Go to the content type (or other fieldable entity) you want to extend, and open
   its **Manage fields** page.
2. Add a new field of type **Term Level**.
3. In the field settings, choose the vocabulary to reference (a flat list, or a
   single two‑level hierarchy where parents are grouping terms) and define your
   **levels** — each a numeric key with a readable label. The widget settings also
   let you control how many terms appear in the table and whether the tag‑cloud row
   is shown.
4. Save. Editors will now see the table widget on the content edit form, where they
   pick terms and assign each a level.

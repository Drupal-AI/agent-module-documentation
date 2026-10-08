# Organigrams — manual setup guide

**Organigrams** (`organigrams`) turns a Drupal **taxonomy vocabulary** into a visual
organization chart (an organigram or "org chart"). Each taxonomy term becomes a box
in the chart, and the term hierarchy — parent/child relationships and term order —
defines the layout of the tree. The chart is drawn with pure CSS (a flex layout), so
there is no heavy JavaScript or canvas involved and you can restyle the whole thing
with your own CSS.

Getting started is a one‑click affair: after enabling the module, the taxonomy
overview gains an **Add organigram** action. Using it creates an ordinary vocabulary
but flags it as an organigram and automatically adds a set of helper fields to its
terms — a **position** field (where a value of `s` marks a term as a "staff"
function, drawn to the side of the line), an **image**, a **URL** to link the box to,
and a **CSS classes** field for per‑box theming. From then on you build the chart
simply by adding and arranging terms.

A finished organigram can be shown three ways: on a dedicated page at
`/organigram/{vocabulary}`, in a **block** (one is generated per organigram
vocabulary) that you can place in any region, or embedded inside body text with a
`[organigrams:{vid}]` **token** (this needs the optional Token and Token Filter
modules). Import/export forms move an organigram's term data as JSON between sites,
and can even import from a Drupal 7 organigram.

Note this is a development release (`2.x`). This guide is written for a **human**
setting the module up through the admin UI. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and optionally add Token/Token Filter for the token display.
2. [Configuration](configuration/index.md) — creating an organigram vocabulary, the
   term fields, the three display methods, import/export, and the permissions.

## Where it lives in the admin menu

Organigrams live under taxonomy: **Structure → Taxonomy**
(`/admin/structure/taxonomy`), where the **Add organigram** action appears and
organigram vocabularies are highlighted in the list. There is no separate global
settings page. Individual charts are viewed at `/organigram/{vocabulary}`.

## How to use it

1. Go to **Structure → Taxonomy** and click **Add organigram**. Fill in the normal
   "add vocabulary" form and save — the module flags it as an organigram and adds the
   `field_o_*` helper fields for you.
2. Add **terms** to that vocabulary. Each term is a box in the chart. Use the term
   parent to nest boxes, and drag terms to set their order (which is the chart
   order). Optionally set the position, image, URL, and CSS classes on each term.
3. Display the chart on its page at `/organigram/{vocabulary}`, place its generated
   block, or embed it in text with `[organigrams:{vid}]` (with Token Filter).

See [Configuration](configuration/index.md) for the full details, including the term
fields, the display methods, import/export, and how the permissions and core
taxonomy permissions interact.

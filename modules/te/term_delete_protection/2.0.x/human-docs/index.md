# Taxonomy Term Delete Protection — manual setup guide

**Taxonomy Term Delete Protection** (`term_delete_protection`) stops editors from
deleting a taxonomy term that is still in use. If a term is tagged on any content
— a node, a Commerce product, a paragraph — the module removes the *Delete* option
for that term and explains which content is holding it in place. The result is
referential integrity: your tagged content never suddenly loses its category, and
you avoid the orphaned references, broken facets, and support tickets that follow a
careless taxonomy cleanup.

Protection is smart about hierarchies, too. A parent term is protected whenever any
of its children (or grandchildren, all the way down) is still referenced — so you
can't quietly pull the rug out from under an in-use branch by deleting its top
term. Commerce products and paragraph references are understood automatically when
those modules are installed (a paragraph reference is resolved back to the real
node or entity that contains it), and any custom content entity type with a
taxonomy-reference field is picked up as well.

You decide where protection applies. It is configured **per vocabulary**, and
within each vocabulary you choose exactly which referencing entity types count.
Vocabularies you leave alone stay freely deletable. The protection is enforced in
several layers at once — the *Delete* link disappears from term listings, the
delete button is removed from the term edit form (replaced with a warning listing
the content that uses the term), direct navigation to a term's delete URL is
blocked, and protected terms are highlighted on the vocabulary overview.

One thing to keep in mind: this is a **data-integrity guard for trusted editors**,
not a hardened access-control boundary. It is enforced through admin-facing forms,
and reference checks respect the current user's access — so treat it as a safety
net that prevents accidents, not as a permission wall against untrusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the reference-checker
service and the four protection layers in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn protection on per vocabulary and
   choose which entity types count as references.

## Where it lives in the admin menu

There is **no standalone settings page**. Protection is configured on each
vocabulary's own edit form: **Structure → Taxonomy → (edit a vocabulary)**, where a
new **Term Delete Protection** section appears.

## How to use it

Once the module is enabled, open the vocabulary you want to guard (*Structure →
Taxonomy → edit*), tick the referencing entity types in the **Term Delete
Protection** section, and save. From that moment, any term in that vocabulary that
is referenced by the selected entity types — directly, or through a descendant term
— can no longer be deleted, and editors see a clear explanation of what is using it.
Full field-by-field details are in [Configuration](configuration/index.md).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Big Pipe Paragraphs replaces the rendering of selected paragraphs in an entity-reference-revisions field with BigPipe lazy-builder placeholders, so the page shell is sent first and those paragraphs stream in afterwards.

---

Drupal core auto-placeholders uncacheable blocks so BigPipe can stream them, but the main content
block is excluded — so a node body packed with paragraphs slows the first byte of uncached pages.
This module hooks the `field` preprocess (via the Preprocess module) and, for
`entity_reference_revisions` fields whose target type is `paragraph`, swaps each qualifying
paragraph's render for a `#lazy_builder` + `#create_placeholder` so BigPipe delivers it after the
shell. You choose, per entity type + field + bundle, an **offset** (the first N paragraphs render
inline so nothing "pops in" above the fold) and a set of **skip bundles** (paragraph types never
deferred). Everything is driven by one admin form and stored in `big_pipe_paragraphs.settings`; the
module ships no permissions, no schema, and no Drush. It depends on core `big_pipe` and
`dynamic_page_cache`, plus contrib `paragraphs` and `preprocess`.

---

- Stream a paragraph-heavy node body in after the page shell to cut perceived load time.
- Send the first byte of an uncached page faster on paragraph-rich content.
- Keep the first N (offset) paragraphs rendering inline so above-the-fold content never "pops in".
- Defer only below-the-fold paragraphs to BigPipe placeholders.
- Exclude specific paragraph types (e.g. hero/banner) from deferral via skip-bundles.
- Enable lazy loading per entity type, per field, and per bundle from a single settings form.
- Speed up landing pages built as long stacks of Paragraphs.
- Improve time-to-first-byte and Core Web Vitals on Paragraphs-based layouts.
- Offload rendering cost of heavy/uncacheable paragraphs to the BigPipe stream.
- Apply deferral to any base field or configured field of type `entity_reference_revisions` → paragraph.
- Configure article node bodies to render the intro inline and lazy-load the rest.
- Tune the offset so hero + first section render immediately and later sections stream.
- Leave one paragraph field eager while deferring another on the same bundle.
- Progressively render paragraphs on pages that are uncacheable per-user.
- Combine with core BigPipe/Dynamic Page Cache already enabled on the site.
- Reduce main-thread blocking on the initial HTML response for editors' rich layouts.
- Roll out lazy paragraph loading without writing a custom formatter or preprocess hook.
- Selectively defer paragraphs on content types, media, or any entity referencing paragraphs.
- Keep a small set of critical paragraph types always rendered inline while deferring the rest.
- Adjust deferral behaviour later by editing config only — no code change.

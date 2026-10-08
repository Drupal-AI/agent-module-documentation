<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fragments provides a content entity type for reusable pieces of content — a fielded, bundleable thing that exists to be referenced from several places.

---

Drupal already has three answers to "content that appears in more than one place" and each is a compromise. **Block content** is reusable and lives in the block layout system, which makes placement configuration rather than content. **Paragraphs** are fielded and composable and are owned by their parent, so reuse across nodes is awkward and revision behaviour surprises people. **Nodes** are reusable and carry a URL, a listing presence and a whole publishing apparatus they may not want. Fragments is a fourth: a content entity with bundles and fields and no public URL of its own, designed to be referenced. That combination — fielded like a paragraph, independent like a node, invisible like a block — is what the pattern actually calls for, and Drupal's lack of it is why every large site invents one. Version **2.2.0** on core `^10.3 || ^11`, with fragment types configured at `/admin/structure/fragment-types`, the fragment listing at `/admin/content/fragments`, and permissions including `access fragments overview` and `administer fragment types`, both marked `restrict access: true`. Each fragment type also gets its own `view/create/update/delete` permissions, so you grant `view <type> fragments` to the anonymous and authenticated roles if you want fragments to appear to site visitors. Two things to settle when adopting it. **Where a fragment's access comes from**: an entity with no route still renders inside other entities, so decide whether an unpublished fragment inside a published node is visible, and check that a JSON:API or search consumer agrees. And **the reuse question that makes reuse hard** — a fragment edited in one place changes everywhere it appears, which is the point and also the failure mode, so editors need to be able to see what references a fragment before changing it.

---

- Reuse a block of content across pages.
- Share a call-to-action between nodes.
- Maintain a disclaimer in one place.
- Build reusable content components.
- Reference a fragment from several nodes.
- Avoid duplicating promotional content.
- Store a fielded component without a URL.
- Share content between content types.
- Update shared content once.
- Model a reusable teaser.
- Provide components to a page builder.
- Store contact details centrally.
- Reuse an opening-hours block.
- Share a product feature list.
- Keep reusable content out of block layout.
- Build a component library as content.
- Reference fragments from paragraphs.
- Maintain a shared notice.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Clone Simple Sitemap extends Entity Clone so that a cloned entity keeps the original's per-entity Simple XML Sitemap settings.

---

Entity Clone Simple Sitemap is a small glue module that bridges the **Entity Clone** and **Simple XML
Sitemap** modules. When an entity is cloned through Entity Clone, this module copies the original
entity's instance-level (per-entity) sitemap overrides — indexing on/off, priority, change frequency,
image inclusion — onto the newly created clone, and it does this for every sitemap variant. If the
original entity has no per-entity override (it just follows its bundle defaults), the clone is left
following the bundle defaults too, so no redundant override rows are created. There is nothing to
configure: it depends on Entity Clone and Simple XML Sitemap, works automatically once all three are
enabled, and adds no settings page, routes or permissions of its own.

---

- Clone a node and keep its Simple Sitemap "index / do not index" choice on the copy.
- Preserve a per-node sitemap **priority** value when duplicating content.
- Carry over a per-entity **change frequency** setting to the clone.
- Keep the **include images** sitemap option consistent between an entity and its clone.
- Duplicate a landing page without losing its custom XML-sitemap overrides.
- Clone a taxonomy term and retain its per-term sitemap settings.
- Clone a media entity and keep its sitemap inclusion configuration.
- Copy sitemap overrides for **every** configured sitemap variant, not just the default one.
- Maintain distinct per-variant priorities (e.g. a default and a secondary sitemap) across a clone.
- Exclude a cloned entity from the sitemap automatically when the original was excluded.
- Include a cloned entity in the sitemap automatically when the original was included.
- Avoid manually re-entering sitemap settings on each duplicated entity.
- Keep SEO/indexing behavior identical between an original and its clone.
- Bulk-duplicate content with Entity Clone while preserving sitemap intent.
- Ensure editors' sitemap decisions survive a clone-based content workflow.
- Skip writing override rows when the original only used bundle defaults.
- Let bundle-level sitemap defaults keep applying to clones untouched.
- Run entirely in the background on the Entity Clone POST_CLONE event.
- Add sitemap-clone support without patching Entity Clone or Simple Sitemap.
- Enable it alongside Entity Clone and Simple XML Sitemap and get correct sitemaps with zero setup.
- Remove the module to stop copying sitemap overrides on clone, with no other side effects.

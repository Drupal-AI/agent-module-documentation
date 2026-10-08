Entity Bundle Field adds an "Entity bundle reference" field type that stores one bundle machine name (a content type, vocabulary, or any other bundle) of a configured bundleable entity type.

---

Entity Bundle Field is a lightweight, dependency-free module that ships a single custom field type, `entity_bundle`, together with a matching widget and formatter. When you add the field to any fieldable entity (node, taxonomy term, user, paragraph, etc.), you pick, in the field's storage/settings, which bundleable entity type it should target (for example Node, Taxonomy term, Media, or Block content). On the content edit form the field then renders a select list of that entity type's bundles — its content types, vocabularies, media types, and so on — and stores the chosen bundle's machine name as a single `varchar(255)` value (cardinality is fixed at 1). On display, the formatter converts that stored machine name back into the bundle's human-readable label. This makes it easy to let editors choose a bundle as a piece of content, to drive conditional layouts or listings, or to expose the value over JSON:API/REST for a decoupled front end. It provides no routes, permissions, services, hooks, or configuration forms of its own — everything happens through Drupal's Field API plugins.

---

- Add an "Entity bundle reference" field to a content type so editors can tag a node with a target content type.
- Let editors pick a taxonomy vocabulary (by referencing the `taxonomy_term` bundle entity type) to drive a related-terms listing.
- Store a chosen media type on an entity to control which media bundle a downstream view or template should query.
- Expose a selected bundle machine name over JSON:API for a decoupled (Next.js, Nuxt, mobile) front end that needs to know "which type" without hardcoding.
- Build a "featured content type" field on a landing page node so the page can render a block of that type's latest items.
- Give editors a select of block-content bundles to configure which custom block variant a section should use.
- Capture a user-profile preference such as "preferred article category" by referencing a vocabulary's bundles.
- Drive a Views contextual filter or relationship from a stored bundle value chosen per node.
- Let site builders offer a curated dropdown of bundles without writing a custom allowed-values callback.
- Record which paragraph type an editor wants inserted in a downstream automation or template.
- Provide a simple bundle picker on a configuration/settings entity used by a custom module.
- Tag imported content with its source bundle name during a migration mapping step.
- Show the human-readable bundle label on the rendered entity via the bundled "Entity Bundle Formatter".
- Populate a select of comment types, contact form types, or shortcut set bundles for admin-facing content.
- Let an editor choose a "template bundle" whose fields a theme preprocess then mirrors.
- Offer a lightweight alternative to a full entity reference when you only need the bundle, not a specific entity.
- Build reporting or dashboard entities that group data by a chosen bundle.
- Capture the intended destination bundle for a content-moderation or workflow routing rule.
- Store a per-node "gallery type" or "layout type" chosen from the site's available bundles.
- Give a decoupled editor UI a stable machine-name value it can map to its own component registry.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Singleton provides a fieldable content entity type where each bundle is a singleton — exactly one instance per bundle.

---

Content Singleton defines a `content_singleton` content entity type and a `content_singleton_type` bundle config entity, and enforces (via a `Singleton` validation constraint) that each bundle type has at most one entity instance. Each bundle is fieldable through Field UI, revisionable, translatable, and editorial (publish/unpublish). Each type gets a clean frontend path (e.g. `/about-us`) resolved by an inbound/outbound path processor that rewrites the clean URL to the canonical entity route, so you can model site-wide one-off pages — About Us, Contact, Privacy Policy, a homepage settings record, a global banner — as real fieldable entities instead of a config form or a lone node. It requires PHP 8.3 and Drupal core `^11`, ships its own base + per-bundle permissions, provides config schema, and exposes singleton data to Views.

Use it for single-instance fieldable content. Types are created at `/admin/structure/content-singleton` (needs "administer content singletons"); content is created at `/content-singleton/add` and listed under `/admin/content`. Published singletons are viewable by everyone at the type's frontend path; unpublished content and all admin operations are gated by base and per-bundle permissions.

---

- Model an "About Us" page as a fieldable singleton with a `/about-us` path.
- Model a "Contact" page as a one-off entity with custom fields.
- Model a "Privacy Policy" or "Terms of Service" page.
- Store site-wide "Homepage settings" as an entity, not a config form.
- Keep a single "Global banner" record with fields and revisions.
- Enforce exactly one instance per bundle automatically.
- Add any Drupal field type to a singleton bundle via Manage fields.
- Configure the render output via Manage display.
- Give each singleton type a custom clean frontend URL path.
- Fall back to the bundle machine name as the path when none is set.
- Track full revision history for each singleton.
- Revert a singleton to an earlier revision.
- Delete old (non-default) revisions of a singleton.
- Publish or unpublish a singleton independently.
- Translate singleton content into multiple languages.
- Grant per-bundle view/edit/delete permissions to specific roles.
- Grant per-bundle revision view/revert/delete permissions.
- Expose singleton fields to Views for custom listings.
- Show the "Add singleton" action only while a bundle without content remains.
- Redirect straight to the add form when only one bundle is still empty.
- Integrate with Mercury Editor's edit tray when that module is present.
- Work with Content Moderation drafts on singleton entities.
- Provide an admin overview of all singleton content.
- Replace scattered "special node" or "config form" patterns for one-off content.

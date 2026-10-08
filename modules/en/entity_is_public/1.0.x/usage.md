<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An API (service + hooks) for determining whether a content entity or entity type is publicly accessible to anonymous users.

---

Entity Is Public centralises the question "is this entity visible to an anonymous visitor?" into one service (`entity_is_public`) and a small hook API. Instead of every feature re-implementing anonymous-access logic, callers ask the service, which combines entity-type eligibility (content entity, not internal, has a canonical URL and a view builder), published status, and a real anonymous `view` access check, then lets modules veto the answer via `hook_entity_is_public()` and `hook_entity_is_public_alter()`. It is useful wherever code should act only on content meant for public consumption — sitemaps, search indexing, feeds, noindex tagging.

It reports accessibility; it does not itself grant or restrict access — authoritative access control stays with core and `hook_entity_access`. The module ships opinionated integrations with Field Redirection, Metatag, Micronode, Path, Rabbit Hole, System (403/404 pages), Trash and XML Sitemap, so non-public entities are automatically excluded from sitemaps and marked `noindex, nofollow`. It depends on the `helper` module and supports Drupal 10.2+, 11 and 12. Configure which entity types count as public at `/admin/config/system/entity-is-public`.

---

- Ask, from code, whether a specific entity is public: `\Drupal::service('entity_is_public')->isPublic($entity)`.
- Ask whether an entire entity type is considered public: `isTypePublic($entity_type_or_id)`.
- Check whether an entity type is even eligible to be public: `isApplicableType($entity_type)`.
- Filter a list of entities down to only those visible to anonymous users before rendering a feed.
- Exclude non-public nodes from a generated XML sitemap (built-in xmlsitemap integration).
- Automatically add `noindex, nofollow` robots metatags to entities that are not public (built-in metatag integration).
- Treat entities with a `noindex` robots metatag as non-public.
- Mark entities using the Field Redirection formatter as non-public so redirect targets are not indexed.
- Exclude Micronode microcontent nodes from public listings.
- Exclude entities handled by Rabbit Hole with a non "Display page" action from public output.
- Keep the site's configured 403 and 404 pages out of public listings.
- Exclude trashed (soft-deleted) entities from public output.
- Optionally require a URL alias before an entity counts as public (Path integration, off by default).
- Choose per entity type, in the settings form, which types are public by default.
- Reset and recalculate the default public entity types after adding new modules or entity types.
- Disable Media as public automatically when the Media "Standalone media URL" option is off.
- Add your own veto rule for public status by implementing `hook_entity_is_public()` in a custom module.
- Perform a final tweak to a public/non-public decision with `hook_entity_is_public_alter()`.
- Override an entity type's public status programmatically via `hook_entity_type_is_public_alter()`.
- Declare an entity type public/non-public directly by setting its `public` entity-type property.
- Build a custom "should this be in search results?" gate on top of a single, consistent definition of public.
- Avoid re-writing anonymous-access + published + eligibility checks in every module that needs them.
- Guard against recursion when calling the service from inside a hook by passing `skipModules`.

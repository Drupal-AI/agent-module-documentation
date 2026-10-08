<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Url Entity is a single service: give it a URL and it tells you which entity that URL points at. It exists so that every project stops writing the same fragile path-parsing helper.

---

Resolving a URL to an entity is a recurring need — a link field pointing at a node, a redirect target, an editor-pasted internal link, a menu item — and the naive implementations are all subtly wrong: they split on `/`, assume `/node/{nid}`, and break on path aliases, language prefixes, or any entity type that is not a node. The correct approach goes through Drupal's router, and that is what `UrlEntityExtractor` (behind `UrlEntityExtractorInterface`) encapsulates. The module is five files: the class, its interface, the services file, the info file and the licence. There are no routes, permissions, configuration, entities, hooks or dependencies, and it declares `php: 7.4` with core `^9 || ^10 || ^11`. Its usefulness is entirely as a dependency: another module requires it, injects `url_entity.extractor`, and stops carrying its own copy of the logic. Enabling it on a site where nothing depends on it does nothing at all.

---

- Resolve a URL to the entity it points at.
- Handle path aliases correctly when parsing links.
- Support entity types other than nodes.
- Extract an entity from a link field value.
- Work out what a redirect targets.
- Parse an internal link pasted by an editor.
- Avoid hand-rolled path splitting.
- Cope with language-prefixed paths.
- Build a link checker that understands entities.
- Resolve menu link targets to entities.
- Share one utility across several custom modules.
- Look up an entity from a Views field value.
- Reduce duplicated helper code in a codebase.
- Support a custom entity type without extra work.
- Inject the extractor as a service.
- Handle URLs with query strings or fragments.
- Validate that a submitted URL points at real content.
- Underpin a related-content or backlink feature.

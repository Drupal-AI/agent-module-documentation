Menu Normalizer supplies the Serializer normalizers that Drupal core is missing for menu-link objects, so `MenuLinkInterface` and `MenuLinkTreeElement` instances can be (de)serialized to JSON/XML.

---

The module registers two services tagged `normalizer` (`menu_normalizer.services.yml`): `MenuLinkNormalizer` for any `MenuLinkInterface`, and `MenuLinkTreeNormalizer` for `MenuLinkTreeElement`. `MenuLinkNormalizer::normalize()` returns a flat array of a link's data — id (plugin id), weight, title, description, menu_name, provider, parent, enabled/expanded flags, resettable/translatable/deletable flags, route_name, route_parameters, the resolved `url` string, options, meta_data, and the delete/edit routes. `MenuLinkTreeNormalizer::normalize()` returns `link`, `has_children`, `depth`, `in_active_trail`, `subtree` (recursively normalized), and `count`, so a whole menu tree serializes in one pass. The module has no UI, no configuration, no permissions, and adds no routes — it is pure plumbing you install because another module or your own code needs to serialize menus (e.g. exposing a menu over a custom REST/JSON endpoint or to a decoupled front end). As the README states, it does nothing on its own; only install it when something depends on it.

---

- Serialize a Drupal menu tree to JSON for a decoupled/headless front end.
- Expose the main navigation menu over a custom REST resource.
- Return a menu's link structure from a controller using the core `serializer` service.
- Include menu-link objects in a normalized API payload without writing your own normalizer.
- Deserialize incoming menu-link data in an integration.
- Provide menu data to a JavaScript app that builds its own navigation UI.
- Emit a nested menu tree (with depth and children flags) in a single serialization call.
- Feed a static-site generator the site's menu structure as JSON.
- Add menu output to an existing web-services integration that already uses Serialization.
- Normalize `MenuLinkTreeElement` results from `MenuLinkTreeInterface::load()`.
- Surface each link's resolved URL string alongside its route name/parameters.
- Include per-link capability flags (enabled, expanded, deletable, translatable) in an API.
- Satisfy a dependency of another contrib module that serializes menus.
- Build a menu-export tool that dumps menus to a serializable format.
- Provide menu data to a mobile app backend.
- Return active-trail information (`in_active_trail`) to a client rendering breadcrumbs.
- Normalize menus for caching or diffing between environments.
- Send menu structure to a search/index pipeline.
- Give a Twig/JS component library the menu tree as structured data.
- Avoid maintaining a bespoke menu-to-array converter in custom code.

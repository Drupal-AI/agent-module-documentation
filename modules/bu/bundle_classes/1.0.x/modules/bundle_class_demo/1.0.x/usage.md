Bundle Class Demo is an Olivero sub-theme, bundled inside the Bundle Classes example project, whose article node template calls a bundle-class method to prove the pattern works end to end.

---

The theme (`themes/bundle_class_demo/` in the `bundle_classes` project) sets `base theme: olivero` and re-declares Olivero's standard regions. Its only functional content is `templates/node/node--article.html.twig`, an override of Olivero's node template that, inside the node content area, prints `{{ node.getLastUpdatedDate }}` between HTML comments marking the demo inclusion. That method is provided by the `Article` bundle class in the parent module, so enabling this theme alongside the module makes a formatted "Last updated" date appear on article nodes. It is strictly a demonstration/teaching theme and is not intended for production use.

---

- See a real Olivero sub-theme that consumes a bundle-class method from a Twig template.
- Learn how to override `node--article.html.twig` to call `{{ node.getLastUpdatedDate }}`.
- Enable it (`drush theme:enable bundle_class_demo` + set as default/appearance) to view the demo live.
- Study how a bundle-class method's render array is printed inline in node content.
- Copy the `base theme: olivero` info.yml pattern for your own Olivero sub-theme.
- Understand where in a node template a computed "Last updated" line can be injected.
- Compare template-level output (`{{ node.getLastUpdatedDate }}`) against the old preprocess approach.
- Reference the region list needed when sub-theming Olivero.
- Confirm the parent `bundle_classes` module's `Article` class is active by seeing its method render.
- Use as a minimal example when teaching Twig access to entity object methods (get*/has*/is* whitelist).

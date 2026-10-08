<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Single Directory Components: Tagging (sdc_tags) lets modules and themes declare named "tags" that Single Directory Components can opt into, so other features (e.g. a component picker in a site-building tool) can restrict themselves to the components carrying a given tag.

---

A submodule of cl_editorial. It defines a `component_tag` plugin type: modules/themes declare tags in a `MODULE.component_tags.yml` file (each entry has a `label` and `description`), discovered by `ComponentTagPluginManager` (service `plugin.manager.sdc_tags.component_tag`, alter hook `component_tag_info`, default class `ComponentTagDefault`). For each tag an admin defines *tagging rules* — a set of allowed component ids, forbidden component ids, and permitted lifecycle statuses — through the UI at `/admin/config/user-interface/sdc/component-tagging` (list, `ComponentTaggingController`) and `…/auto/{tag}` (`AutoTaggingForm`), reusing cl_editorial's `ComponentFiltersFormTrait`. The rules are stored in the `sdc_tags.settings` config object under `component_tags.<tag_id>` = `{tag_id, statuses[], allowed[], forbidden[]}`. Other code reads the resolved rule via `sdc_tags_get_tag_filters($tag_name)` (or `ComponentTagDefault`/`NoThemeComponentManager::getFilteredComponents()`), turning a tag into a concrete list of components. There is no `configure` info.yml key (so `configure` is null even though a UI exists), no permissions of its own (the routes require `administer site configuration`), and no Drush. It relies on its parent cl_editorial at runtime.

---

- Declare a "hero" tag in `mymodule.component_tags.yml` so only hero-suitable components appear in a chooser.
- Give a page-building tool a curated subset of components by tagging them.
- Restrict a tag to only stable components (exclude experimental/deprecated/obsolete).
- Allow-list a specific handful of components for a "landing page" tag.
- Forbid a few components from an otherwise all-components tag (present and future components included).
- Define separate tags for different editorial contexts (e.g. `article-body` vs `sidebar`).
- Let a theme declare tags its templates understand, alongside module-declared tags.
- Resolve a tag to its concrete component list in code with `sdc_tags_get_tag_filters('mytag')`.
- Preview which components currently carry each tag from the tagging admin page (component cards).
- Update tagging rules over time without code changes, via the auto-tagging form.
- Share one tagging vocabulary across several site-building modules.
- Constrain a component field/widget to components of a given tag.
- Tag components by lifecycle status so deprecated ones are quietly dropped from pickers.
- Provide integration metadata so other modules "understand components better".
- Keep the allowed and forbidden lists mutually exclusive (the form validates against overlap).
- Store tagging configuration as exportable config (`sdc_tags.settings.component_tags.*`).
- Drive a component recommendation UI from tag membership.
- Let modules ship default tags that site builders then refine per site.
- Group components into design-system buckets (atoms, molecules) via tags.
- Combine with cl_editorial's component selector to filter selectable components by tag rules.

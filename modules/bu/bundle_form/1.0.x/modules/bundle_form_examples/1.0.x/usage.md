<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bundle form examples ships ready-made `@BundleForm` plugins that demonstrate how bundle_form overrides node, taxonomy term and paragraph forms per bundle.

Enabling it registers five example plugins under `src/Plugin/BundleForm/`: two for the Article node bundle (one at weight -10 re-showing the title, one at weight 10 hiding it — demonstrating weight-ordered execution), one hiding the body on the Page node bundle, one hiding the name on the Tags taxonomy term bundle, and one hiding a field on the Paragraph `type_1` subform. Each simply toggles a form element's `#access`, so the module is a live, copy-ready reference for writing your own bundle form plugins rather than a feature to run in production.
---
Reference submodule with example bundle_form plugins for node, term and paragraph bundles.
---
- See a minimal `@BundleForm` plugin for a node bundle (article, page)
- See a bundle_form plugin for a taxonomy term bundle (tags)
- See a bundle_form plugin for a paragraph bundle (type_1)
- Learn how two plugins on the same bundle run in weight order
- Copy `ArticleForm` / `PageForm` as a starting template for a node override
- Copy `TagsForm` as a starting template for a term override
- Copy `Type1Form` as a template for a paragraph subform override
- Understand the annotation keys (entity_type, bundle, weight, label) in practice
- See how to hide a form field with `#access` = FALSE per bundle
- See how a lower-weight plugin can re-enable what a higher-weight one changes
- Verify bundle_form is installed and dispatching correctly on a test site
- Learn where to place plugin classes (`src/Plugin/BundleForm/{EntityType}/`)

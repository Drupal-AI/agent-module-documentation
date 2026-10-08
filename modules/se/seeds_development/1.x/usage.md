Seeds Developer Helper adds admin utilities for inspecting image-style usage, scaffolding form-display field groups, testing responsive image styles, and translating field labels.

---

Seeds Developer Helper is a developer-productivity module from the Seeds distribution ecosystem. It bolts a handful of tools onto Drupal's existing admin screens rather than adding new content or entity types. The image-style inspector reports where each image style is used across responsive image styles, entity view displays, and exported configuration files, and lists styles that appear unused so they can be cleaned up. A field-group generator adds a "Generate Basic Groups" local action to form-display screens that creates a predefined tabs structure (Basic Information and Media tabs) in one click, using the contrib field_group module. A responsive-image test page renders every configured responsive image style against a bundled sample image so mappings can be verified visually. A per-bundle "Translate Fields" form lets you edit field labels for each configured language on multilingual sites. Everything is exposed under the admin area and protected by a single "access seeds development" permission, and the module declares no hard dependencies, so it is intended to be enabled in development or staging environments where the underlying core image/responsive_image and contrib field_group tooling is available.

---

- Inspect a single image style to see every place it is referenced before deleting or renaming it.
- Find image styles that no responsive image style, view display, or config file references (candidates for removal).
- Audit responsive image styles that reference a given image style (fallback style or breakpoint mappings).
- Discover which entity view displays render a field with a specific image style, with direct links to each Manage Display screen.
- Grep exported configuration in the config sync directory for references to an image style id.
- Add an "Inspect" operation link to each row on the Image Styles admin collection page.
- Add an "Unused image styles" local action to the Image Styles collection page.
- Clean up image assets in a theme or distribution by identifying orphaned image styles.
- Scaffold a standard Tabs / Basic Information / Media field-group layout on a content type's default form display in one click.
- Speed up building consistent admin form layouts across many bundles using the "Generate Basic Groups" local action.
- Bootstrap field_group structures on a new content type without manually creating each group.
- Visually test every responsive image style at once against a known sample image (test.jpg).
- Verify responsive image breakpoint mappings render as expected after configuring breakpoints and image styles.
- Provide a quick QA page for reviewing responsive image output before launch.
- Translate field labels per language for a content type or other fieldable bundle on a multilingual site.
- Bulk-edit field label translations for all configured languages from a single table form.
- Manage config-language overrides for field labels without navigating each field's translate screen individually.
- Restrict all of the above dev tooling behind one "access seeds development" permission granted only to developers.
- Use during Seeds distribution setup to inspect and tidy the profile's shipped image styles and displays.
- Reduce the manual steps of Drupal's Manage Form Display and image-style admin during theme and site building.
- Give a development team a shared set of inspection tools without installing a heavier debugging suite.

Copy field machine name adds an admin tab to each content type that lists its fields with a one-click button to copy each field's machine name to the clipboard.

---

Copy field machine name is a small developer-experience (DX) helper for site builders and themers. Once enabled per content type, it exposes a "Manage Copy fields" local task tab on the node-type edit page (`/admin/structure/types/manage/{node_type}/copy-field`) that renders a two-column table — field Label and Machine name — for every `field_`-prefixed field on that bundle. Each machine name row includes a small clippy icon; clicking it uses the bundled clipboard.js library to copy the machine name and briefly shows a "Copied!" popup, so you never have to retype or hand-select strings like `field_body_summary` when writing Twig templates, preprocess functions, Views configuration, or migration mappings. The feature is opt-in per content type: a "Use copy field" checkbox is added to the node-type edit form and stored on the node type's own config (`node.type.<bundle>:use_copy_field`); the copy tab only appears and is only reachable while that box is checked. Access is limited to users with the core `administer content types` permission. The module ships no configuration UI of its own, no permissions, and no external dependencies beyond core's node module.

---

- Enable the "Use copy field" checkbox on `/admin/structure/types/manage/article` to expose the copy tab for the Article content type.
- Open the "Manage Copy fields" tab on a content type to see every custom (`field_`-prefixed) field's label and machine name in one table.
- Copy a field machine name like `field_subtitle` with a single click while writing a Twig template such as `node--article.html.twig`.
- Grab a machine name to reference in a `hook_preprocess_node()` or `template_preprocess` function without opening the field settings page.
- Copy field machine names when configuring a View's field, filter, or sort handlers.
- Look up the exact machine name of a field to use in a Feeds or Migrate source-to-destination mapping.
- Copy a field machine name into a REST/JSON:API request or normalizer configuration.
- Speed up custom formatter, widget, or field-plugin development by copying target field names.
- Give junior site builders a discoverable, click-to-copy reference of a bundle's field names.
- Confirm the actual stored machine name (vs. the human label) before writing conditional logic against `$node->get('field_x')`.
- Enable the feature only on the content types your team actively themes, keeping other bundles' edit pages unchanged.
- Turn the feature off per content type by unchecking the box, which immediately hides and blocks the copy tab.
- Restrict the copy tab to trusted administrators via the core `administer content types` permission.
- Deploy the module only in development/staging by managing its enabled state with Config Split.
- Copy machine names into automated test fixtures or PHPUnit data providers that assert on field values.
- Reference copied machine names in `.install`/`hook_update_N` code that manipulates field data.
- Copy the machine name for use in token/placeholder patterns that target a specific field.
- Use the copy tab as a quick audit of which custom fields a content type actually has.
- Reduce copy/paste typos when wiring up Layout Builder or Display Suite field placements.
- Uninstall cleanly: the module removes its `use_copy_field` flag from every `node.type.*` config on uninstall.

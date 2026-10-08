Layout Builder Save And Edit adds a "Save and edit layout" button to Layout Builder forms so that saving a layout returns you to the same layout-editing page instead of ending the Layout Builder session.

---

The module has no configuration, no routes, no permissions, and no settings of its own — it is a single `hook_form_alter` implementation. On any Layout Builder defaults form (`DefaultsEntityForm`) or per-entity override form (`OverridesEntityForm`) it clones the existing Save submit button into a second action labelled "Save and edit layout". It also adds the same button to a content entity's create/edit form when that entity has a `layout_builder__layout` override field and the current user holds the corresponding `configure editable {bundle} {entity_type} layout overrides` permission (delete forms are skipped). Clicking the new button runs Drupal's normal save, then redirects: on the Layout Builder forms it returns to the current path, and on content forms it returns to the entity's Layout Builder overrides view route (`layout_builder.overrides.{entity_type}.view`). A prepended validation handler detects the custom button by its `data-drupal-selector` and appends the redirect submit handler only for that trigger, and it strips any `destination` query parameter so the redirect always wins. The default "Save layout" button is left untouched, so editors keep the normal "save and exit" behaviour alongside the new "save and keep editing" one.

---

- Give site builders a "save and keep editing" button on the Layout Builder defaults form for a content type, block type, or other entity display.
- Let content editors save an individual node's layout override and land straight back on the Layout Builder canvas to keep arranging blocks.
- Avoid losing your place in Layout Builder after every save when building a complex multi-section layout.
- Iterate quickly on a layout by saving checkpoints without exiting the editing UI.
- Keep both behaviours available: the stock "Save layout" to save-and-exit and the added "Save and edit layout" to save-and-stay.
- Speed up building default layouts for a new content type's display.
- Add the stay-in-editor button to Layout Builder override pages reached from a node edit form.
- Reduce round trips when repositioning many inline blocks in a single layout.
- Provide the button on any content entity edit form that exposes a `layout_builder__layout` override field (nodes, media, taxonomy terms, custom entities).
- Gate the button on content forms behind Layout Builder's per-bundle "configure editable ... layout overrides" permission so only authorised editors see it.
- Preserve editing context when tuning section settings and block configuration repeatedly.
- Let designers preview-then-continue: save the layout, see it re-rendered, and immediately adjust.
- Support workflows where a layout is built incrementally across a work session.
- Return to the correct overrides view route automatically after saving from a node form, without a manual redirect config.
- Remove a lingering `destination` parameter so the save-and-edit redirect is not overridden by an upstream link.
- Improve editor ergonomics on sites that rely heavily on per-entity Layout Builder overrides.
- Cut clicks for teams that repeatedly enter and exit Layout Builder for the same page.
- Offer a lightweight, config-free enhancement that works immediately on `drush en`.
- Use as a drop-in usability patch for core Layout Builder without altering core.
- Help onboarding editors who find the default save-and-exit flow disorienting.
- Apply the enhancement site-wide to every Layout Builder form at once by simply enabling the module.

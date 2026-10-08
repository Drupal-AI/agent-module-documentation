Display Builder for Views registers a Views display extender and builder screen so a view's output (rows, header, footer, pager, exposed form…) can be built with Display Builder components.

---

`display_builder_views` connects Display Builder to Views. On install it adds `display_builder` to the `views.settings` `display_extenders` list, registering a `DisplayExtender` Views plugin so any view display can opt into being built with Display Builder. It provides a `view_display` buildable plugin, a builder screen reachable from the Views UI at `/admin/structure/views/view/{view}/display-builder/{display}` (gated by `administer views` + `_entity_access: view.update`, rendered as a clean full page), a management index at `/admin/structure/views/display-builder`, a delete confirm form, and a rich set of UI Patterns sources exposing each Views output region — rows, header, footer, empty, pager, more link, feed icons, exposed form, and the before/after attachments. Routes are added dynamically via a `DisplayBuilderRoutes` route subscriber. It depends on `views`, `display_builder`, and `ui_patterns:ui_patterns_views`.

---

- Build a Views display's output with Display Builder components instead of Views' own display UI.
- Opt a view display into Display Builder via the registered `display_builder` display extender.
- Reach the builder from the Views UI at Structure → Views → (view) → Display builder.
- Lay out the view's result **rows** with a component (`ViewRowsSource`).
- Place the view **header** and **footer** areas as components (`ViewHeaderSource`, `ViewFooterSource`).
- Render the view's **empty** text region with a component (`ViewEmptySource`).
- Place the **pager** (`ViewPagerSource`) and **more** link (`ViewMoreSource`).
- Place **feed icons** (`ViewFeedIconsSource`) and the **exposed form** (`ViewExposedSource`).
- Place attachment-before / attachment-after displays (`ViewAttachmentBeforeSource`, `ViewAttachmentAfterSource`).
- Browse all Display-Builder-enabled views at Structure → Views → Display builder.
- Delete a view's Display Builder configuration with a confirm form.
- Preview a Views display live inside the builder iframe.
- Keep the rest of the view (filters, sorts, relationships) in Views while theming output in Display Builder.
- Use it as the Views piece of a full design-system build with UI Suite themes.
- Restrict access with the core `administer views` permission plus per-view update access.

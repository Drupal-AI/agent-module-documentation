Display Builder for page layout adds a page_layout config entity and a page display variant so whole pages can be laid out with Display Builder instead of the block layout.

---

`display_builder_page_layout` brings Display Builder to page-level layout. It defines a `page_layout` config entity (managed at Structure → Page layouts, `/admin/structure/page-layout`) whose display is built with the Display Builder canvas, and a `PageLayoutPageVariant` display variant plus a `PageVariantSubscriber` that makes Drupal render matching pages through that layout — an alternative to placing blocks in theme regions with the core Block layout. It ships a `page_layout` buildable plugin, page-level UI Patterns sources (`PageTitleSource`, `MainPageContentSource`, `PageLayoutSource`), a `PageRegionSourceBase`, page/region Twig templates, a `BuilderDataConverter` that seeds a layout from the theme's block placements, a `StartingPointType`, the `administer page_layout` permission, and a `DefaultPageLayoutAccess` check for the default-layout route. It depends only on `display_builder`.

---

- Create a page layout at Structure → Page layouts → Add.
- Build a page layout's regions and content with the Display Builder canvas.
- Create the site's default page layout (guarded by `DefaultPageLayoutAccess`).
- Place the page title as a component via `PageTitleSource`.
- Place the main page content placeholder via `MainPageContentSource`.
- Compose header/content/footer style regions with components instead of theme-region blocks.
- Seed a new layout from the theme's existing block placements (`BuilderDataConverter`).
- Preview a page layout live, pinned to the real page it renders.
- Duplicate an existing page layout as a starting point for another.
- Edit a page layout's metadata (label, etc.) via its entity form.
- Delete a page layout that is no longer used.
- Restrict who can manage page layouts with the `administer page_layout` permission.
- Choose a starting point when creating a layout (`StartingPointType`).
- Use it as the page-level piece of a full design-system build with UI Suite themes.
- Render whole pages through a Display-Builder-driven page variant.

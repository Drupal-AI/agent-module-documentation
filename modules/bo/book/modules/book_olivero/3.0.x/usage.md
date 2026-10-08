Book Olivero is a small submodule of Book that supplies styling and Twig template overrides so book navigation looks correct in Drupal's Olivero front-end theme.

---

Enable `book_olivero` when your site's front-end theme is Olivero and you use the Book module's navigation. It ships Olivero-specific overrides of the `book-navigation` and `book-tree` templates plus a `navigation.css` stylesheet (declared in `book_olivero.libraries.yml`), so the book outline/tree renders with Olivero's look and spacing. It depends on `book` and has no configuration, permissions, services or plugins of its own — it is purely presentational. If you use a different theme you do not need it; if you theme books yourself you can leave it disabled and override the parent module's templates directly.

---

- Make Book navigation render correctly styled inside the Olivero front-end theme.
- Override the `book-navigation.html.twig` template for Olivero.
- Override the `book-tree.html.twig` template for Olivero.
- Load Olivero-specific book navigation CSS (`css/navigation.css`) via the module's library.
- Ship a consistent book outline appearance on Olivero-based sites without custom theming.
- Serve as a reference example for theme-specific Book template overrides.
- Keep Book navigation styling out of the base Book module so non-Olivero sites stay lean.
- Pair with the parent Book navigation block when the active theme is Olivero.
- Provide drop-in Olivero styling after enabling the Book module on a fresh Olivero site.
- Avoid writing your own Olivero book templates by enabling this bundled submodule.
- Ensure book tree indentation/links match Olivero's typography and spacing.
- Support Olivero as the default Drupal 11 front-end theme for book-based documentation sites.
- Cleanly separate presentation (this module) from book logic (parent module).
- Toggle Olivero book styling on/off simply by enabling/disabling the submodule.
- Use as a starting point to fork Olivero book templates into a custom subtheme.

Responsive Preview Navigation surfaces the responsive-preview device controls as icons in Drupal core's new Navigation top bar, instead of (or alongside) the classic admin toolbar tab.

---

This submodule of Responsive Preview integrates with core's `navigation` module by registering a `TopBarItem` plugin (`responsive_icons`) in the `Tools` region of the top bar. The plugin reuses the parent's `responsive_preview` service to fetch the current page's preview URL and, when available, renders Desktop and Mobile buttons carrying the same `data-responsive-preview-*` attributes the main module's JavaScript understands. It depends on both `responsive_preview` and the core `navigation` module, and requires Drupal `^11.1` (top-bar API). Access is gated by the parent's `access responsive preview` permission. It ships its own theme hook (`responsive_preview_navigation`) and a small CSS library, and attaches the parent's `drupal.responsive-preview` library so the preview behaves identically. It adds no configuration, no permissions and no config schema of its own.

---

- Show responsive preview controls in the core Navigation top bar instead of the legacy toolbar
- Give editors quick Desktop/Mobile preview buttons on sites using the new Navigation UI
- Keep responsive preview available after migrating a site to core Navigation
- Provide device-preview icons in the top bar's Tools region
- Reuse the parent module's preview logic and JavaScript within the Navigation experience
- Offer preview access controlled by the existing `access responsive preview` permission
- Add a Mobile (768×1280, portrait) preview shortcut in the top bar
- Add a Desktop (1280×768, landscape) preview shortcut in the top bar
- Preview node drafts and front-end pages without the classic admin toolbar enabled
- Style the top-bar preview icons via the module's `responsive-preview.navigation.css`
- Extend the top bar with responsive preview for a modern admin theme
- Ensure preview icons only appear when the current route actually has a preview URL
- Hide the preview icons automatically for users lacking preview permission
- Integrate responsive preview into a Navigation-based editorial workflow
- Provide a lightweight, config-free preview entry point for the top bar

Anu LMS Example: Custom paragraph is a developer example showing how to add a custom paragraph type to Anu LMS by shipping your own rebuilt React bundles.

---

Anu LMS renders lessons with a compiled React application, so adding a new paragraph/component means rebuilding the front-end bundles and getting Drupal to load yours instead of the module's. This example (package "Anu LMS Examples") shows the loading half: `anu_lms_custom_paragraph_library_info_alter()` (`hook_library_info_alter`) intercepts the `anu_lms` extension's libraries and rewrites every JS path from `js/dist` to this module's own `js/dist` directory (an absolute path resolved with `extension.list.module`). After you add your paragraph type's config and build a bundle that includes its React component into this module's `js/dist`, the swapped library makes the site serve your build. It ships no config or component of its own — it is the wiring pattern to copy.

Enable it only as a reference while building a custom paragraph. In production you would implement the same `hook_library_info_alter` in your project module alongside the new paragraph type config and compiled assets.

---

- Learn how to extend the Anu LMS React UI with a new paragraph type.
- Redirect Anu LMS JS libraries to a project's own compiled bundles via `hook_library_info_alter`.
- Ship a rebuilt front end that includes custom lesson components.
- Use as a scaffold for a project-specific paragraph + React component.
- Understand how Anu LMS separates content model (Drupal paragraphs) from UI (compiled JS).
- Keep the base module untouched while overriding its front-end assets.

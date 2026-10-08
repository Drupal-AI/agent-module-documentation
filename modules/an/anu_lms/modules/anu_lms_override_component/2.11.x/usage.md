Anu LMS Example: Component override is a developer example showing how to replace an existing Anu LMS React component with your own build.

---

Because the Anu LMS learner UI is a compiled React application, customising a stock component (a paragraph renderer, a navigation control, etc.) means rebuilding the front-end bundles and having Drupal load yours in place of the module's. This example (package "Anu LMS Examples") shows the loading half: `anu_lms_override_component_library_info_alter()` (`hook_library_info_alter`) intercepts the `anu_lms` extension's libraries and rewrites every JS path from `js/dist` to this module's own `js/dist`, so the site serves your rebuilt bundles. It is identical in mechanism to `anu_lms_custom_paragraph`, but framed around replacing an existing component rather than adding a new paragraph. It ships no config or component of its own.

Enable it only as a reference while building an override. In production you implement the same hook in your project module and place your compiled assets there.

---

- Learn how to override a stock Anu LMS React component.
- Redirect Anu LMS JS libraries to a project's own compiled bundles via `hook_library_info_alter`.
- Ship a customised learner UI without forking the base module.
- Use as a scaffold for a project-specific component override.
- Understand the compiled-front-end override pattern used across Anu LMS example modules.
- Keep base-module assets intact while swapping in your build.

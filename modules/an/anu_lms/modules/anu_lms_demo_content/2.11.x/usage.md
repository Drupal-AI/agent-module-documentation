Anu LMS Demo content seeds a ready-made demo catalogue of Anu LMS courses and lessons on install, and removes it cleanly on uninstall.

---

This submodule is an evaluation/testing aid. On `hook_modules_installed` (fired for itself, so configuration such as pathauto patterns is ready first) it programmatically builds a demo catalogue: two course categories and two course labels, a filtered `courses_landing_page`, and two courses. The first course ("Learn Anu lesson item types [DEMO]") contains one lesson per paragraph type — headings, text and footnotes, ordered/unordered lists, image / wide image / thumbnail, highlights (full-width, marker and image variants in several colours), simple and numeric dividers, an embedded YouTube video, a checklist, and a table — so every lesson component can be seen at once. The second course ("Modules, lessons and sections [DEMO]") demonstrates course navigation across multiple modules, lessons and sections. A cover image is written from the bundled `anu-logo.png`. Every entity it creates (nodes, paragraphs, taxonomy terms, the file) is recorded in the `anu_lms_demo_content.entities` Drupal state key, and `hook_uninstall` deletes them all, so the demo can be added and removed without residue.

Enable with `drush en anu_lms_demo_content -y` on a site with Anu LMS installed; uninstall to remove the demo content. It has no configuration, routes, services or permissions of its own — it is install/uninstall logic only, and is not meant for production sites.

---

- Instantly populate a fresh Anu LMS site with realistic demo courses for evaluation.
- See every lesson paragraph type rendered in one "lesson item types" course.
- Demonstrate module → lesson → section navigation with a second course.
- Provide demo course categories, labels and a filtered courses landing page.
- Give designers/themers real content to style against without manual authoring.
- Seed content for automated/functional tests (the module's own tests reuse it).
- Remove all demo content cleanly on uninstall via tracked entity IDs in state.
- Use as a worked example of programmatic Anu LMS content creation
  (`anu_lms_demo_content_create_entities()`).

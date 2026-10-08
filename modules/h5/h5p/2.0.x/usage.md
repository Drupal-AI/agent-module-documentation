H5P lets you add rich, interactive HTML5 content (quizzes, interactive video, presentations, games, etc.) to Drupal by providing an `h5p` field type that stores and renders uploaded or authored H5P packages.

---

The H5P module integrates the H5P framework (via the `h5p/h5p-core` and `h5p/h5p-editor` PHP libraries) into Drupal. It defines a field type `h5p` ("Interactive Content – H5P") with a default widget `h5p_upload` and formatter `h5p_default`, so you attach interactive content by adding an H5P field to any entity bundle. Each field value references an `h5p_content` content entity (base table `h5p_content`) holding the library id, raw and filtered parameters, and disabled-feature flags. Content-type "libraries" (MultiChoice, Interactive Video, Course Presentation, …) are managed at `/admin/content/h5p` and either uploaded as `.h5p` packages or fetched from the H5P Hub (with the companion **H5P Editor** submodule providing the in-browser authoring widget `h5p_editor`). A global settings form (`/admin/config/system/h5p`, config object `h5p.settings`) controls display options (download / embed / copyright / about buttons via `h5p_frame`, `h5p_export`, `h5p_embed`, `h5p_copyright`, `h5p_icon`), the storage path (`h5p_default_path`), per-revision saving (`h5p_revisioning`), content-state autosave, file whitelists, LRS/xAPI options, Hub usage and development mode. A rich permission set gates library administration, results access, and per-user copy/download/embed rights, and hooks let other modules alter H5P semantics, parameters, styles and scripts. AJAX routes handle xAPI "finished" results, content user-data, embedding (`/h5p/{id}/embed`) and (with H5P Editor) library install/upload.

---

- Add an interactive quiz (H5P MultiChoice) to an Article via an H5P field.
- Embed an Interactive Video with clickable questions on a lesson page.
- Author a Course Presentation directly in the browser with the H5P Editor widget.
- Upload a `.h5p` package exported from another site and display it.
- Fetch new content types from the H5P Hub and manage installed libraries at /admin/content/h5p.
- Track learner results via xAPI/LRS and store completion (set-finished) data.
- Give trusted users the `administer h5p libraries` permission to upload/update/delete libraries.
- Let authors see their own H5P results while admins see all results (results permissions).
- Toggle the Download (export) button on/off globally with the h5p_export display option.
- Hide or show the Embed button and copyright/about buttons per site policy.
- Restrict certain content types and allow only some roles to create restricted types.
- Change where H5P stores its files by setting the h5p_default_path.
- Keep a separate copy of content files per node revision (h5p_revisioning) or disable to save disk.
- Enable autosave of content state so learners resume where they left off.
- Embed an H5P interactive on an external site via the /h5p/{id}/embed route.
- Enable development mode to iterate on custom H5P libraries without caching.
- Alter a library's semantics (e.g. allow extra HTML tags) via hook_h5p_semantics_alter().
- Inject custom CSS/JS into rendered H5Ps with hook_h5p_styles_alter()/hook_h5p_scripts_alter().
- Disable retry/solution buttons contextually with hook_h5p_filtered_params_alter().
- Build a Views listing of H5P user points using the H5P results views access plugin.
- Reuse the same H5P content across multiple entities by referencing its h5p_content entity.
- Whitelist additional file extensions allowed inside H5P packages.
- Contribute (or opt out of) anonymous usage statistics to the H5P project.
- Present interactive learning modules as part of a Drupal-based LMS.

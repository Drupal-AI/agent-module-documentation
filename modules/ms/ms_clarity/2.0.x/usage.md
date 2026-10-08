Microsoft Clarity injects the Microsoft Clarity analytics tag (heatmaps, session recordings, click/scroll tracking) into your site's pages, with page- and role-based visibility rules for which requests get tracked.

---

The module attaches the Clarity JavaScript snippet to the HTML head via `hook_page_attachments`, using a `script_head` Twig template that loads `https://www.clarity.ms/tag/<project-id>`. The Clarity **project ID** is entered on the admin settings form at `/admin/config/services/microsoft_clarity` (route `ms_clarity.admin_settings_form`, permission `administer microsoft clarity`) and stored in config `ms_clarity.settings:account`; it is validated to be strictly alphanumeric (`/^[a-zA-Z0-9]+$/`). Two visibility layers decide whether the tag is emitted on a given request, both modeled on Drupal core's classic Google Analytics module: a **page** filter (`visibility.request_path_mode` + `request_path_pages`, "all pages except…" or "only these…", with `*` wildcards and `<front>`) and a **role** filter (`visibility.user_role_mode` + `user_role_roles`). The `ms_clarity.visibility` service (`VisiblityTracker`) evaluates path and role matches; the `ms_clarity.accounts` service (`MicrosoftClarityAccounts`) returns the project ID. If no project ID is set, or the visibility checks fail, nothing is injected. There are no plugin types and no Drush commands; the only external dependency is the Clarity SaaS endpoint itself.

---

- Add Microsoft Clarity heatmaps and session recordings to a Drupal site.
- Enter and validate a Clarity project ID from an admin form.
- Load the Clarity tag from `clarity.ms` on every page by default.
- Exclude specific paths (e.g. `/admin/*`, `/user/*`) from tracking.
- Track only a specific set of paths (e.g. `/blog`, `/blog/*`).
- Use `<front>` and `*` wildcards in the page-visibility list.
- Track only certain user roles (e.g. anonymous visitors only).
- Exclude certain roles (e.g. never track editors/administrators) from tracking.
- Turn tracking off site-wide by clearing the project ID.
- Keep analytics config in exportable Drupal configuration (`ms_clarity.settings`).
- Combine page and role filters so, for example, anonymous users are tracked everywhere except admin paths.
- Case-insensitively match request paths (paths are lowercased before comparison).
- Match against both the path alias and the internal system path.
- Gate the whole snippet behind a single `administer microsoft clarity` permission.
- Register a site with Clarity and drop in the ID without editing theme templates.
- Understand where users click and how far they scroll on key landing pages.
- Record sessions to diagnose UX problems and conversion drop-off.
- Roll Clarity out to production while excluding staging-only roles.
- Ensure the tag is emitted in the document head (not the footer) for earliest capture.
- Avoid double-tracking authenticated staff by excluding their roles.

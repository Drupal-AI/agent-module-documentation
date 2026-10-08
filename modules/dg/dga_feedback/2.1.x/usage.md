DGA Feedback provides an accessible "Was this page useful?" Yes/No widget block with reason selection, an optional free-text comment, optional demographics, live statistics, and a full admin submissions dashboard, with all front-end strings translatable (English & Arabic) from the admin UI.

---

The module ships a single block plugin (`dga_feedback_block`, "DGA Feedback Widget") that renders a bilingual feedback widget and reads/writes a custom `dga_feedback` database table (no entity API). Anonymous and authenticated visitors submit a Yes/No answer, one or more reasons drawn from configurable reason lists, a required free-text comment, and an optional gender field; the widget posts JSON to `/dga-feedback/submit` and immediately shows updated statistics. Every user-visible string — question, buttons, reason lists, validation messages, API/back-end messages, and even the admin menu titles — is stored as a pair of English/Arabic config keys in `dga_feedback.settings` and edited through a dedicated Translations form, so no `.po` files or interface-translation workflow is needed. Submissions are aggregated per-URL and per-entity into "yes percentage" and total-count statistics that drive both the live widget display and an admin dashboard (`/admin/content/dga-feedback`) offering filtering, sorting, pagination, per-row edit/delete, and CSRF-protected bulk delete. Three permissions separate dashboard viewing, submission moderation, and settings/translation administration. A configurable retention period purges old rows on cron, and configurable per-IP/per-user rate limiting and length caps guard the submit endpoint. The module targets the Saudi Digital Government Authority (DGA) Design System and emphasizes accessibility and RTL Arabic support.

---

- Add a "Was this page useful?" Yes/No feedback widget to any theme region via Structure > Block layout.
- Collect page-level usefulness ratings from anonymous visitors without requiring login.
- Gather structured reasons behind a Yes or No answer using separate, admin-editable reason checklists.
- Capture free-text visitor comments alongside the Yes/No rating.
- Optionally collect a demographic gender field (Male / Female / Prefer not to say) with each submission.
- Show live "X% of users said Yes from N feedbacks" statistics that update immediately after submission.
- Run a fully bilingual (English + Arabic) feedback experience with correct RTL text, switching by URL prefix, `?lang=` query, or Accept-Language.
- Edit all widget, validation, and API strings from the admin UI (DGA Feedback > Translations) with no code or `.po` files.
- Rename the module's own admin menu items (DGA Feedback, Dashboard, Settings, Translations) in both languages.
- Review all feedback submissions in an admin dashboard with overall stats, usefulness distribution, and per-URL breakdowns.
- Filter submissions by URL, feedback text, useful=yes/no, entity, user ID, IP address, and date range.
- Sort and paginate large submission sets (50 per page) in the dashboard.
- Identify the most-useful page and the most-feedback page from dashboard summary tiles.
- Track recent activity (last 7 days / last 30 days counts and useful percentages).
- Compare submission volume from anonymous vs authenticated users.
- Edit an individual submission's rating, reasons, comment, and gender.
- Delete a single submission behind a confirmation form, or bulk-delete selected rows.
- Throttle spam with configurable per-IP (anonymous) or per-user (authenticated) rate limiting over a configurable time window.
- Enforce maximum feedback length, per-reason length, and maximum reason count.
- Auto-purge submissions older than a configurable number of days on cron for privacy/retention compliance.
- Configure how quickly the widget resets after a successful submission (refresh delay).
- Delegate feedback viewing, moderation, and configuration to different roles via three distinct permissions.
- Expose per-URL or per-entity statistics to other code through the `dga_feedback.service` service (`getStatistics`, `getStatisticsByUrl`, `getOverallStatistics`).
- Query live statistics from JavaScript via the `/dga-feedback/stats` and `/dga-feedback/refresh-block` JSON endpoints.

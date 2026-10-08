A configurable "Did this help?" Yes/No feedback block that records per-page responses (with reasons and a free-text message for "No") and reports them through a Views page.

---

Did this help? places a block containing a configurable question and Yes/No buttons on any page via the block layout. Clicking "Yes" records an affirmative response over AJAX and thanks the visitor. Clicking "No" opens a panel with a configurable list of ready-made reasons plus an "Other" option and a short (250-character) "Tell us more" text area; submitting it records the choice and message. Each response row stores the current page URL, the resolved page title, the answering user's ID, the Yes/No choice, the selected "No" answer, the message, the visitor IP, and a timestamp in the module's own `did_this_help` table. Administrators set the question text and the newline-separated list of "No" answers at `/admin/config/did_this_help/settings`, and review all responses on a Views-powered report at `/admin/reports/did-this-help` (exposed filters for user, page title, page URL, and Yes/No). The module provides two permissions ("administer did this help", "view did this help reports"), a block plugin, an AJAX form, and full Views integration including a custom Yes/No filter plugin.

---

- Add a "Was this page helpful?" widget to documentation or help pages.
- Collect Yes/No usefulness feedback on knowledge-base articles.
- Gather structured reasons ("Too much information", "Not enough information", etc.) when content is marked unhelpful.
- Let visitors leave a short free-text explanation via the "Other"/"Tell us more" field.
- Place the feedback block only on specific pages using core block layout visibility conditions.
- Change the prompt wording (e.g. "Was this useful?") from the settings form without code.
- Curate the list of preset "No" reasons per site from the settings textarea (one answer per line).
- Track which pages generate the most negative feedback via the report's page-URL filter.
- Identify low-quality content by sorting the report by newest responses.
- Attribute feedback to logged-in users through the report's User filter and relationship.
- Filter the report to only "No" (or only "Yes") responses with the built-in Yes/No filter.
- Build custom Views (blocks, exports, dashboards) on the `did_this_help` base table for reporting.
- Expose a CSV/data export of collected feedback by cloning the report View with a data-export display.
- Surface a per-editor "unhelpful pages" dashboard by combining the User and choice filters.
- Restrict who can change the question/answers via the "administer did this help" permission.
- Restrict who can read collected feedback via the "view did this help reports" permission.
- Provide anonymous-visitor feedback capture (responses store uid 0 for anonymous users).
- Monitor feedback trends over time using the report's created-date sort.
- Prompt for feedback at the bottom of long-form content by positioning the block in a footer region.
- Localize the question and answer strings through Drupal's configuration translation.
- Style the widget (button placement, the sliding "No" panel) via the shipped CSS library.

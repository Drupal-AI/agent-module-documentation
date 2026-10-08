# Configuration

There is no central settings form for Sector Content Audit. You configure it by
switching the audit fields on for each content type that should be tracked, and
then working from the audit View. You will need permission to administer content
types (an administrator by default).

## Enable the audit fields on a content type

1. Edit the content type you want to track — **Structure → Content types →
   (your type) → Edit**, i.e. `/admin/structure/types/manage/<type>`.
2. Find the **Sector Audit settings** section on the edit form.
3. Check **Add audit fields to the &lt;type&gt; content type**.
4. **Save** the content type.

When you save, the module automatically creates the five audit fields on that
content type, each with a sensible widget already chosen:

- **Content audit status** (`field_content_audit`) — options buttons (radio
  style), for the status you assign during an audit (for example due / replace /
  complete).
- **Content development status** (`field_content_development`) — a select list,
  for the status you assign while creating content (for example queued / in
  progress / review).
- **Audit date** (`field_audit_date`) — a datetime field, to record or schedule a
  review date.
- **Review notes** (`field_review_notes`) — a text area for reviewer notes.
- **Document notes** (`field_document_notes`) — a text area for document notes.
  When the Sector `restricted_basic_html` text format exists (from the Sector
  Starter Kit), this field is bound to it via Better Formats so its formatting is
  restricted.

The module also records that the type is enabled in its own configuration, so the
setting sticks. You can enable audit tracking on as many content types as you
like, selectively.

## Where the fields appear for editors

Once a content type is enabled, its node **add / edit / translate** forms show the
audit fields grouped together in an **Audit and review** details section in the
advanced sidebar (alongside things like authoring information). Editors set the
audit and development status, the review date, and the notes right there while
working on the content.

## Use the audit dashboard

The shipped **Sector Content Audit** View is your review dashboard:

- Use its **exposed filters** (such as status and audit date) to find content that
  needs attention — for example everything due for re-audit, or content flagged to
  be replaced.
- Use the **Views Bulk Operations** actions to act on many items at once. Adjust
  which VBO actions are enabled so they match your own publishing/review workflow.

Reporting tip: filtering the View on the **audit date** is an easy way to surface
stale content and schedule periodic re-audits.

## Sector integration note

Some conveniences assume the wider **Sector** distribution — for instance the
`restricted_basic_html` format for document notes, and rabbit-hole redirects that
send audit taxonomy terms to a pre-filtered audit view. On a plain Drupal site
without the Sector Starter Kit the core auditing still works; those extras simply
will not be present.

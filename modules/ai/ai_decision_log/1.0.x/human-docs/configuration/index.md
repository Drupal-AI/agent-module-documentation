# Configuration

AI Decision Log works as soon as it is enabled — decisions can be recorded and
browsed straight away. What you mostly "configure" here is **who can do what**
through its permissions, and where to find the pages.

## The pages

All of the module's pages live under **Reports** and are permission-gated:

- **Settings / overview** — `/admin/reports/ai-decisions`, requires **Administer AI
  decision log** (a restricted permission). This is the module's settings form.
- **Decisions report** — `/admin/reports/ai-decisions/report`, requires **View AI
  decision log reports**. A report of recorded decisions for auditors.
- **Decisions list** — the entity list builder for browsing every recorded
  `ai_decision`, also under **View AI decision log reports**.

There are no anonymous or unauthenticated endpoints — every route is behind one of
the permissions below.

## Permissions

Grant these at **People → Permissions** to match your governance workflow:

| Permission | What it allows | Grant to |
|------------|----------------|----------|
| **Administer AI decision log** *(restricted)* | The settings page and administration of the log. | Administrators only. |
| **View AI decision log reports** | The report page and the decisions list. | Auditors, managers, anyone who needs to read the history. |
| **Use AI decision log** | General use of the decision log. | Roles that create or interact with decisions. |
| **Run AI decision log audits** | Run audit operations over the log. | The people responsible for audits. |
| **Approve AI decision log generated changes** *(restricted)* | Approve changes in a review-first workflow. | Trusted approvers only. |

The two restricted permissions (**Administer** and **Approve generated changes**)
carry the most authority — keep them with a small, trusted set of roles.

## Recording decisions from code

Most entries are created programmatically. Another module — or your own code — can
create and persist an `ai_decision` entity through the writer service:

```php
$writer = \Drupal::service('ai_decision_log.writer');
// create and persist an ai_decision entity
```

Each decision captures a title, summary, context, the decision, alternatives,
related items, source, and author; related entities, config, and modules are stored
as structured text.

## Automatic secret redaction

You don't configure this, but it's important to know: before a decision is stored,
the writer runs a redaction pass (`SECRET_PATTERN`) that strips out API-key,
access-key, secret, token, password, bearer, client-secret, and private-key values
from the decision text. This is a deliberate safeguard so that decision bodies
passed in from other modules cannot accidentally persist credentials in the log.

## Integration with AI Policy Gateway

If you use **AI Policy Gateway**, it mirrors every policy decision into this log
automatically, giving you a single audit store for policy decisions. No extra
configuration is needed here beyond having the module enabled and the viewing
permissions granted to your auditors.

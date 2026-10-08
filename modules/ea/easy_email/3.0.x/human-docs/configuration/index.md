# Configuration

Easy Email is configured in two places: the **email templates** you create, and a
small set of **global settings**. Both are under **Structure → Email templates**.

> **Reminder:** an HTML mailer (Symfony Mailer or Symfony Mailer Lite) must be
> enabled for delivery to work — see [Installation](../installation/index.md).

## Email templates

Templates are managed at **Structure → Email templates**
(`/admin/structure/email-templates/templates`). Each template is the reusable
definition of one kind of email. To create one, click **Add email template** and
fill in the form.

### The template fields

- **Label** and **machine name** — a human name and internal id for the template.
- **Key** — a unique key used to prevent duplicate sends of the same email (the
  module can check whether an email with this key already exists).
- **Recipients / CC / BCC** — the To, CC, and BCC addresses. Each can be a raw
  email address or a token that resolves to one (for example a token pointing at a
  referenced user's email).
- **From name**, **From address**, **Reply-to address** — the sender identity.
- **Subject** — the subject line; tokens allowed.
- **Inbox preview** — an optional snippet that shows in the recipient's inbox
  preview line but stays hidden in the body.
- **HTML body** — the main message, edited with a rich-text format. Tokens
  allowed.
- **Plain-text body** — the fallback text body. You can write it yourself or tick
  **Generate plain text from HTML** to derive it automatically.
- **Attachments** — files to attach, given by token or relative path. You can
  choose the storage scheme and directory for saved copies, and whether to save
  the attachment.
- **Logging** — whether sent emails of this template are saved to the log, plus
  per-template purge options (whether to purge, and after what interval).

### Tokens and fields

Every field on a template supports **token replacement** (that's why the module
depends on Token). Because templates are **fieldable**, you can add your own
fields to a template through the Field UI — for example an entity reference to an
order or a user — and then use tokens derived from those fields anywhere in the
template. This is how you make one template produce fully dynamic, per-recipient
emails.

### Preview

Each template has a **Preview** action. Fill in sample values for any tokens and
Easy Email renders both the HTML and plain-text versions so you can check the
result before sending.

## Global settings

At **Structure → Email templates → Settings**
(`/admin/structure/email-templates/settings`) — config object
`easy_email.settings`. These govern log purging and attachment security across
all templates:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Purge on cron** | On | Automatically remove old logged emails during cron runs. |
| **Purge cron limit** | 50 | Maximum number of logged emails purged per cron run. |
| **Allowed attachment paths** | `public://*` | Path patterns attachments may be read from. |
| **Email log access control** | On | Whether access to the email log collection is gated. |
| **Allowed attachment extensions** | *(empty — all except blocked)* | Whitelist of file extensions for attachments. |
| **Blocked attachment extensions** | `exe`, `bat`, `php`, `js`, `sh`, … | File extensions never allowed as attachments. |
| **Allowed attachment MIME types** | *(empty)* | MIME-type whitelist. |
| **Blocked attachment MIME types** | `application/x-php`, `text/javascript`, … | MIME types never allowed. |
| **Max attachment size** | 10.0 MB | Largest attachment permitted. |

There is also a **theme settings** page for the theme used to render email
output.

## The email log

Every sent email (when logging is on) is saved and browsable at **Reports → Email
log** (`/admin/reports/email`). Logged emails are automatically linked to the
recipient's user account, so you can audit what a given user received. Emails are
revisionable, so you can view, revert, or delete revisions, and old entries are
pruned by the cron purger (or on demand with the module's Drush command).

## Permissions

Grant these under **People → Permissions**. They split into template permissions
and email-entity/log permissions.

**Templates and settings:**

| Permission | Grants |
|------------|--------|
| **Access Easy Email settings** (`access easy email settings`) | The global settings and theme settings forms. |
| **Administer email types** (`administer email types`) | Full template administration, including the Field UI on templates. |
| **Access the email types overview** | View the templates list. |
| **Create / Edit / Delete / Preview email types** | The matching actions on templates. |

**Email entities and the log:**

| Permission | Grants |
|------------|--------|
| **Administer email entities** | Full administration of email entities. |
| **Add / Edit / Delete email entities** | The matching actions. |
| **View own email entities** | See emails you created. |
| **View all email entities** | See the whole email log. |
| **View / Revert / Delete all email revisions** | The revision actions (revert and delete also need the corresponding view/edit/delete rights). |

Note: the **Easy Email Override** submodule's override entity uses core's
*Administer site configuration* permission and defines none of its own.

## Doing it from the command line

Templates and settings are all configuration, so they export and deploy like any
other config (`drush config:export`). You can set a global value directly, e.g.:

```bash
drush cset easy_email.settings purge_cron_limit 100
```

The module also registers a Drush command (backed by the purger service) to purge
old logged emails on demand.

# Configuration

All of Site Verification's work happens on one page: the verifications listing at
**Configuration → Search and metadata → Verifications**
(`/admin/config/search/verifications`). There is no global settings form — you create
one record per search engine or service you want to verify with, and each record is
either a meta tag or a file.

## Open the verifications listing

1. Log in as a user with the **Administer site verify** permission.
2. Go to **Configuration → Search and metadata → Verifications**, or navigate directly
   to `/admin/config/search/verifications`.

The listing shows every configured verification with its label, type (meta or file),
and enabled status, plus **Enable/Disable**, **Edit**, and **Delete** operations on
each row.

## Meta tag vs. file — which one to pick

Search engines let you verify either way; use whichever the service offers you:

- **Meta tag** — the module renders a `<meta name="…" content="…">` tag in the page
  `<head>`, but **only on the front page**. This is the most common method (Google,
  Bing, and Yandex all offer it). Nothing is written to disk.
- **File** — the module serves a plain-text response at a path that matches the
  filename the service gave you (for example `name: BingSiteAuth.xml` is served at
  `/BingSiteAuth.xml`). No real file is created on the server; the module answers that
  path dynamically. Two enabled file verifications may not share the same filename.

Only records whose status is **enabled** are actually attached (meta) or served
(file). A new file verification becomes reachable immediately — the module rebuilds
its routes automatically when you save, so you do not need to clear caches by hand.

## Add a verification

1. On the listing, click **Add site verification**.
2. Enter a **Label** — a human-friendly name so other editors know which service this
   record belongs to (for example "Google Search Console"). A machine name is
   generated automatically from the label and can be edited before you save.
3. Optionally add a **Description** — a short single-line admin note. (This is for
   your own reference; it does not appear on the front end.)
4. Choose how you want to supply the verification value:
   - **Manual entry** — pick the **Verification type** (Meta tag or File), then fill
     in the **Name** and **Content** fields yourself. For a meta tag these are the
     tag's `name` and `content` attributes; for a file they are the filename and the
     file's text contents.
   - **Paste a meta tag** — paste the entire `<meta name="…" content="…">` tag copied
     from the webmaster console, and the module splits it into the Name and Content
     fields for you.
   - **Upload a file** — upload the verification file the search engine gave you (for
     example `google1234567890abcdef.html`); the module reads its name and contents
     into the record and discards the temporary upload. (Requires core's File
     module.)
5. Leave the **enabled** checkbox ticked so the verification takes effect immediately
   (new verifications are enabled by default). Save.

## Enable, disable, and delete

Each row on the listing has operations:

- **Disable** turns a verification off without losing its configuration — the meta tag
  stops rendering, or the file route stops responding — and **Enable** turns it back
  on. This is handy for temporarily pausing a verification. Both are confirmed in a
  small modal.
- **Edit** reopens the add form to change the label, description, name, or content.
- **Delete** removes the record entirely.

## Using several verifications at once

You can run any number of verifications together — for example a Google meta tag plus
a Bing file — with no conflicts, as long as no two enabled file verifications claim
the same filename. The module enforces that uniqueness for you and will refuse to save
a duplicate.

## Deploying verifications with config management

Each verification is stored as configuration
(`site_verify.site_verification.<id>.yml`), so you can export it from one environment
and import it on another with Drupal's configuration sync, rather than recreating it
by hand. Read a saved record back with
`drush config:get site_verify.site_verification.<id>`.

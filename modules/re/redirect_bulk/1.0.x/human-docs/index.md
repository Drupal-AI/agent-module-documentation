# Redirect Bulk — manual setup guide

**Redirect Bulk** (`redirect_bulk`) adds two admin screens to the **Redirect**
module for creating many URL redirects at once, instead of adding them one at a
time. One screen is a repeatable multi-row form for typing in old → new URL pairs;
the other is a CSV importer for pasting or uploading a whole spreadsheet of them.

It's built for the moments when you have a lot of redirects to create quickly — a
site migration, a URL-scheme restructure, launching a fresh site from a prepared
list of legacy URLs, or a marketing campaign that needs a batch of temporary
redirects. Both screens create standard Redirect entities, so everything you make
here shows up and behaves exactly like redirects added through the core Redirect
UI. The module adds no storage of its own.

Both screens validate every entry before saving — rejecting duplicates,
self-redirects, malformed sources, and paths that already have a redirect (linking
you to the existing one). Access is gated by the module's **Administer bulk
redirects** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Redirect module) and enable it.

## Where it lives in the admin menu

Both screens sit alongside the core redirect list at
**Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`):

- **Add Bulk redirects** (`/admin/config/search/redirect/add-bulk`) — the manual
  multi-row form. This is the module's main configure link.
- **Import CSV** (`/admin/config/search/redirect/add-csv`) — the CSV importer.

Action links to both are added to the core redirect list. Both require the
**Administer bulk redirects** permission.

## How to use it

### The manual bulk form

1. Go to **Add Bulk redirects** (`/admin/config/search/redirect/add-bulk`).
2. Each row has:
   - **Path** — the source (old) path. Don't start it with `/` or `?`, don't
     include a `#` anchor, and don't use `<front>` as a source.
   - **To** — the destination. Type a node title to use the autocomplete, or enter
     an internal path or an external URL.
   - **Redirect status** — the HTTP status code (301 permanent by default, 302
     temporary, etc.).
   - **Language** — shown on multilingual sites, to set the redirect's language.
3. Click **Add redirect** to add more rows, or **Remove** to drop one (the form
   updates via AJAX without reloading).
4. Submit. The module saves one redirect per row and returns you to the redirect
   list.

Validation catches empty rows, duplicate sources within the form, self-redirects
(source equals destination), and sources that already have a redirect (the error
links straight to the existing redirect's edit form).

### The CSV importer

1. Go to **Import CSV** (`/admin/config/search/redirect/add-csv`).
2. Prepare a CSV with columns **`from, to, code, langcode`** — `code` and
   `langcode` are optional. For example:

   ```csv
   /old-page,/new-page,301,en
   /promo,https://example.com/landing,302
   /about-us,/about
   ```

   - `code` must be a redirect status between 300 and 307; if omitted it falls
     back to your site's default redirect status code (or 301).
   - `langcode` must be a real language on your site; if omitted the redirect is
     language-neutral.
3. Upload the file and submit. The importer validates each row (skipping ones that
   are already redirected, empty, or self-redirecting) and reports how many were
   imported and how many could not be processed.

### Good to know

- **Destinations can be external URLs.** That's an intentional feature of the
  Redirect module (an "open redirect"), and it's why access is limited to the
  **Administer bulk redirects** permission — grant that permission only to trusted
  roles.
- The destination autocomplete only returns published nodes the user is allowed to
  view.
- Uploaded CSV files are kept as permanent managed files, so they remain in your
  files table after import.

# Configuration

SEO Checklist has **no settings form of its own** — there's nothing to tune. What looks
like its "configuration" page is the checklist itself, provided by Checklist API. This
page explains where it lives and how the checklist behaves.

## Open the checklist

1. Log in as a user with Checklist API's **view / edit the SEO checklist** permission
   (an administrator by default).
2. Go to **Configuration → Search and metadata → SEO Checklist**, or navigate directly
   to `/admin/config/search/seo-checklist`.

## Working through it

- The checklist is laid out as **vertical tabs**, one per section (Clean URLs, Meta tags
  and Schema.org, Search engines, Optimizing content, On‑page optimization, Security and
  performance, Mobile, and more), with a **progress bar** at the top.
- Tick each task as you complete it, then click **Save**. **Progress is not stored until
  you save** — so save before you leave the page.
- Items whose recommended module is **already installed are pre‑checked automatically**,
  so the list reflects work you've already done.
- Each module item shows action links:
  - **Download** — jump to the module's project page on drupal.org.
  - **Install** — jump to the modules install page, anchored to that module.
  - **Configure** — jump to the module's settings form (shown when the target exists and
    you have access).
  - **Configure permissions** — jump to the module's permissions page (shown when the
    module is installed and has permissions).
- Some items include an external **SEO training camp** link with extra guidance on that
  task.

## What gets stored, and permissions

- **Progress** is saved by Checklist API in a configuration object
  (`checklistapi.progress.seo_checklist`), recording **who** checked each item and
  **when** — a useful audit trail when you hand a site off.
- **Access** is controlled entirely by Checklist API's auto‑generated per‑checklist
  permissions (view / edit the SEO checklist). SEO Checklist defines none of its own.

## Uninstalling

Uninstalling the module **deletes the stored progress** (`checklistapi.progress.seo_checklist`).
If you might reinstall later and want to keep the record of completed steps, export your
configuration first.

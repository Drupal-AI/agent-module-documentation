# Configuration

The one thing eTracker needs to start working is your **account ID**; everything
else on the form is about *what* and *where* to track.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (or the
   module's own administration permission).
2. Go to **Configuration → System → eTracker**, or navigate directly to
   `/admin/config/system/etracker`.

## The essential setting

- **eTracker account ID** — the ID from your eTracker account. Enter it and save;
  the tracking JavaScript is then added to your pages. This value is an account
  identifier, not a secret credential, so it is fine to keep it in configuration.

## What and where to track

The form exposes eTracker's many tracking options. The most useful include:

- **Scope of the tracking code** — place it in the page **header** or **footer**.
- **Click tracking** — track clicks on **mailto** links, **external** links, and
  **download** links (by a configurable list of file extensions).
- **Site search tracking** — record internal search usage.
- **System‑message tracking** — optionally track Drupal status/error messages to
  spot usability issues.
- **Page and role scoping** — track only specific pages, or only users in specific
  roles.
- **Areas, targets and segments** — enrich data with taxonomy or breadcrumb‑derived
  areas, rule‑set targets, and role/language segments (note: segments must be
  pre‑defined in your eTracker account to be recorded).
- **Multilingual options** — append the current language code to the page name or
  areas.

## Privacy and consent

Analytics tracking sets cookies and loads a third‑party script, so treat consent as
part of the setup, not an afterthought:

- Enable the **`cookies_etracker`** submodule to gate the tracker behind the
  **COOKiES** consent module, so it only loads once the visitor agrees.
- The module respects the browser **Do‑Not‑Track** setting by default (this can be
  turned off) and can let registered users opt in or out of tracking.
- Disclose the tracking in your privacy policy per GDPR / applicable privacy law.

## Save

Click **Save configuration**. Reload a front‑end page and view its source to
confirm the tracking code is present (and, if you use consent gating, that it loads
only after consent).

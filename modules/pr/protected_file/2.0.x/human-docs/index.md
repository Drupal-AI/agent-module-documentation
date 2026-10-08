# Protected File — manual setup guide

**Protected File** (`protected_file`) lets you password-protect *individual* file
downloads without hiding the files themselves. It adds a **Protected File** field
type — an extended version of core's File field — with a per-file **Protected**
checkbox. Everyone still sees the file link, but only users who hold the **Download
protected file** permission can actually download a file marked protected. It's the
right tool for a document library where the PDFs are visible to all but downloadable
only by members, gated whitepapers, members-only handouts, or software builds
restricted to entitled users.

The protection is real, not just a hidden link. Enforcement happens **server-side**:
even a visitor who discovers the direct file URL is denied, because the check runs in
Drupal's file-download hook. For that to work, the field is **locked to the private
filesystem** (`private://`) — only private files route through the download hook — so
your site must have a private files path configured. The default formatter shows a
lock icon on protected files and can redirect unauthorized users to a login page (and
optionally back to the file after they log in).

There is **no global settings page**. You configure protection per field, on the same
**Manage form display** and **Manage display** screens you'd use for any field, plus
one permission to grant. Developers get an extra hook: a `ProtectedFileAccessEvent`
is dispatched on every protected download, so custom rules (ownership, purchase,
group membership) can allow or deny per file. A `protected_file` media source is also
provided so protected files can back media entities. It depends on core **Field** and
**File**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and make sure a private filesystem is configured.
2. [Configuration](configuration/index.md) — add a Protected File field, set the
   widget and formatter, and grant the download permission.

## Where it lives in the admin menu

There is no dedicated settings form. You add and configure Protected File fields
under **Structure → (content type) → Manage fields / Manage form display / Manage
display**, and grant the download permission at **People → Permissions**.

## How to use it

Add a Protected File field to a content type, place its widget and formatter, grant
**Download protected file** to the roles that should be able to download, then when
editing content tick **Protected** on any file you want to gate. See
[Configuration](configuration/index.md) for the full walkthrough.

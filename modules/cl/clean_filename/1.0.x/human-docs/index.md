# Clean Filename — manual setup guide

**Clean Filename** (`clean_filename`) makes sure your *newest* file upload always
keeps the clean, unsuffixed name. It does this by reversing Drupal's default
behaviour when a file collides with an existing one of the same name.

Note that despite the name, this module does **not** rewrite the characters in a
filename — it does not strip spaces, remove diacritics, or transliterate. That
sanitising is still handled by Drupal core. What this module changes is *which*
file ends up with the clean name after a collision.

By default, when you upload `document.pdf` and one already exists, Drupal renames
the *new* file to `document_0.pdf` and leaves the old one holding the clean name.
Clean Filename flips that around: it lets the **new** upload keep the clean
`document.pdf` name and renames the **existing** file to the next available suffix
(`document_1.pdf`). The result is that your latest file always gets the clean URL —
better for SEO and for anyone sharing the link — while existing references to the
older file are preserved because it simply moves to a new suffixed name. The module
manages the suffix numbering intelligently to keep this consistent even in more
tangled naming situations.

The behaviour is applied **per field**, so you enable it only on the file or image
fields where you want it, rather than site-wide. Administration is gated by the
`administer clean filename` permission. It depends on core's **File**, **Field**,
and **System** modules (all standard), and supports Drupal 10 and 11. This is a
release candidate (`1.0.0-rc1`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is a settings page at **Configuration → Media → Clean Filename**, but it is
mostly informational: it holds a couple of global options (logging and a maximum
rename-attempts number) and read-only lists of which fields and text formats
currently have the feature switched on. The actual on/off switches live on each
field and each text format, described under "How to use it" below.

## How to use it

Because the module works per field, you switch it on where you need it:

1. Go to the field settings for a file, image, or media field — **Structure →
   Content types → *(your type)* → Manage fields**, then edit the relevant field
   (or the equivalent for any other fieldable entity).
2. Enable Clean Filename's option for that field and save.
3. Grant the `administer clean filename` permission to the roles that should manage
   this behaviour (**People → Permissions**).

To apply the same behaviour to images uploaded through CKEditor 5, go to
**Configuration → Content authoring → Text formats and editors**, edit a text
format, enable the **"Clean Filename for CKEditor"** filter, and tick its checkbox.
CKEditor uploads are controlled independently of the field settings.

From then on, uploads in those places get the clean-name treatment: new files keep
the original clean name and any conflicting existing file is moved to the next
suffix.

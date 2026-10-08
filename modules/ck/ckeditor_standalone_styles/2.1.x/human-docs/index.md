# CKEditor Standalone Styles — manual setup guide

**CKEditor Standalone Styles** (`ckeditor_standalone_styles`) lets you manage the
entries in CKEditor's **"Styles"** dropdown from a **dedicated admin page**,
separately from the rest of the text-format and editor configuration. Each style
becomes its own configuration entity that site builders can add, edit, and delete,
and because they are config entities, themes can ship their own default styles
too.

Drupal core can already manage these styles — but only from *inside* the CKEditor
configuration form, which is a powerful and security-sensitive place: it also
governs allowed HTML and filters (an XSS-relevant setting). This module's real
benefit is **least privilege**. By moving styles management to its own page with
its own permission, you can let a role curate the Styles dropdown without giving
them access to the full editor and text-format configuration. As a bonus, the
module does something core does not: it **automatically adds the CSS classes your
styles use to the format's allowed-HTML filter**, so the styles actually stick.

The module depends only on core's CKEditor 5 module and provides its own
permissions. You still need to make sure the **Styles** button is present on the
toolbar of whichever formats should use it — but the *list* of styles is then
managed entirely from the standalone page. Note that any styles you define in the
main editor configuration form are **ignored** once this module is in use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Styles button, manage your
   styles on the standalone page, and grant the permission.

## Where it lives in the admin menu

Styles are managed at **Administration → Configuration → Content authoring →
CKEditor styles** (`/admin/config/content/ckeditor_style`) — a list where you add,
edit, delete and drag-reorder individual styles. The Styles *button* itself is
still added per text format at **Configuration → Content authoring → Text formats
and editors**.

# CKEditor 5 DeepL — manual setup guide

**CKEditor 5 DeepL** (`ckeditor5_deepl`) integrates the **DeepL** machine-translation
service into Drupal's CKEditor 5 editor. It adds a toolbar button so editors can
select some text in the WYSIWYG, click **DeepL**, and translate it in place — with
translation options presented in a dialog. Depending on whether your DeepL API key
is a Free or Pro key, the dialog offers different options.

The module also provides a **DeepL translation block** you can place in any region
of your admin theme, giving you a translator on every admin page, and it can
display **usage statistics** for each key as reported by the DeepL API — handy for
keeping an eye on your quota.

It depends on core's CKEditor 5 module, the **Key** module (for storing your DeepL
API key securely as a Key entity), and the `deeplcom/deepl-php` PHP library, which
Composer installs for you. It runs on Drupal 10 and 11.

**A caveat worth stating plainly:** DeepL is an external, paid service. When an
editor translates text, the selected content is sent over the network to DeepL's
API, and translations count against your DeepL quota (and cost money on a Pro
plan). Treat this as an intentional data-egress and billing decision, and store
your API key as a secret — never hard-code it. Setup is covered in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   DeepL PHP library) and enable the module.
2. [Configuration](configuration/index.md) — create a DeepL API key, add the DeepL
   button to a text format, configure the button, and optionally place the
   translation block.

## Where it lives in the admin menu

There is no single settings page. Keys are managed at **Configuration → System →
Keys** (`/admin/config/system/keys`), the DeepL button is configured per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and the optional translation block is placed via
**Structure → Block layout**. All of this is walked through in
[Configuration](configuration/index.md).

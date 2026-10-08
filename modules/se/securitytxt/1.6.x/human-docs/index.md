# Security.txt — manual setup guide

**Security.txt** (`securitytxt`) publishes a standards‑compliant
`/.well-known/security.txt` file for your site — the small text file
([RFC 9116](https://www.rfc-editor.org/rfc/rfc9116)) that tells security researchers
how to report a vulnerability to you. You fill in a single settings form and the module
serves the assembled file at the well‑known path.

On the settings form you enter your contact details (a security email, phone, or a
contact page), an expiry date, and optionally links to your encryption key, disclosure
policy, acknowledgments (hall‑of‑fame) page, hiring page, the languages you accept
reports in, and canonical URLs. All of it is stored in one configuration object, and a
controller serves the plain‑text file at `/.well-known/security.txt`. If you enable
signing and paste a PGP signature on the **Sign** tab, a detached signature is served
at `/.well-known/security.txt.sig` too.

The file is only served while the module is **enabled** (and at least one contact
method is set), so you can toggle it on and off without losing your settings. Two
permissions gate it: viewing the file, which you should grant to everyone so scanners
can find it, and editing the details, which should stay with trusted admins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the exact field lines the
serializer emits and the routes — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field, the
   two permissions, signing, and the "enabled" requirement.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Security.txt**
(`/admin/config/system/securitytxt`), with a **Sign** subtab at
`…/securitytxt/sign`. Editing requires the **Administer securitytxt** permission; the
published file is served at `/.well-known/security.txt` to anyone with the **View
securitytxt** permission.

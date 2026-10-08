# Webform Encrypt — manual setup guide

**Webform Encrypt** (`webform_encrypt`) encrypts the values people submit into
individual Webform elements, so sensitive answers are stored *ciphered* in the
database rather than as readable text. A Social Security number, a payment
reference, a medical intake answer — anything you flag gets scrambled at rest and
only turned back into readable text for users you trust.

It works by bridging two other modules: **Webform** (which builds the forms) and
**Encrypt** (which manages encryption profiles and keys). You turn encryption on
one element at a time, from that element's own settings — there is no site-wide
"encrypt everything" switch and no central admin page. When a submission is saved,
the flagged element values are encrypted; when the submission is loaded, they are
decrypted again — but only for users who hold the **View Encrypted Values in
Webform Results** permission. Everyone else sees the placeholder `[Value Encrypted]`
instead, and cannot edit a submission that contains encrypted fields.

Because encryption is applied per element, you can protect only the fields that
need it (a national ID number, say) while leaving the rest of the form readable and
fast. If you ever uninstall the module, it safely decrypts all stored values back
to plain text first, so no data is lost.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Webform and
   Encrypt dependencies with Composer, then enable them.
2. [Configuration](configuration/index.md) — create an encryption profile, turn
   encryption on for an element, and grant the permission that reveals values.

## Where it lives in the admin menu

Webform Encrypt has **no admin settings page of its own**. You configure it inside
each webform, on the individual element's **Advanced** settings tab, where it adds
an **Encryption** section. The permission that governs who can read decrypted
values lives on the normal permissions page at **People → Permissions**
(`/admin/people/permissions`).

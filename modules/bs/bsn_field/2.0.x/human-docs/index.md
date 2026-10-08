# BSN — manual setup guide

**BSN** (`bsn_field`) adds a Drupal field type for storing a Dutch **BSN**
(Burgerservicenummer — the citizen service number), with built-in validation so
that only structurally valid numbers are accepted. Instead of collecting a BSN in
a plain text field, you use this typed field and Drupal rejects malformed or
implausible values at the moment someone submits the form.

Validation uses a modified "elfproef" (eleven-test) checksum: the digits are
weighted and summed, and the number must both pass the checksum and fall within
the plausible BSN magnitude range. The same check is applied whether the value
comes in through the field on an entity or through the module's **Webform**
element, so you can collect validated BSNs in Webforms as well. Stored values are
shown with Drupal's standard string formatter.

**A BSN is personal data.** This module validates the *format* of a number — it
does **not** encrypt or otherwise protect the stored value. On any real site you
are responsible for handling stored BSNs under your privacy/GDPR obligations:
restrict who can view the field, consider field-level access control, and
consider encryption where appropriate. The module adds no routes and no
permissions of its own.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core Field).

## Where it lives in the admin menu

There is no dedicated settings page. You add the field where you add any other
field — through **Field UI** on a content type or other entity — or you add the
BSN element to a Webform. Validation then applies automatically.

## How to use it

**On a content type or other entity:**

1. Go to the entity's **Manage fields** screen (Field UI).
2. Add a new field of type **BSN**. It uses its BSN default widget on the form,
   and displays with the core string formatter.
3. Save. Any value entered is now validated with the elfproef checksum, and an
   invalid entry raises "Provide a valid BSN number."

**In a Webform:**

1. Edit the Webform and add the **BSN** element to it.
2. Submissions to that element are validated the same way.

**Protecting the value:** because a BSN is sensitive personal data, pair the
field with field-level access control (so only the right roles can see it) and
consider encryption. The module does not do this for you.

Developers who need the same check elsewhere can reuse the module's
`_bsn_field_elfproef()` helper — see [agent/extend/field.md](../agent/extend/field.md).

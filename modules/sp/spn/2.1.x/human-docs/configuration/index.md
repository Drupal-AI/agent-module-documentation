# Configuration

Once Simple Petitions is enabled, there are two setup steps that make petitions
work end to end: setting the default notification emails, and placing the two
petition blocks. Creating individual petitions afterwards is just ordinary content
editing.

## Default emails and notifications

1. Log in as an administrator.
2. Go to `/admin/config/spn/notifications`.
3. Fill in the default **validation** and **confirmation** messages (and their
   subjects) that petitions should send to signers. **Tokens** are available so
   you can insert variables related to the petition.
4. Save.

These defaults are used by any petition whose own email fields are left empty. If
a specific petition fills in its own validation/confirmation emails, those are
used instead.

## Place the petition blocks

The signing form and results are delivered through two blocks:

- **Petition signing form** — where visitors sign.
- **Petition results** — shows the signatures and count.

To place them:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Add each block to the region you want.

You only need to place each block **once**. The blocks read the petition from the
page they are on, so they will show the correct petition on every petition node
automatically. Template suggestions are available if you want to restyle the block
markup.

## Creating and signing petitions

- **Create a petition:** go to `/node/add`, choose the **Petition** content type,
  fill in the fields (leaving the email fields empty to use your defaults above),
  and save.
- **Signing:** logged‑in or anonymous visitors fill in the required details and an
  optional comment. Ticking the *sign anonymously* option keeps their details and
  comment out of the results block while still counting their vote. Signers must
  click the validation link emailed to them for the vote to count; a confirmation
  email follows.

## Exporting signatures

Administrators can export a petition's signatures to CSV from
`/admin/spn/content/petitions`. Make sure the **private file system** is
configured first (see **Configuration → Media → File system**), since the export
is written there.

## A note on privacy and spam

Signatures are personal data — handle and expose them in line with your privacy
policy. The signing form is public, so add your own spam/bot protection (CAPTCHA,
Honeypot, or similar) to keep out fake signatures.

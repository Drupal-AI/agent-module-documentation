# Configuration

Setting this module up has two parts: tell it which field the autocomplete should
search, and add its button to a text format's CKEditor toolbar.

## Step 1 — Map the source field

1. Log in as a user with the **administer ckeditor_entity_link_by_field**
   permission. Grant this permission (at **People → Permissions**) only to trusted
   editors and administrators.
2. Go to **Configuration → Content authoring → CKEditor Entity Link by Field**
   (`/admin/config/content/ckeditor_entity_link_by_field`).
3. Map the **node** entity type to the **field** whose values the autocomplete
   should search — for example a publication‑date or reference‑code field. This
   becomes the field editors type against instead of the node title.
4. Save the form.

The autocomplete searches **article** nodes whose configured field *contains* the
text the editor types, returning up to the first 10 matches. Confirm the field you
choose actually exists on your node type.

## Step 2 — Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and configure a format that uses **CKEditor**
   (CKEditor 4).
2. Drag the **Add link by field** button into the active toolbar.
3. Save the format.

The dialog itself is properly protected — only users allowed to use that text
format can open it. Editors use it by clicking the button, typing part of the
configured field's value, and choosing a node to link.

## Important security note

The **autocomplete endpoint** behind the dialog is not as tightly protected as the
dialog. It is gated only by the core *access content* permission — which anonymous
users have by default — and its node query does **not** perform an access check or
filter out unpublished content. As a result, anyone with *access content* can use
the endpoint to enumerate the configured field's values and the node IDs of
**unpublished** articles (the results even flag unpublished nodes with a 🚫).

If your unpublished content is sensitive, do not expose this module as‑is on a
public site. Harden it before use — for example by tightening the autocomplete
route to a dedicated, restricted permission and adding an access check (and a
published‑status filter) to the underlying node query. This is a code‑level change;
raise it with your developers.

## What this module does not do

- It does not create a glossary or landing page; it only inserts links to existing
  nodes.
- In this release it supports **nodes** and a **single content type**. Broader
  entity/bundle support would require additional development.

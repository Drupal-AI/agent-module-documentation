# Configuration

The module works as soon as it is enabled — the vocabulary and its default terms
are created for you. Configuration is about **adding more licences** and
**controlling who can import them**.

## The default licences

On install, Licenses vocabulary imports the basic **Creative Commons 4.0**
licences and **CC0** as terms, with logos sourced from Creative Commons. You'll
find them under **Structure → Taxonomy** in the licences vocabulary, where you can
view, edit, or delete them like any other taxonomy terms.

## Importing more licences

Beyond the defaults, the module lets you **import additional licence definitions**
from a textarea in its settings. Paste the licence definitions in the expected
format and run the import to add them to the vocabulary in one go — quicker than
adding each term by hand. This import is gated by the **Import licenses**
permission (below), so only authorized users can bulk‑load the vocabulary.

## The Import licenses permission

Grant **Import licenses** under **People → Permissions**
(`/admin/people/permissions`) only to trusted administrators. It controls who can
run the import that populates the vocabulary. Everyday editing of individual terms
still follows Drupal's standard taxonomy permissions.

## Attaching licences to content

The module deliberately only provides the vocabulary — it doesn't force it onto
any particular content type. To use it, add a **term‑reference field** pointing at
the licences vocabulary to whatever content types or entities you want to tag with
a licence (under **Structure → Content types → *(type)* → Manage fields**). Then
configure its display under **Manage display** so the selected licence — and its
logo — shows where you render the content.

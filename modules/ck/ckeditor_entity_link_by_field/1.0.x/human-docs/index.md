# CKEditor Entity Link by Field — manual setup guide

**CKEditor Entity Link by Field** (`ckeditor_entity_link_by_field`) adds a CKEditor
button that lets content authors link to a node by autocompleting on one of its
**fields** rather than on its title. The classic case is citing referenced
articles by a date or publication identifier instead of by headline — often the
identifier editors actually remember and use when cross‑referencing content. An
editor types part of that field's value, picks the matching node from an
autocomplete list, and a link is inserted.

Under the hood it works like a field‑scoped version of Linkit: it registers an
"Add link by field" dialog for a text format and an autocomplete that searches the
field you configure. On the settings form, an administrator maps an entity type to
the source field the autocomplete should search. In its current release it
supports **nodes and a single content type (bundle)** — it was written to be
extended further, but that is what ships.

It targets the legacy **CKEditor 4** editor (`ckeditor`) and depends on the
**Editor** (`editor`) and **Linkit** (`linkit`) modules. It does **not** work fully
on enable: you must configure the source field and enable the button on a text
format first. It also defines its own permission, *administer
ckeditor_entity_link_by_field*, which should go only to trusted editors.

> **Security caveat worth reading before you expose this.** The autocomplete
> endpoint is gated only by the *access content* permission (granted to anonymous
> users by default) and its node query does not run an access check or filter by
> published status. That means the configured field values and node IDs of
> **unpublished** articles can be returned to anyone with *access content* — the
> results even mark unpublished nodes with a 🚫. If your unpublished content is
> sensitive, treat this as a real exposure and harden it (see the note in
> [Configuration](configuration/index.md)) before using the module on a public
> site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — map the source field, add the button
   to a text format, and review the security note.

## Where it lives in the admin menu

The settings form for mapping entity types to their source field lives at
**Administration → Configuration → Content authoring → CKEditor Entity Link by
Field** (`/admin/config/content/ckeditor_entity_link_by_field`). Reaching it
requires the *administer ckeditor_entity_link_by_field* permission.

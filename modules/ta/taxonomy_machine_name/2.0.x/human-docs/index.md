# Taxonomy Machine Name — manual setup guide

**Taxonomy Machine Name** (`taxonomy_machine_name`) gives every taxonomy term a
**machine name** — a clean, code-friendly identifier such as `blue_sky`
alongside the human-readable term name "Blue Sky". Core taxonomy terms only have
a numeric ID and a display name; this module adds a stable text slug you can rely
on in URLs, Views arguments, tokens, migrations, and custom code.

The machine name is filled in automatically whenever a term is saved. If you
leave it blank, the module transliterates the term name to ASCII, lowercases it,
and replaces anything that isn't a letter, number, or underscore with `_`. It
then makes the value unique within its vocabulary — so two terms both named
"Blue Sky" become `blue_sky` and `blue_sky_0`. You can also type a machine name
by hand on the term form, where a live checker warns you about duplicates.

Because the machine name is stored as a real, queryable field on the term, you
can look terms up by it, filter and validate Views arguments against it, and use
the `[term:machine_name]` token (for example in a Pathauto pattern). When you
first install the module it backfills machine names for all existing terms, and
if you later uninstall it the machine names are cleared out again.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the overview-page permission.

## Where it lives in the admin menu

This module has no settings page of its own. It works through the standard
taxonomy screens under **Structure → Taxonomy**
(`/admin/structure/taxonomy`), plus the standard **People → Permissions**
page for the one permission it adds.

## How to use it

**Set or view a machine name.** Open a term to edit it under
**Structure → Taxonomy → (your vocabulary) → Add/Edit term**. Just below the
**Name** field you'll find a **machine name** element. Leave it alone to let the
module generate one from the name, or click *Edit* to type your own — a live
checker flags duplicates as you type. (The words `add`, `list`, `delete`, and
`update` are rejected because they collide with taxonomy URLs.) Saving in code
also works: `$term->set('machine_name', 'my_slug')` then `$term->save()`; the
value is still cleaned and made unique on save.

**See the column on the term overview.** The vocabulary overview page
(`/admin/structure/taxonomy/manage/<vocabulary>/overview`) can show a **Machine
name** column, but only for users who have the **view machine name overview
page** permission. Grant it on the Permissions page, or with
`drush role:perm:add <role> 'view machine name overview page'`.

**Filter or route on it in Views.** When building a view you get two extra
handlers:

- A **Machine name** filter (choose it like the core term filter — dropdown or
  autocomplete, limited to a vocabulary, optional hierarchy).
- A contextual-filter (argument) validator called **Taxonomy term machine
  name**, so a URL argument can be a term's machine name instead of its numeric
  ID.

**Use the token.** `[term:machine_name]` resolves to the term's machine name
anywhere term tokens are available — handy for Pathauto URL patterns.

**Theme term pages.** On a term's canonical page, the module adds a
`term--<machine_name>` class to the `<body>`, so you can target specific terms
in CSS or Twig.

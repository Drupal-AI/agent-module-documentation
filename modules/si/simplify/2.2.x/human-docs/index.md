# Simplify — manual setup guide

**Simplify** (`simplify`) de-clutters Drupal's content-editing forms by hiding
particular built-in fields and fieldsets that editors rarely need — things like
*Authoring information*, *Promotion options*, *Revision information*, *URL path
settings*, and the text-format selectors under rich-text fields. It works on
node, user, taxonomy, comment, block, media, and menu-link forms, so you can give
non-technical editors a clean, focused editing screen without confusing extras.

A key point: Simplify **hides** fields, it does not remove them. Most fields are
concealed with a "visually hidden" CSS technique, and a few (URL path settings)
are fully removed from the form. Either way the field's existing data is
preserved and, for the visually-hidden ones, still submitted — so hiding a field
never destroys content. Hidden fields also stay visible to trusted users: anyone
with the **View hidden fields** permission sees everything as normal, and by
default administrators do too (there is a switch to override that).

The module works only after you configure it — enabling it alone hides nothing.
You open its settings form and tick which fields to hide for each entity type.
Those are the site-wide ("global") settings; on top of them you can add
per-bundle overrides directly on each content type, comment type, vocabulary, or
custom block type edit form. Which options appear depends on the modules you have
enabled — Book, Menu, Path, Comment, Content Translation, Metatag, Redirect, and
others each contribute their own hideable rows. Simplify has no dependencies of
its own beyond Drupal core (10.3 or 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact config object
keys, the element keys, and the alter hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the per-bundle
   overrides, and the permissions that decide who sees the simplified forms.

## Where it lives in the admin menu

Simplify's settings form sits at **Configuration → User interface → Simplify**
(`/admin/config/user-interface/simplify`). Its two permissions —
*Administer Simplify* and *View hidden fields* — are on the People → Permissions
page.

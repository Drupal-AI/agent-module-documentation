# Configuration

## Open the settings form

1. Log in as a user with the **Administer better field descriptions settings**
   permission.
2. Go to **Configuration → Content authoring → Better field descriptions**, or
   navigate directly to `/admin/config/content/better_field_descriptions`.

## The settings form

On this screen you decide which bundles and fields the module manages and how
their descriptions are displayed. The key choice is the **position** of the
description relative to the field:

- **Above the label**
- **Below the label**
- **Below the widget** (where core normally puts it)

Because the description renders through a theme template, you (or your themer) can
then style it to look like real guidance rather than default fine print.

## Editing the descriptions in bulk

The reason to use this module is that you edit descriptions from a single screen
rather than field by field. Users with the **Add better descriptions to fields**
permission get bundle and entity screens where the help text for a bundle's fields
is listed together for editing. Type or paste the guidance for each field and
save — no more opening one field settings form at a time.

The description text accepts a limited set of HTML (emphasis, links, and similar),
filtered through Drupal core's restricted allowed‑tags filter, so you can add a
link or a bit of emphasis but not scripts.

## Permissions

| Permission | What it allows |
|------------|----------------|
| **Administer better field descriptions settings** | Open the settings form and choose which fields are managed and where descriptions appear. |
| **Add better descriptions to fields** | Open the bundle/entity screens and actually write the description text. |

> **Grant the second permission carefully.** It is not marked as
> restricted, and it lets its holder change help text across **every bundle on the
> site**. Treat it as an editorial‑lead permission rather than something every
> general editor gets.

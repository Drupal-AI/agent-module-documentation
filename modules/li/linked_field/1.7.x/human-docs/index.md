# Linked Field — manual setup guide

**Linked Field** (`linked_field`) adds a **"Link this field"** option to any field
formatter, wrapping that field's rendered output in an HTML link to a destination
you choose — with no theming, no template overrides, and no custom code. You set
it up entirely on Drupal's **Manage display** screen, per field, per view mode.

The destination can be one of two things: **another field's value** on the same
entity (for example, link a company-name field to that entity's "website" field),
or a **custom URL or path** that supports tokens (for example link a teaser image
to `[node:url]`). You can add link attributes — title, target, class, rel — under
an Advanced section, and optionally override the link text with a token. It works
on almost any field type: images and pictures become fully clickable, and text,
number, and list values get wrapped in an anchor.

Because the settings are stored as **third-party settings** on the display
component, they travel with your display configuration and export and deploy like
any other config — and you can link a field differently in different view modes
(say, teaser vs. full). One small admin page lets you control which link
**attributes** are offered in that Advanced section. It's a lightweight,
dependency-light way to make existing fields click through to related content
without adding a separate link field or editing templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the render
behavior and the manager service — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per-field "Link this field"
   settings, and the admin page for available link attributes.

## Where it lives in the admin menu

Linked Field has two touch points:

- **Per field:** on **Structure → (content type) → Manage display**, inside each
  field's formatter settings — this is where you actually turn linking on.
- **Available attributes:** a small admin page at **Configuration → Content
  authoring → Linked Field** (`/admin/config/linked_field/config`), which controls
  which link attributes appear in the Advanced section. It requires the *Administer
  linked field* permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to a field's **Manage display** formatter settings (the gear icon), tick
   **Link this field**, and choose where the link should point.
3. Save the display.

See [Configuration](configuration/index.md) for the full field-by-field
walkthrough of both the per-field settings and the attributes admin page.

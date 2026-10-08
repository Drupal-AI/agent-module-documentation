# External Media — manual setup guide

**External Media** (`external_media`) adds a "pick from the cloud" file picker to
Drupal's file and image fields. Instead of downloading a file from Dropbox, Google
Drive, OneDrive or Box to their laptop and then re-uploading it into Drupal,
editors click a button on the field, the provider's own picker dialog opens in the
browser, and the chosen file comes straight into Drupal. It's a real time-saver for
large assets and for editors working on managed devices with little local storage.

Under the hood the module ships one plugin per provider — **Dropbox**, **Google
Drive**, **OneDrive** and **Box** — and two field widgets (one for file fields, one
for image fields) that expose the picker. Each provider's dialog is driven by that
vendor's own JavaScript running in the visitor's browser. You can turn individual
providers on or off and control who may use each one, because the module generates
a separate *"upload from …"* permission for every provider.

One subtlety worth knowing up front: a provider only appears if its supporting
code is actually present. The permission (and therefore the picker option) for a
given provider is created only when that provider's class can be loaded — so if you
expect Dropbox and it isn't there, the first thing to check is whether its SDK is
installed. Developers can also reuse the picker in custom forms by swapping a
`managed_file` element for the module's `external_media` element.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter each provider's client/app ID,
   choose which providers are available, and grant the per-provider permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → External Media**
(`/admin/config/media/external-media`), behind the *Administer site
configuration* permission. The picker itself appears on the **Manage form
display** screen of any content type, media type, or other fieldable entity, once
you set a file or image field's widget to one of the External Media widgets.

## How to use it

1. Install and enable the module, plus the SDK/library for each provider you want
   (see [Installation](installation/index.md)).
2. On the [settings form](configuration/index.md), enter the client/app ID for
   each provider you're enabling.
3. Grant the relevant *"upload from …"* permissions to the roles that should be
   allowed to import from each provider.
4. On a content type's **Manage form display**, change a file or image field's
   widget to **External Media** (or the image variant). Editors will now see the
   cloud-picker button when they edit that field.

File-extension and cardinality settings on the field are respected in the picker
where the provider supports them.

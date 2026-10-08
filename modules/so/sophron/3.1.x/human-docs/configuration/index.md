# Configuration — the Sophron settings page

Sophron has a single admin page, **Sophron – MIME Types**, where you choose which
MIME-map backs the module and, optionally, apply commands that add or correct
individual type-to-extension mappings. For many sites the defaults are fine — Sophron
already provides a much fuller map than core out of the box — so treat this page as
"tune only if you need to" rather than a required setup step.

## Open the settings page

1. Log in as an administrator.
2. Go to **Configuration → System → Sophron**
   (`/admin/config/system/sophron`).

The page opens on the **MIME type guessing** tab and looks like this:

![The Sophron – MIME Types settings page](../images/settings.png)

As the screenshot shows, the intro line confirms Sophron "provides an extensive MIME
types management API, enhancing Drupal core capabilities" and integrates with the
FileEye/MimeMap PHP library. Down the left are four vertical tabs, and a **Save
configuration** button sits at the bottom of the page.

## The MIME type guessing tab

This is the tab shown when the page first loads. It tells you **who is currently
doing MIME-type guessing** on your site. On a fresh install it reads:

> **Drupal core** — Drupal core is providing MIME type guessing. *Install the
> Sophron guesser module* to allow the enhanced guessing provided by Sophron.

In other words, installing the Sophron module alone does **not** change how the whole
site guesses file types; it makes the API and map available. To have Sophron's richer
map applied to uploads and file handling everywhere, enable the **Sophron guesser**
submodule (see [Installation](../installation/index.md)). Once that submodule is
enabled, this tab reflects that Sophron is providing the guessing.

## The Mapping tab — choosing a map class and applying overrides

Click the **Mapping** tab to control which map backs the module. Sophron lets you
pick one of a few **MIME-map classes**:

- the **FileEye/MimeMap default map** — the library's full, standards-based map (the
  usual choice);
- the **Drupal core map** — mirrors core's smaller built-in list; or
- a **custom map class** — the fully-qualified name of your own PHP map class, for
  specialised deployments.

Below the class choice you can supply an ordered list of **map commands** (mapping
overrides). Each command mutates the active map when it initialises — for example to
**add** a new extension-to-type mapping, or to **remove or correct** a default
mapping that is wrong for your site. Commands are applied in order, so a later command
can adjust the result of an earlier one. This is how you extend the map for
proprietary or industry-specific file formats, or fix a single incorrect
type-to-extension pairing, without writing any code.

> If a map command is malformed or conflicts with the chosen map, Sophron records it
> as a mapping **error** and surfaces it on the site's **Status report**
> (Reports → Status report), so check there if something you added does not take
> effect.

## The MIME types and File extensions tabs

These two tabs are **read-only browsers** into the active map:

- **MIME types** lists every MIME (media) type the current map knows about.
- **File extensions** lists every file extension the current map knows about.

Use them to confirm that a format you care about (say `image/avif` or a niche
extension) is present, and to see the effect of any map commands you added on the
Mapping tab.

## Save

When you have chosen a map class and entered any map commands, click **Save
configuration** at the bottom of the page. Your changes apply to the map the
`MimeMapManager` service builds from that point on — and, if the `sophron_guesser`
submodule is enabled, to the MIME-type guessing used across the whole site.

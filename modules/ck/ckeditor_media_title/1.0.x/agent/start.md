<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Media Title (ckeditor_media_title) — agent index

A CKEditor 5 plugin that lets editors **override the HTML `title` attribute of an embedded
`<drupal-media>` element** (typically an image) per content instance — for tooltip/accessibility
text — without changing the underlying media entity. Package `CKEditor 5`. Core `^10 || ^11`.
License GPL-2.0-or-later. Installed as **1.0.1** (version dir `1.0.x`). *Minimally maintained*,
**not covered by the security advisory policy**.

## Dependencies

- Drupal core modules only: **`ckeditor5`** and **`media`** (`.info.yml`).
- No PHP libraries, no `composer.json` in the source tree, no external APIs.

## What it provides (from source)

Entirely client-side behaviour plus a one-checkbox PHP config plugin. There are **no routes, no
services, no permissions, no controllers, no hook implementations, no `.module`/`.install` files**.

- **CKEditor 5 plugin** `ckeditor_media_title_mediaImageTitle` (`ckeditor_media_title.ckeditor5.yml`),
  PHP class `src/Plugin/CKEditor5Plugin/MediaTitle.php`.
  - Extends `CKEditor5PluginDefault`, implements `CKEditor5PluginConfigurableInterface` and
    `CKEditor5PluginElementsSubsetInterface`.
  - Single config value `enabled` (bool, default `FALSE`); config schema
    `ckeditor5.plugin.ckeditor_media_title_mediaImageTitle` (`config/schema/ckeditor5_media_title.schema.yml`).
  - `buildConfigurationForm()` renders one checkbox "Enable media image title override".
  - `getDynamicPluginConfig()` — when enabled, adds the `mediaImageTitle` button to the
    `drupalMedia` toolbar; returns `[]` when disabled (so the button is hidden).
  - `getElementsSubset()` — when enabled, allows exactly **`<drupal-media title>`** (only the
    `title` attribute on `<drupal-media>`; not `attributes:true`, no wildcard widening); returns
    `[]` when disabled.
  - `conditions: { filter: media_embed }` — the plugin is only available on formats that run the
    core Media Embed filter.
- **JS** `js/build/media-title.js` (loaded via library `ckeditor_media_title/media_title`,
  `.libraries.yml`; depends on `core/ckeditor5` and `ckeditor5/drupal.ckeditor5.media`). Defines the
  CKEditor 5 `MediaTitle` plugin (`MediaTitleEditing` + `MediaTitleUI`):
  - **Editing**: extends the `drupalMedia` model schema with a `drupalMediaEntityTitle` attribute;
    upcasts the `<drupal-media title>` view attribute to that model attribute and downcasts it back
    to the `title` view attribute (both data and editing downcast).
  - **Command** `mediaImageTitle`: enabled only when a `drupalMedia` element is selected; `execute`
    sets `drupalMediaEntityTitle` to the entered value, or removes it when blank.
  - **UI**: a toolbar `ButtonView` ("Override media image title", "T" icon) that opens a
    `ContextualBalloon` form (`MediaTitleFormView`) with a labeled text input plus Save/Cancel;
    Esc and click-outside close it. Styling in `css/media-title.admin.css`.
- **No submodules.**

## Data flow / how the title reaches output

Editor types a value → JS stores it on the `drupalMedia` model as `drupalMediaEntityTitle` →
downcast writes `<drupal-media ... title="value">` into the saved HTML (the format's filter allows
the `title` attribute via `getElementsSubset`) → on render, **core's Media Embed filter**
(`Drupal\media\Plugin\Filter\MediaEmbed`) processes `<drupal-media>` and produces the media markup;
attribute output goes through the standard Drupal render/escaping pipeline. This module contributes
**no PHP output path** of its own — it neither renders nor echoes the title.

## Configuration

No admin config page (`configure` is null). Enable per text format at
`/admin/config/content/formats` → edit a CKEditor 5 format that has the Media Embed filter → check
**Enable media image title override** under the plugin settings. Then select an embedded media item
in the editor and use the **T** toolbar button.

## Notes for agents

- Single comprehensive doc is intentional: this is a trivial, self-contained plugin with no PHP
  runtime surface beyond the config checkbox. No subdocs.
- The value is authored by a user already trusted to use the text format and embed media; output
  escaping is core's responsibility (Media Embed + render pipeline). The element subset is narrow
  (`title` only), not a GHS `attributes:true` widening.

# Configuration

Media Library Extend is configured by creating **panes**. A pane binds one source plugin to one
media type and, optionally, stores that plugin's own settings. Each pane you create becomes an
extra tab in the Media Library — but only when its media type is one the field being edited is
allowed to use.

## Open the Panes admin screen

1. Log in as a user with the **Administer site configuration** permission (an administrator by
   default — the module adds no permission of its own).
2. Go to **Configuration → Media → Media library → Panes**, or navigate directly to
   `/admin/config/media/media-library/pane`.

This is a standard config-entity list where you add, edit, and delete panes.

## Create a pane

On the add/edit form you make three choices:

1. **Media type (bundle)** — the media type this pane produces (for example your *Image* media
   type). This is also what decides *where* the tab shows up: the pane appears in the Media
   Library only for fields whose allowed media types include this one.
2. **Source plugin** — which `MediaLibrarySource` plugin supplies the items. Only plugins whose
   declared source types match the chosen media type are offered.
3. **Plugin configuration** — any settings the chosen plugin exposes (see the examples below).

Save, and the pane's summary appears in the list. Repeat to offer several source tabs (for
example upload plus an external service) for the same kind of field.

## What editors see

When an editor opens the Media Library on a field whose media type matches a pane, the pane
renders as an extra tab. The tab shows the plugin's filter form (if any), a paged, filterable
preview grid of results, and a selection form. When the editor picks an item, the module turns
the selection into a real media entity — typically downloading the remote asset into a new media
entity of the pane's media type — so the rest of Drupal treats it like any other media.

## The shipped example plugins

The module includes two example image sources that fetch placeholder photos from
picsum.photos. They are meant for prototyping and testing, not production:

| Source plugin | Configuration it exposes |
|---|---|
| **Lorem Picsum** (`lorem_picsum`) | *Items per page* (integer). Grayscale is toggled per request via the tab's filter form. |
| **Configurable Lorem Picsum** (`configurable_lorem_picsum`) | *Items per page* (integer) **and** *Grayscale* (a stored on/off setting on the pane). |

Bind either to your Image media type to see a working external-source tab in minutes.

## Beyond the examples

For a real integration you either install a contrib source plugin (such as Media Library
Youtube) or write your own `MediaLibrarySource` plugin — for example to import from a DAM or a
stock-photo API. Every custom plugin also needs a small config-schema mapping so its per-pane
settings validate. The plugin interface, the `MediaLibrarySourceBase` helpers, the config-schema
requirement, and the `hook_media_library_source_info_alter()` hook are all documented in the
sibling agent docs:

- [`agent/plugins/source.md`](../agent/plugins/source.md) — writing a source plugin.
- [`agent/configure/panes.md`](../agent/configure/panes.md) — the pane config entity and schema.
- [`agent/hooks/hooks.md`](../agent/hooks/hooks.md) — the alter hook and theme hooks.

## Theming

Three templates control the pane markup — `media-library-pane.html.twig` (the tab wrapper),
`media-library-pane-content.html.twig` (the preview grid), and
`media-library-result-preview.html.twig` (a single result). Override any of them in your theme
to restyle the source tabs.

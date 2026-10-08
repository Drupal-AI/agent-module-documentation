# Configuration

## Open the settings form

1. Log in as a user with the **Access media folders configuration** permission.
2. Go to **Configuration → Media → Media Folders**, or navigate directly to
   `/admin/config/media-folders`.

## Settings, field by field

- **Default view** — how the browser opens: **thumbnails** (default) or **list**.
- **Default order** — the sort order of items within a folder. Default is
  newest-first (`date-desc`).
- **Show thumbnails** — whether image thumbnails are rendered in the browser. Off
  by default; turn it on for a more visual experience (at some rendering cost on
  large libraries).
- **Disable CKEditor** — turn off the CKEditor 5 "embed media from folders"
  integration globally. Leave it off (i.e. integration enabled) if you want
  editors to insert media from folders in rich text.
- **Pager limit** — how many files are loaded per "page" / load-more chunk in the
  browser. Default `500`.
- **Form mode** — per Media type (audio, document, image, video, remove_video),
  which media **edit form mode** is used inside the browser. Leave at *default*
  unless you have created custom form modes.

### Extension → Media type mapping

The settings form also builds an **Extension bundles** section: for each file
extension it detects, a select lets you choose which **Media type (bundle)** a
file of that extension becomes when uploaded through the folder browser. Set these
so, for example, `pdf` uploads become *Document* media and `jpg`/`png` become
*Image* media. This is what makes drag-and-drop upload "just work".

Click **Save configuration** to apply.

## The folder vocabulary

Folders are terms in a taxonomy vocabulary named **Media folders folder**
(`media_folders_folder`), installed with the module. You normally create and
manage folders from the browser at **Content → Media folders**, not from the
taxonomy admin — but the vocabulary is there if you need it. Remember the tree is
**logical only**: moving media between folders re-tags them; it does not move the
physical files on disk.

## Sync existing media into folders

If you enable Media Folders on a site that already has media, use the **Sync**
tool at `/admin/config/media-folders/sync` (requires **Administer modules**) to
reconcile existing media items into the folder structure.

## Who can do what (permissions)

Media Folders deliberately reuses core permissions instead of creating broad new
ones:

- **Access media folders configuration** — the module's only own permission; it
  gates just this settings form. (Not marked security-restricted.)
- **Browsing / preview / search** — requires core **Access media overview**.
- **Creating, renaming, or deleting folders** — requires **Administer taxonomy**,
  or the matching *create / edit / delete terms in media_folders_folder*
  permission.
- **Uploading / creating / moving media** — requires the standard media create
  permissions (**Administer media**, **Create media**, or *create &lt;bundle&gt;
  media*).
- **Editing media** — requires the standard media update permissions
  (**Administer media**, **Update any media**, or *edit any/own &lt;bundle&gt;
  media*).
- **Sync tool** — requires **Administer modules**.

The net effect: an editor with *Access media overview* can browse, but any change
still needs the appropriate taxonomy/media permission, so the module never
escalates privilege beyond core.

## The widget, formatter, CKEditor plugin, and bulk action

These aren't on the settings form — you enable them where the relevant entity is
configured:

- **Media Folders field widget** — on a media **entity-reference** field, go to the
  bundle's *Manage form display* and set the field's widget to **Media Folders** so
  editors pick media through the folder browser.
- **Media Folders field formatter** — on *Manage display*, choose the **Media
  Folders** formatter to render such a field.
- **CKEditor 5 integration** — add the Media Folders button to a text format's
  CKEditor toolbar (unless disabled via the **Disable CKEditor** setting above).
- **Add to folder action** — appears as a bulk action on media listings, letting
  you file selected media into a folder. Running it is gated by the same media
  edit permissions listed above.

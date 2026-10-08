# Configuration

Filebrowser is configured in three places: the **global defaults** form, the
**per‑listing** settings on each Directory listing node, and the **permissions**
that decide who may do what. This page walks through all three.

## 1. Global defaults

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Filebrowser**, or directly to
   `/admin/config/system/filebrowser`.

The values here are the **defaults that new Directory listing nodes inherit** —
each node then keeps its own copy, which you can override on the node form. The
settings are grouped as follows.

### Rights

- **Explore sub‑directories** *(on by default)* — let visitors descend into
  sub‑folders.
- **Download archive** *(off by default)* — offer a "download all as zip" button.
- **Create folders** *(off by default)* — let permitted users create sub‑folders.
- **Download method** *(default private)* — **Private** streams the file through
  Drupal so downloads are permission‑checked (the file must live in a `private://`
  stream); **Public** redirects the browser straight to the file URL.
- **Force download** *(off by default)* — send files as attachments
  (`Content‑Disposition: attachment`) so they download rather than open in the
  browser.
- **Forbidden files** — a blacklist of file patterns to hide, one per line, globs
  allowed (defaults hide things like `*.git` and `*.svn`).
- **Whitelist** — if set, only files matching these patterns are listed.

### Uploads

- **Enabled** *(on by default)* — allow uploading files into the folder.
- **Allow overwrite** *(off by default)* — permit replacing an existing file.
- **Accepted extensions** — a space‑separated list of allowed upload extensions
  (defaults include common image, document, and audio types).

### Presentation

- **Overwrite breadcrumb** *(on by default)* — replace the breadcrumb so it
  reflects the folder hierarchy being browsed.
- **Default view** *(default list view)* — **list view** (a table) or **grid view**
  (a thumbnail grid). Grid view has additional options (columns, image style,
  alignment, dimensions) that appear on the node form.
- **Hide extension** *(off by default)* — drop file extensions from the displayed
  names for a cleaner look.
- **Visible columns** — which columns appear: icon, name, created, size, mimetype.
- **Default sort** and **sort order** — the column (name, size, created, mimetype)
  and direction (ascending or descending) the listing sorts by initially.

## 2. Per‑listing settings (the node form)

Create a listing at **Content → Add content → Directory listing**
(`/node/add/dir_listing`). Alongside the usual title, the node form adds a
Filebrowser fieldset where you set:

- **Folder path** — the directory to expose, as a stream URI such as
  `public://docs` or `private://reports`. This is the one required value.
- The same **rights**, **uploads**, and **presentation** options described above,
  pre‑filled from the global defaults but overridable for this listing.

These per‑node values are stored by the module itself (not in Fields), so editing
the node and saving refreshes the cached file listing.

## 3. Permissions

Filebrowser defines a set of granular permissions and grants **none by default** —
you must assign them per role at **People → Permissions**
(`/admin/people/permissions`). The key ones:

| Permission | Lets a role… |
|---|---|
| `view listings` | View directory listings |
| `create listings` | Create a Directory listing node |
| `edit own listings` / `edit any listings` | Edit listings |
| `delete listings` / `delete any listings` | Delete listings |
| `download files` | Download individual files |
| `download archive` | Download a folder as a zip (the listing must also allow it) |
| `upload files` | Upload files (the listing must also allow uploads) |
| `create folders` | Create sub‑directories |
| `rename files` | Rename files and edit file descriptions |
| `delete files` | Delete files |

Two things to remember: the "upload" and "archive" permissions only take effect
when the individual listing's own settings also allow the action, and a set of
separate permissions exist for the module's metadata entity administration — those
govern the extensible‑column configuration, not the file listings themselves.

You can also grant permissions from the command line, for example:

```bash
drush role:perm:add anonymous 'view listings,download files'
```

## Save

After changing the global form, click **Save configuration**. Per‑listing changes
are saved when you save the node. Permission changes are saved on the Permissions
page — reload a listing to see the effect.

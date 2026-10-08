<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding the File to Media button to a view

File to Media has **no settings form**. You "configure" it by adding its Views field to a
view whose base table is **Files** (`file_managed`).

## In the UI

1. Go to *Structure → Views → Add view*, choose **Show: Files** (base table `file_managed`),
   and add a **Page** or **Block** display.
2. On the view, *Add* a field and pick **File to Media links** (help text: "Links to create a
   media item from this file.").
3. Save. Each file row now renders a dropbutton with a "Create <label>" link for every
   compatible media type.

## In views config (`views.view.<id>`)

The field handler entry looks like:

```yaml
display:
  default:
    display_options:
      fields:
        file_to_media:
          id: file_to_media
          table: file_managed
          field: file_to_media
          plugin_id: file_to_media
```

- `table: file_managed`, `field: file_to_media`, `plugin_id: file_to_media` are the values
  registered by `file_to_media_views_data_alter()`.
- The view's `base_table` must be `file_managed` (base_field `fid`).

## When the dropbutton shows a link (per file, per media type)

The `ToMedia::render()` handler hides the whole button unless the file qualifies, and lists
only compatible media types:

- **Hidden entirely** if the file already has a `media` usage (`file.usage`) OR the file is
  not publicly downloadable (`$file->access('download', anonymous)` is false — i.e. private
  files are skipped).
- **Per media type**, a "Create <label>" link is shown only when:
  - the current user has create access to that media type, and
  - the media type's source field is a file field whose `file_extensions` setting contains
    the file's extension.

So to actually see links you need at least one media type whose source (file/image/etc.)
field accepts the file's extension, and files that are public and not yet media-backed.

## Notes

- There is nothing to enable per-view beyond adding the field; behaviour is fixed in code.
- To gate visibility, use the view's normal access settings plus core media create
  permissions; the field itself does not add a permission.

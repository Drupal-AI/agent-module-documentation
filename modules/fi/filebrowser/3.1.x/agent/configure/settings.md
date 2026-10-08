# Global settings (`filebrowser.settings`)

Config object edited at **`/admin/config/system/filebrowser`** (route `filebrowser.settings`,
permission `administer site configuration`). These are the **defaults for new `dir_listing`
nodes**; each node keeps its own copy of the values (see
[dir-listing-node.md](../configure/dir-listing-node.md)).

## Structure (all under the top-level `filebrowser` key)

```yaml
filebrowser:
  folder_path:                 # default folder URI for new listings (usually empty)
  folder_path_encoded:
  rights:
    explore_subdirs: 1         # allow descending into sub-folders
    download_archive: 0        # offer "download all as zip"
    create_folders: 0          # allow creating sub-folders
    download_manager: 'private' # 'private' (streamed by Drupal) | 'public' (redirect to file)
    force_download: 0          # send Content-Disposition: attachment
    forbidden_files: "descript.ion\nfile.bbs\n*.git\n*.svn"   # blacklist (newline list, globs ok)
    whitelist: ''              # if set, only matching files are listed
  uploads:
    enabled: 1                 # allow uploads into the folder
    allow_overwrite: 0         # allow overwriting an existing file
    accepted: 'jpg jpeg png gif svg txt doc docx pdf mp3'     # accepted upload extensions
  presentation:
    overwrite_breadcrumb: 1
    default_view: 'list-view'  # 'list-view' | 'grid-view'
    encoding: 'UTF-8'
    hide_extension: 0
    visible_columns:           # value truthy = shown
      name: 'name'
      icon: 'icon'
      created: 'created'
      size: 'size'
      mimetype: '0'
    default_sort: 'name'       # name | size | created | mimetype
    default_sort_order: 'asc'  # asc | desc
    langcode: 'en'
  adhocsetting:
    external_host: ''
```

## Read / write with drush

```bash
drush cget filebrowser.settings filebrowser
drush cset filebrowser.settings filebrowser.rights.download_archive 1 -y
drush cset filebrowser.settings filebrowser.rights.download_manager public -y
```

Or in PHP (editable copy):

```php
$c = \Drupal::configFactory()->getEditable('filebrowser.settings');
$c->set('filebrowser.uploads.accepted', 'pdf txt')->save();
```

`download_manager: private` requires the file to live in a private stream (`private://`) that
Drupal serves; `public` redirects the browser straight to the file URL. Grid presentation also
reads a `presentation.grid_settings` sub-array (alignment, columns, image_style, auto_width,
grid_height, grid_width, grid_hide_title) that the node form populates.

# Configure Imce (profiles, settings, folders)

![Imce File Manager admin page](../../../../../../../screenshots/imce/3.1.x/profiles.png)

Manage at `/admin/config/media/imce` (route `imce.admin`). Permission: `administer imce`.
Two config objects:

## Global settings — `imce.settings`
```yaml
abs_urls: false        # return absolute URLs for selected files
admin_theme: true      # render /imce pages in the admin theme
roles_profiles:        # map role -> profile per stream wrapper scheme
  authenticated:
    public: member
    private: member
```

## Profiles — config entities `imce.profile.*` (`imce_profile`)
Add/edit/duplicate/delete via `/admin/config/media/imce/add-profile`,
`.../{imce_profile}` (edit / duplicate / delete forms). A profile:
```yaml
id: member
label: 'Member profile'
conf:
  extensions: 'jpg png gif'   # allowed upload extensions ('*' = any)
  maxsize: 2                  # max file size (MB)
  quota: 50                   # per-user disk quota (MB)
  maxwidth: 1024             # max image width (px)
  maxheight: 1024
  replace: 0                 # upload replace method
  thumbnail_style: ''        # image style id for thumbnails
  thumbnail_grid_style: false
  usertab: false             # show browser tab on user profile pages
  ignore_usage: false
  url_alter: false
  image_extensions: 'jpg jpeg png gif webp avif'
  lazy_dimensions: false
  folders:                   # tree of accessible folders
    - path: 'users/user[user:uid]'   # tokens allowed -> personal folders
      permissions:
        browse_files: true
        upload_files: true
        delete_files: true
        # further keys come from ImcePlugin::permissionInfo()
        # e.g. resize_images, create_subfolders, delete_subfolders
```

- `folders[].path` supports tokens (e.g. `[user:uid]`) so each user gets a private tree.
- Folder `permissions` keys are contributed by IMCE plugins — see
  [../plugins/imce-plugin.md](../plugins/imce-plugin.md).
- Role→profile resolution: `Imce::userProfile()` picks the profile assigned to the user's
  roles for the active scheme.
- Everything is config-entity/config-object based → exportable with `drush config:export`.

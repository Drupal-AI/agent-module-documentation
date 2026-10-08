# Configuration

Block Library has no global settings form. All configuration happens on the
**block content type** forms, one type at a time. Everything on this page is
about that **Icon** section.

## Open a block type's Icon settings

1. Log in as a user who can administer block content types (an administrator by
   default).
2. Go to **Structure → Block content → Block types**
   (`/admin/structure/block-content/types`).
3. Edit an existing type, or add a new one — for example
   `/admin/structure/block-content/manage/basic`.

Near the rest of the block type's settings you will find an open **Icon** section
with two ways to supply an icon. You only need to use one of them.

## Path to custom icon

A text field where you type the location of an existing icon file. Accepted
forms:

- A stream URI such as `public://hero-icon.svg` (a file in your public files
  directory).
- A path relative to the Drupal root, such as
  `modules/custom/mymodule/hero-icon.svg` or
  `themes/custom/mytheme/hero-icon.svg`.

This is handy when you keep your icons versioned inside a module or theme and want
several block types to point at them without re-uploading.

When you save, the path is validated: an absolute filesystem path is rejected, and
the file must actually exist (the module also tries prepending `public://` before
giving up). If it cannot find the file you will see the error *"The custom icon
path is invalid."*

## Upload icon

A file upload element as an alternative to typing a path. The file is validated as
an image, then copied into your site's default file scheme (usually `public://`),
and that resulting path becomes the icon.

Uploading requires core's **File** module to be enabled (it is in a standard
install).

## What happens when you save

The chosen path is stored as a *third-party setting* on the block content type's
configuration (under `block_library.icon_path`). Because it lives in the block
type's config, it is included when you export configuration and can be deployed to
other environments through config sync.

To **remove** an icon later, edit the block type and clear the Icon field — the
stored setting is unset and the block type goes back to showing no icon.

## How the icon appears

Once set, the icon shows up automatically in Layout Builder's "Add block" picker
next to the block type name:

- **SVG files** are read and inlined into the page (the XML prolog and DOCTYPE are
  stripped), so they can inherit the surrounding text color through CSS
  `currentColor`.
- **Other image types** (PNG, JPG, GIF) are rendered as a normal `<img>`.

There is nothing else to switch on — the picker updates as soon as the block
type's icon is saved.

## A note on trust

Only users who can administer block content types can set these icons, and the
picker renders on the Layout Builder authoring screen. The SVG markup is inlined
mostly verbatim (only the prolog/DOCTYPE are removed — scripts are **not**
stripped). That is by-design admin behavior, but it does mean you should keep icon
SVGs to trusted, sanitized assets: a malicious SVG uploaded by someone with
block-type-admin rights could run script for other editors who open the picker.

# Installation

## Requirements

Video Embed Field builds on core field and image handling. It needs:

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- Core's **Field** (`field`), **Image** (`image`), and **System** (`system`)
  modules — all part of Drupal core and enabled automatically as dependencies.
- No third‑party PHP libraries. (The optional **Colorbox** formatter works best
  with the separate Colorbox module installed, but it isn't required to use the
  field.)

## Install with Composer

From the project root:

```bash
composer require drupal/video_embed_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/video_embed_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video_embed_field -y
```

Enabling the module makes the **Video Embed** field type available. Nothing
appears on your site until you add the field to a content type and choose a
display formatter — see the main guide's
[How to use it](../index.md#how-to-use-it) section.

## Submodules — enable only what you need

Video Embed Field ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Video Embed Media** | `video_embed_media` | Lets the field back a core **Media** type, so embedded videos live in the Media library alongside images and files. Enable it if you use the Media library. |
| **Video Embed WYSIWYG** | `video_embed_wysiwyg` | Lets editors insert videos directly into **CKEditor 5** rich‑text fields, without needing the full Media suite. |

For example, to add Media library integration:

```bash
drush en video_embed_media -y
```

Each submodule requires the base Video Embed Field module, which is already
present once you've installed it above.

# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- A range of dependencies, which Composer resolves for you: core **REST**, **CKEditor 5**,
  **Field**, **Node**, **Taxonomy** and **HAL**, plus the contributed **UI Patterns**
  (`ui_patterns` and `ui_patterns_library`) and **REST consumer** (`restconsumer`)
  modules.
- **Two bundled patches** ship in the module's `composer.json` and are required:
  - `drupal/linkit` — issue 2886455 (multilingual cross‑linking support).
  - `drupal/ui_patterns` — issue 3315661 (check for Views live preview when rendering a
    row warning).

  These patches apply automatically during `composer require` **as long as Composer
  patching is enabled** for your project (the `cweagans/composer-patches` plugin). If
  your project doesn't yet use it, install and configure it before requiring
  Pagedesigner so the patches are applied.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared dependencies
(UI Patterns, REST consumer and the rest) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner -y
```

## Component submodules — enable only what you need

Pagedesigner is the framework; the actual building blocks come from component
submodules. Enable individually with `drush en`. The bundled submodules include:

| Submodule | What it adds |
|-----------|--------------|
| `pagedesigner_image` | Image component |
| `pagedesigner_imageedit` | In‑editor image editing/cropping |
| `pagedesigner_media` | Media library component |
| `pagedesigner_video` | Video component |
| `pagedesigner_audio` | Audio component |
| `pagedesigner_gallery` | Image gallery component |
| `pagedesigner_document` | Document/file component |
| `pagedesigner_svg` | SVG component *(handles SVG — review sanitisation)* |
| `pagedesigner_embed` | Embed component *(pulls in external content/scripts — review who can configure it)* |
| `pagedesigner_link` | Link component |
| `pagedesigner_layout` | Layout options for rows/columns |
| `pagedesigner_webform` | Embed a Webform |
| `pagedesigner_block` | Place blocks as components |
| `pagedesigner_pagetree` | Page‑tree navigation |
| `pagedesigner_multitheme` | Multi‑theme support |
| `pagedesigner_duplication` | Duplicate elements/pages |
| `pagedesigner_yoast` | Yoast SEO integration |
| `pagedesigner_frontendpublishing` | Front‑end publishing workflow |
| `pagedesigner_debug` | Developer/debug helper |

For example, to enable the image and layout components:

```bash
drush en pagedesigner_image pagedesigner_layout -y
```

> **Security tip:** the **embed** and **SVG** components can render untrusted markup.
> Enable them only if you need them, confirm how they handle their input, and restrict
> who can configure those components to trusted editorial roles.

## Related companion modules

Beyond the bundled submodules, separate projects extend Pagedesigner and are installed
on their own: **Pagedesigner Parts**, **Effects**, **Megadropdown**, **Responsive
Images**, **TMGMT** (translation), **Block Adaptable**, and **View Modes Display**. Each
has its own guide.

## Verify it worked

After enabling, edit a piece of content configured to use Pagedesigner — the
drag‑and‑drop editor should open, and the components you enabled should appear as
draggable tiles. Drag a row onto the canvas and drop a component into it to confirm the
editor is working.

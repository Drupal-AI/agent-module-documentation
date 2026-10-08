# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`), plus a number of other core
  modules the base module depends on: CKEditor 5, Field, Field group, File, Filter,
  Options, System, Text, User, Views, Entity Reference Revisions, Media, and Media
  Library.
- Several contributed modules pulled in as dependencies: **Video Embed Field**,
  **Linked Field**, **Color Field**, **Media Library Form Element**, **Inline
  Entity Form**, **Block form alter**, **jQuery UI Slider**, **jQuery UI Tooltip**,
  and **Slider Widget**.

Because there are many dependencies, install with the `-W` flag so Composer can
resolve them all together.

## Install with Composer

From the project root:

```bash
composer require drupal/layoutcomponents -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull
in and update the full set of core and contributed dependencies listed above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layoutcomponents -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layoutcomponents -y
```

## Submodules — enable only the components you need

Layout Components ships each component (and a couple of helpers) as its own
submodule, so you enable only what a given site uses. Enable them with `drush en`.
The component submodules include, among others:

| Submodule | What it adds |
|-----------|--------------|
| `lc_simple_card` / `lc_simple_card_with_float_text` | Card components |
| `lc_simple_accordion` | Accordion component |
| `lc_simple_tabs` | Tabs component |
| `lc_simple_button` | Button component |
| `lc_simple_text` / `lc_simple_title` | Text and title components |
| `lc_simple_image` (and image/text variants) | Image components |
| `lc_simple_video` / `lc_simple_iframe` | Video and iframe components |
| `lc_simple_countdown` | Countdown component |
| `lc_simple_timeline` | Timeline component |
| `lc_simple_social_links` | Social links component |
| `lc_simple_view_carousel` / `lc_slick` | View carousel and Slick integrations |
| `lc_simple_reference_field` / `lc_simple_inline_images` | Reference and inline image helpers |
| `lc_commands` | Import/export of blocks in displays |

For example, to add the card and accordion components:

```bash
drush en lc_simple_card lc_simple_accordion -y
```

> **Reminder:** review who may configure the **iframe** component
> (`lc_simple_iframe`), since it can embed arbitrary URLs.

## Verify it worked

Open the **Layout Builder** editor on an entity that has Layout Builder enabled, add
a section, and confirm the richer Layout Components section options appear. Add a
component from one of the submodules you enabled and check it renders with a live
preview. See [Configuration](../configuration/index.md) for the section, column, and
component options.

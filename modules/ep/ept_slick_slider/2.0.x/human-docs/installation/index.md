# Installation

## Requirements

EPT Slick Slider builds on two other modules:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.

The slider is driven by the **Slick** JavaScript library, which is a **jQuery**
plugin — so enabling this component brings jQuery onto any page carrying a slider.
There are no PHP extension requirements to install by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_slick_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, and any shared dependencies they need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_slick_slider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_slick_slider -y
```

Enabling the module also enables `ept_core` and `paragraphs` if they aren't
already on, then imports the **Slick Slider** paragraph type.

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm a **Slick Slider** type is
   listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add a
   **Slick Slider** paragraph, add a couple of slides, and save.
3. View the page — the slider should render and rotate through the slides.

For how to place and configure the slider, see
[How to use it](../index.md#how-to-use-it) in the overview.

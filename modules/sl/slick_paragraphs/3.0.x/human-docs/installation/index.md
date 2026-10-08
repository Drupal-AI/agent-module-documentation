# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), including Drupal
  10 and 11.
- The **Slick** module (`drupal/slick`, `^3.0`) — provides the carousel engine
  and the optionsets these formatters reference. Slick in turn needs the **Blazy**
  module and the Slick JavaScript library.
- The **Paragraphs** module (`drupal/paragraphs`, `^1.0`) — provides the
  Paragraphs field type that becomes your slides.

Composer pulls in Slick and Paragraphs for you. Note that Slick has its own
external JavaScript library requirement (the Slick carousel library) — follow the
Slick module's installation instructions to place it, otherwise the carousels
won't animate.

## Install with Composer

From the project root:

```bash
composer require drupal/slick_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Slick,
Paragraphs, Blazy, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/slick_paragraphs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slick_paragraphs -y
```

Enabling it also turns on Slick, Paragraphs, and Blazy if they aren't already
active. Slick Paragraphs ships **no submodules**, and it has **no settings form**
to visit afterward — you configure everything on your Paragraphs field's display
(see the [overview](../index.md#how-to-use-it)).

## Verify it worked

Make sure you have a Slick **optionset** at **Configuration → Media → Slick**
(`/admin/config/media/slick`). Then, on a multi‑value Paragraphs field's **Manage
display**, confirm that **Slick Paragraphs Vanilla** (and, on a child Paragraphs
field, **Slick Paragraphs Media**) appears as a formatter choice.

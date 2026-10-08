# Installation

## Requirements

EPT Call to Action builds on several other modules:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options. *Note:* this module does not itself name `ept_core` in its Composer
  requirements, which is the root of the compatibility issue described below, so
  pin it yourself.
- **EPT Basic Button** (`ept_basic_button`) — supplies the button styles used by
  the CTA's buttons.
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.
- Core's **Link** (`link`) and **Media** (`media`) modules, for the button link
  and the CTA image/video.

There are no PHP extension or third-party library requirements to install by
hand.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_cta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in
`ept_basic_button`, `paragraphs`, and the core modules it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_cta -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together — this module especially.** `ept_cta` does not
> declare a version constraint on `ept_core`, so Composer is free to resolve an
> `ept_core` whose widget signature this module's code does not match. Require and
> update the EPT modules as a set, and confirm the resolved `ept_core` version
> after installing.

## Enable the module

```bash
drush en ept_cta -y
```

Enabling the module also enables `ept_core`, `ept_basic_button`, `paragraphs`,
`link`, and `media` if they aren't already on, then imports the **Call to Action**
paragraph type.

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm a **Call to Action** type is
   listed.
2. **Important:** on a content type that has a Paragraphs field, edit a piece of
   content, add a **Call to Action** paragraph, and confirm the edit form
   actually appears and can be filled in and saved. If the form is missing, you
   have hit the `ept_core` 2.0.0 widget-constructor defect described in the
   overview — check and pin your `ept_core` version.

For how to place and style the call to action, see
[How to use it](../index.md#how-to-use-it) in the overview.

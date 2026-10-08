# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.

The base Crossword module has no requirements outside core. Some submodules add their
own dependencies (see the Submodules table below).

## Install with Composer

From the project root:

```bash
composer require drupal/crossword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crossword -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crossword -y
```

That's enough to get the Crossword field type and its playable formatter. Add the
field to a content type to start using it (see the [overview](../index.md)).

## Submodules — enable only what you need

Crossword ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Crossword Image** | `crossword_image` | Generates images from crossword files — useful for teasers or downloadable solutions. |
| **Crossword Colors** | `crossword_colors` | A UI to configure highlight and text colors. |
| **Crossword Media** | `crossword_media` | Integration with core Media (its configurable thumbnail comes from Crossword Image). |
| **Crossword Token** | `crossword_token` | Tokens for crossword files, e.g. `[node:field_crossword:entity:crossword_dimensions]`. Requires the **Token** module. |
| **Crossword Download** | `crossword_download` | Field formatters for downloading files. Requires **File Download Link**. |
| **Crossword Pseudofields** | `crossword_pseudofields` | Pseudofields representing parts of a puzzle, such as author and title. |
| **Crossword Status** | `crossword_status` | Client-side classes on rendered crossword fields based on completion status (solved, in-progress). |
| **Crossword Contest** | `crossword_contest` | A framework for a low-stakes puzzle-solving contest with server-side validation. |

For example, to add color configuration:

```bash
drush en crossword_colors -y
```

## Verify it worked

Go to a content type's **Manage fields**, add a **Crossword** field, then on **Manage
display** confirm the crossword formatters are available. Upload an Across Lite
`.txt` or `.puz` file into a piece of content and check that it renders as a playable
puzzle.

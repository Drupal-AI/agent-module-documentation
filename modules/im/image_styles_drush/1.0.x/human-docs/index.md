# Image Styles Drush — manual setup guide

**Image Styles Drush** (`image_styles_drush`) is a small module that adds a set of
**Drush commands** for building and managing image styles and their effects from
the command line. Instead of clicking through the Image styles UI, you can list,
create, and delete styles, add and remove effects, and inspect which parameters
an effect expects — interactively or from a script. That makes it handy for
scripting complex styles during deployment, reproducing styles across
environments, and automating style creation in CI/CD.

Its distinguishing feature is that effect parameters are passed as **JSON**
directly on the command line, so a whole chain of effects can be defined in one
scripted call. It works alongside the
[Image Effects](https://www.drupal.org/project/image_effects) module and similar
modules that register extra effects.

The commands are:

| Command | Alias | What it does |
|---------|-------|--------------|
| `image-styles:list` | `isl` | Display the list of image styles. |
| `image-styles:create` | `isc` | Create an image style. |
| `image-styles:delete` | `isd` | Delete an image style. |
| `image-styles:add-effect` | `isae` | Add an effect to a style. |
| `image-styles:delete-effect` | `isde` | Delete an effect from a style. |
| `image-styles:effects` | `ise` | Display the list of available effects. |
| `image-styles:params` | `isp` | Display an effect's parameters (as JSON). |

Run any command with `--help` to learn its arguments and options.

> **Caution:** Effect parameter values passed as JSON are **not validated** — bad
> values can break image rendering. For example, you **must** use web‑style hex
> colors (`#RRGGBB`) for color fields. Treat this as a power tool for trusted
> operators, and test on a non‑production copy first.

Because it runs only under Drush, there is no web‑facing form, no route, and no
permissions of its own — access is whatever your Drush/site shell already grants.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** — this module is CLI‑only, described in "How to use
it" below.

## Where it lives in the admin menu

Image Styles Drush adds no admin page. You use it entirely from the command line
with Drush. The styles it creates appear on the core **Image styles** screen at
**Configuration → Media → Image styles** (`/admin/config/media/image-styles`).

## How to use it

1. **See what's there** — list existing styles and available effects:

   ```bash
   drush isl          # list image styles
   drush ise          # list available effects
   drush isp <effect> # show an effect's parameters as JSON
   ```

2. **Create a style and add effects.** You can work interactively, or pass JSON
   parameters directly for scripting:

   ```bash
   drush isc          # create an image style (interactive)
   drush isae         # add an effect to a style (interactive, or with JSON params)
   ```

3. **Clean up** when needed:

   ```bash
   drush isde         # delete an effect from a style
   drush isd          # delete an image style
   ```

4. **Script it for deploys.** Capture the sequence of commands in a shell script
   so the same styles can be rebuilt on every environment. Remember to use
   `#RRGGBB` hex values for any color parameters.

> **Tip:** Run `drush isp <effect>` first to see exactly which JSON keys an effect
> expects before you script an `isae` call.

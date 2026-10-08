# Template Diff — manual setup guide

**Template Diff** (`template_diff`) is a small developer tool that shows you the
difference between two Twig templates. When you are working on a theme it is often
unclear *why* a template overrides the one provided by a base theme — Template Diff
answers that by printing a diff between the two files, so you can see exactly what an
override changed.

The problem it solves is theme archaeology: you inherit a project with a pile of
template overrides and no notes, and you need to know what each override actually
altered relative to the base theme (or another theme or module). Rather than
opening both files and eyeballing them, you run one command and read the diff.

You drive it entirely from the command line — there is no admin UI and no settings
page. It has no module dependencies of its own and ships no submodules. It is a
development aid, so you would typically enable it in a development environment rather
than production.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Template Diff provides a command that takes a template name and the two themes (or
modules) to compare. If you name only one theme, it compares against the active
theme's base theme.

Compare the `views-view` template in `my_theme` against `your_theme`:

```bash
drush template_diff:show views-view my_theme your_theme
```

Compare the `views-view` template in `my_theme` against a module, `your_module`:

```bash
drush template_diff:show views-view my_theme your_module
```

Compare the `views-view` template in the active theme against its base theme (omit
the theme arguments):

```bash
drush template_diff:show views-view
```

The command prints the diff between the two template files so you can read what
changed.

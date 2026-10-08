# Template Block — manual setup guide

**Template Block** (`template_block`) gives site builders a simple way to place a
block whose entire output is defined by a Twig template file in the active theme.
Instead of typing markup into a block body, you place a **Template Block**, give it
a short **suggestion name**, and then a front‑end developer creates a matching Twig
file in the theme — for example `template-block--promo.html.twig`. The block renders
whatever that template produces.

The problem it solves is keeping presentational markup where it belongs: in the
theme layer and in version control, rather than pasted into the database as body
content. Editors never write Twig or PHP — they only pick a suggestion name, which
is validated to lowercase letters, digits, and underscores — so there is no way to
inject template code through the block. The actual Twig lives in the theme, authored
by someone with filesystem access. You can place as many Template Blocks as you
like, each with its own suggestion and its own template, and the module
automatically adds a `template-block--<name>` CSS class to each block wrapper so you
can style them individually.

The module has **no dependencies** beyond Drupal core and ships no submodules. It
works with Block Layout and Layout Builder alike. It pairs especially well with the
**Twig Tweak** module (recommended, not required): with Twig Tweak available your
templates can embed views, blocks, fields, and entities directly.

The module does not work fully on‑enable — a Template Block only produces real
output once you have placed it, given it a suggestion, and created the matching
template in your theme (until then it shows a placeholder telling you which filename
to create). It has no central settings page; configuration happens per block
instance.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place a Template Block, set its
   suggestion, and create the matching theme template.

## How to use it

Place a **Template Block** through **Block Layout** or inside a **Layout Builder**
section, set its **Template Suggestion**, then create
`template-block--<suggestion>.html.twig` in your active theme and clear the cache.
See [Configuration](configuration/index.md) for the full walkthrough.

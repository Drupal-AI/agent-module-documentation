# Generic Colors — manual setup guide

**Generic Colors** (`generic_colors`) is an **AI Agent tool** that extracts the
predominant colors from an image. Rather than sending a picture to a large
language model just to ask "what colors are in this?", it runs a local PHP color
library on the file and returns a dominant color plus a ranked list of colors and
their percentages. Because the work happens on your server, it saves the tokens
(and cost) you'd otherwise spend having an LLM eyeball the image.

The module plugs into Drupal's **AI Agents** framework. Once enabled, it appears
as a tool that any Drupal AI Agent can call: you hand it a file ID or a media ID,
and it hands back the colors. It's handy for workflows like auto‑tagging media by
color, generating theme palettes from uploaded images, or accessibility checks.

It also ships an optional **AI Automator** that can be attached to a multi‑value
text field: when a node is saved, the automator calls the Generic Colors tool
against a configured image field and writes the detected colors back into the
text field. This has to be added to your field manually — see "How to use it"
below.

The module depends on the **AI** (`ai`), **AI Agents** (`ai_agents`), and
**Tool** (`tool`) modules, plus one Composer library that does the actual color
analysis.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its color
   library with Composer, then enable it.

There is **no dedicated configuration page** for this module. You test and use it
from the AI Agents explorer, and its optional automator is configured on a field
— both described below.

## Where it lives in the admin menu

Generic Colors adds no settings page of its own. After enabling it, you find the
tool on the **AI Agents explorer** page, where you can try it out by entering a
file ID or media ID and inspecting the returned colors. From there it can be
added as a **Tool** inside any Drupal AI Agent you build.

## How to use it

**As an agent tool.** Open the agents explorer, locate *Generic Colors* in the
tool dropdown, enter a file ID or a media ID, and run it. You'll get back a
`dominant_color` value and a `colors` list, each entry pairing a hex color with
the percentage of the image it covers. Once you're happy it works, wire it into
an AI Agent as one of that agent's tools.

**As an automator.** To have colors filled in automatically on content save, add
the bundled automator to a multi‑value text field on your content type and point
it at the image field you want analysed. When a node is saved, the automator runs
the tool against that image field and stores the colors in the text field. This
step is manual — the automator is not attached to any field until you add it.

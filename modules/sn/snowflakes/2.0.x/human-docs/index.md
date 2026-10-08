# Snowflakes — manual setup guide

**Snowflakes** (`snowflakes`) brings a bit of Christmas and winter flair to your
Drupal site by adding **pure‑CSS animated snowflakes** — falling snow that drifts
down over your pages. It wraps the well‑known CSSnowflakes effect and applies it
to your site without you having to touch any template files.

The effect is purely decorative and JavaScript‑free (it is done entirely with
CSS), so it is lightweight and adds no content, fields, or access behaviour of
its own. It is the kind of thing you switch on for the holiday season and switch
off afterwards.

The module does have a small settings form, so after enabling it you will
typically visit the settings to turn the snow on and adjust how it appears. It has
no module dependencies and no third‑party libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn the snow on and adjust how it
   shows.

## Where it lives in the admin menu

After enabling the module, its settings live at the **Snowflakes settings** form
(config object `snowflakes.settings`), reachable from the Configuration area.
Adjusting the settings requires the permission the module provides for
administering the effect.

# Devel Visualizer — manual setup guide

**Devel Visualizer** (`devel_visual`) helps developers make sense of how a site's
configuration fits together by rendering a graph of the relationships between
configuration objects — showing how config entities reference and depend on each
other — plus a handful of other administrator helper features. When you're trying to
untangle config dependencies before an export, a deletion, or a refactor, seeing
them as a diagram beats reading raw YAML.

It's an add-on for the **Devel** module (which it depends on) and is a
development-time tool: enable it in development to inspect config, and keep it away
from untrusted users. It ships its own permission, supports Drupal 10.3 and 11, and
is **not** covered by Drupal's security advisory policy — so review it before using
it anywhere sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (with Devel), and grant its permission.

There is no settings form to document — the module surfaces its visualizer and
helpers behind its permission rather than a configuration page.

## How to use it

1. Make sure **Devel** is installed and enabled, then enable Devel Visualizer.
2. Under **People → Permissions**, grant the module's permission to your
   developer/administrator roles only.
3. Open the visualizer to see the graph of configuration-object relationships and
   the additional admin helpers. Because it exposes configuration detail, keep it
   to trusted roles and development environments.

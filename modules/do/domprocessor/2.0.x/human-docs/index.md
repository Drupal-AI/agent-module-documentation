# DOM Processor API — manual setup guide

**DOM Processor API** (`domprocessor`) is a developer framework, not an
end‑user feature. It provides an API that other modules use to register **DOM
processors** — plugins that transform the DOM of rendered HTML output on the
server. Typical uses include rewriting elements, injecting attributes, or
otherwise post‑processing markup after Drupal has rendered it.

On its own the module does nothing visible: there is no content type, no block,
and no configuration screen. It is infrastructure that other modules build on to
apply structured HTML transformations. Because transformations run server‑side on
rendered output, the module has no content or access‑control role of its own.

It has no dependencies beyond Drupal core, runs on Drupal 9, 10, and 11, is
minimally maintained (maintenance fixes only), and is security‑advisory covered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it so that dependent modules can register DOM processors.

There is **no configuration page** for this module. You install it because another
module requires it; the behavior comes from whichever module registers the actual
DOM processors.

## How to use it

Enable DOM Processor API when a module you are installing lists it as a
dependency, or when you are developing a module that needs to transform rendered
markup. As a site builder there is nothing to configure. As a developer, you
implement a DOM processor plugin against this API and the framework applies it to
rendered output — consult the module's own developer documentation and the code
for the plugin contract.

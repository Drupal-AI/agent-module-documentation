# Flex Processor — manual setup guide

**Flex Processor** (`flex_processor`) is a **developer framework** for building
configurable data‑processing pipelines in Drupal. It lets developers attach
custom "processor" plugins to entities and other data structures, so they can
reduce, modify, enrich, or reshape that data into whatever form they need — most
often a clean, structured payload for an API response, but it works in any context
where you want to transform data.

Rather than hard‑coding a transformation, you define a **DataProcessor plugin**
that describes how to turn a given entity (or field) into the output you want, then
invoke it through the module's plugin manager service. Processors can call other
processors, so you can compose small, reusable pieces — for example a "node article
card" processor that delegates to a body‑field processor and an image processor.

This is infrastructure for developers, not a click‑through admin feature. It has no
admin UI and no settings page — what it does depends entirely on the processors
your project defines, and its security posture is that of those processors and the
data they handle. Review each pipeline for what it exposes and where its data comes
from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — Flex Processor is a code‑level framework with
no settings form, so this guide has no configuration chapter. You define behaviour
in your own module's processor plugins, as shown below.

## Where it lives in the admin menu

Flex Processor adds no admin page. You work with it entirely in code, from your own
module.

## How to use it (for developers)

1. In your own module, create a **DataProcessor plugin** that extends
   `Drupal\flex_processor\Plugin\EntityDataProcessor` and implements a `process()`
   method returning the structured data you want. Its annotation declares the
   entity `type`, the `bundles` it applies to, and a `variant` name, for example:

   ```php
   /**
    * @DataProcessor(
    *   id = "node__article__card",
    *   label = @Translation("Node: Article Card"),
    *   type = "node",
    *   bundles = { "article" },
    *   variant = "card"
    * )
    */
   ```

2. Inside `process()`, build and return the array you want — and, where useful,
   call `$this->dataProcessorManager->process(...)` on a field to delegate to
   another processor.

3. Trigger a processor by loading an entity and calling the plugin manager:

   ```php
   $data = \Drupal::service('plugin.manager.flex_processor')->process(
     $article,
     ['variant' => 'card'],
   );
   ```

   The result is a plain structured array (for example ready to `json_encode` for
   an API response). See the module's `README.md` for more examples.

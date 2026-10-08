# Drush Batch Bar — manual setup guide

**Drush Batch Bar** (`drush_batch_bar`) is a developer utility for running
Drupal's Batch API operations from a Drush command and showing a clean Symfony
Console progress bar instead of a flood of log lines. If you have ever run a long
batch job from the command line and watched hundreds of "processed item N" lines
scroll past, this module gives you the tidy, single progress bar you would see in
the admin UI — but in your terminal.

It is a coding tool rather than a point-and-click feature: you use it from your
own custom Drush commands. In your command method you build a standard Batch API
operations array, instantiate `DrushBatchCommands` with those operations, a
title, and an optional "finished" callback, and call `execute()`. The base
`DrushBatchBar` class drives the batch, updates the progress bar as it goes, and
prints a concise success/error summary at the end. If you need custom behavior you
can subclass `DrushBatchBar` to define your own operations, process method, and
finish method.

The module has no web routes, permissions, or configuration — it is pure CLI
plumbing. It ships an example submodule, **Drush Batch Bar Example**
(`drush_batch_bar_example`), with a runnable demo command so you can see the
progress bar before writing any code. It requires PHP 8.4 and Drush 12 or later,
and therefore Drupal 10.4+ or 11.1+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the example submodule.

There is **no configuration page** for this module — it is a developer library
you call from your own Drush commands, described under "How to use it" below.

## How to use it

Inside a custom Drush command, wrap your operations array in `DrushBatchCommands`
and run it:

```php
use Drupal\drush_batch_bar\Batch\DrushBatchBar;
use Drupal\drush_batch_bar\Commands\DrushBatchCommands;

$batch = new DrushBatchCommands(
  operations: $batch_operations,        // a standard Batch API operations array
  title: 'Title of your batch',
  finished: [DrushBatchBar::class, 'finished'],
);
$batch->execute();
```

You can pass your own callback as the `finished` parameter, and for more control
you can extend `DrushBatchBar` to define custom operations, a `process` method
(calling `parent::initProcess($context);` inside it), and a finish method —
overriding the `SUCCESS_MESSAGE` / `ERROR_MESSAGE` constants to customise the
summary text.

To see it in action first, enable the example submodule and run its demo:

```bash
drush drush-batch-bar   # alias: drush dbb
```

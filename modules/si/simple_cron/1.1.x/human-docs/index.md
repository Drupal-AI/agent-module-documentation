# Simple Cron — manual setup guide

**Simple Cron** (`simple_cron`) is a lightweight framework for defining and
managing cron jobs as **plugins**, giving you finer control than piling everything
into one big `hook_cron()`. Each job becomes a discrete, named unit you can enable
or disable, schedule with a crontab expression, run on demand, and monitor —
individually.

It is aimed at developers and site operators who have several background tasks and
want them separated rather than tangled together. A `SimpleCron` plugin base class
handles the boilerplate, including building each job's configuration form for you,
so you no longer hand‑write a settings form per task. Jobs can wrap Drupal core and
contrib cron work and queues, run several parallel tasks from one plugin, and
report their own status and error messages. The module also exposes a single cron
job URL and Drush support for listing and starting jobs from the command line. It
requires **PHP 8.1+** and the `dragonmantank/cron-expression` library (pulled in by
Composer), and ships an optional **Simple Cron Examples** submodule
(`simple_cron_examples`) with sample plugins to learn from.

Because jobs can be run on demand, the module defines permissions to control who
can do what — separating administering jobs, viewing them, and actually running
them. Grant the run permission carefully: running a job triggers real background
work immediately.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (optionally) enable the examples submodule.

## How to use it

Simple Cron is a developer framework, so the "how to use it" is mostly about
declaring jobs in code. A cron job is a plugin annotated with `@SimpleCron` that
extends `SimpleCronPluginBase` and implements a `process()` method:

```php
namespace Drupal\example_module\Plugin\SimpleCron;

use Drupal\simple_cron\Plugin\SimpleCronPluginBase;

/**
 * @SimpleCron(
 *   id = "example_cron_job",
 *   label = @Translation("Example cron job", context = "Simple cron")
 * )
 */
class ExampleCron extends SimpleCronPluginBase {

  public function process(): void {
    // Your cron job logic here.
  }

}
```

Enable the **Simple Cron Examples** submodule to see more complete samples.

Once a plugin exists, the module lets you manage each job — enable or disable it,
set its crontab, run it, and read its status. Access to these actions is governed by
the module's permissions: **Administer simple cron**, **View simple cron jobs**, and
**Run simple cron jobs**. Assign them under **People → Permissions**, and keep the
"run" permission limited to trusted operators since it triggers work on demand.
Jobs can also be listed and started with Drush.

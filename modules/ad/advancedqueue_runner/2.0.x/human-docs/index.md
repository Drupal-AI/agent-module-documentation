# Advanced Queue Runner — manual setup guide

**Advanced Queue Runner** (`advancedqueue_runner`) helps the
[Advanced Queue](https://www.drupal.org/project/advancedqueue) module get its
queued jobs processed in the background — without you having to configure a cron
job or run a Drush/CLI command by hand. Normally, work that Advanced Queue puts
on a queue sits there until cron fires or someone runs a queue-processing
command; this module lets that work be picked up and processed more promptly as
the site handles requests.

It is a small automation helper with one job: keep Advanced Queue's queues
moving. It depends on the Advanced Queue module and adds no content, no fields
and no permissions of its own.

A note on how it behaves: queued jobs run with the site's own privileges, the way
background processing always does. So make sure only trusted code puts jobs on
the queue, and keep in mind that processing queues during requests consumes
server resources.

This guide is written for a **human** setting the module up through the admin UI
and Composer. If you want terse, token-cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Advanced Queue.

## How to use it

Once Advanced Queue and Advanced Queue Runner are both enabled, there is nothing
to click. The runner simply ensures Advanced Queue's queued jobs are processed in
the background, so you no longer depend on a cron run or a manual queue command to
get queued work done. Continue enqueuing work with Advanced Queue as you normally
would — the runner takes care of processing it.

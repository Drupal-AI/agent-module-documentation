# H5P Analytics — manual setup guide

**H5P Analytics** (`h5p_analytics`) captures the learning-interaction data that
H5P content generates — the xAPI ("Experience API") statements emitted when
someone answers a quiz, watches an interactive video, drags-and-drops, and so on
— and forwards it to an external **Learning Record Store (LRS)** for learning
analytics. It builds on the [H5P](https://www.drupal.org/project/h5p) module and
belongs to the H5P family.

Here's how the pipeline works. As users interact with H5P content — both
logged-in users and anonymous visitors — H5P produces xAPI statements. This
module captures every statement, sends it to an internal endpoint that stamps it
with a timestamp, and puts it on a queue. Cron then processes that queue,
gathering statements into batches and storing them, and those batches are sent on
to your configured LRS. Because the heavy lifting happens on cron, **you must have
cron running regularly** for data to actually reach the LRS. An optional
`h5p_analytics_tip` submodule is included.

Please treat this module as handling **sensitive personal data**. xAPI
statements carry learner identifiers and a record of what each person did — that
is personally identifiable information and a learning record. So: send it only
over **HTTPS**, keep your **LRS endpoint credentials as secrets** (never
hard-coded or committed), and handle the data in line with your privacy policy
and any consent obligations you have to the people being tracked. This release is
**8.x-1.0-rc11**, a release candidate. The module is **not covered by Drupal's
security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure cron is running.
2. [Configuration](configuration/index.md) — point the module at your LRS and
   tune the batch size.

## Where it lives in the admin menu

Once enabled, the module exposes an **LRS settings** form (reachable from the
**Configuration** area) where you enter the LRS endpoint and credentials and set
the batch size — see [Configuration](configuration/index.md).

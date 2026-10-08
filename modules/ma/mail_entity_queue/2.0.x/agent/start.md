<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail Entity Queue — agent index

An **entity-queue-based system for processing/sending emails** (Symfony Mailer / Ultimate Cron / Webform
submodules). Depends on core `options`, `system`. Provides permissions. Version **2.0.4**. Core `^10||^11`.

Mail/operations — **bulk email** is powerful: ensure only trusted flows enqueue (avoid spam/relay), gate
permissions, keep content trusted. No access role beyond permissions.

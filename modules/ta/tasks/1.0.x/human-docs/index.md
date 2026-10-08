# Tasks — manual setup guide

**Tasks** (`tasks`) is a configuration kit: instead of shipping new PHP
functionality, it ships ready‑made Drupal configuration that gives your site a
working task/to‑do feature the moment you enable it. Turn it on and you get a
content type for tasks, a couple of Views that list and order them, and Flag
integration so a task can be checked off as done.

The design is deliberately simple to start with. Because the tasks are stored as
Storage entities, you are free to grow the setup to fit your site — add a due
date, a ticket ID, a "task type" taxonomy reference, or any other field you
need, all through the normal Field UI. One quirk worth knowing: after a task is
checked as done it stays visible until the next page refresh. If you would
rather have completed tasks vanish the instant they are checked, install the
[Views Flag Refresh](https://www.drupal.org/project/views_flag_refresh) module
and switch the view to use it.

Tasks depends on core **Link** and **User**, plus a handful of contrib modules
that supply the pieces the configuration wires together: **Flag** (the check‑off
behaviour), **Storage** (the entity the tasks live in), **Add Content by
Bundle**, **Display Link Plus** and **Draggable Views** (the editing and
ordering experience). It sits in the *Configuration Kits* package. There is no
settings form of its own — you enable it and then adapt the provided config. The
installed configuration follows Drupal's normal access rules; the module grants
no special permissions and has no access‑control role of its own.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its contrib
   dependencies with Composer, then enable it.

## How to use it

Once enabled, the kit's content type, Views and Flag are in place. Add a task
the same way you add any content, and the provided view lists them with
drag‑to‑reorder and a check‑to‑complete flag. From there, treat it as a
starting point: extend the task content type with your own fields, and edit the
Views to change how tasks are listed, filtered or ordered. If you use the
Olivero front‑end theme, note that the project also offers a companion "Tasks
Extras" module for nicer formatting and the ability to manage other users'
tasks; if you are on a different theme you can copy the relevant CSS into your
own theme and adjust it.

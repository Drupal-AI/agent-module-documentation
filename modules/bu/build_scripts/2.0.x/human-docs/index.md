# Build scripts — manual setup guide

**Build scripts** (`build_scripts`) lets site operators define build programs and
run them from the Drupal admin UI, viewing the logs of each run. The idea is to
trigger deployment and build tasks — compiling assets, warming caches, running an
external build step — without leaving Drupal for the command line.

You define the programs (stages) in configuration, and then trusted operators run
them on demand and read the output of each run in Drupal.

**Running build programs is a privileged operation.** The configured commands are
executed by the server, so they are effectively trusted-admin input, and the two
permissions that gate the module should go only to people you trust to run code
on the server:

- **administer build_scripts configuration** — define and edit the build
  programs.
- **use build_scripts** — run the programs.

Treat both like shell access. It supports Drupal 8 through 11; this release is
**2.0.0-beta2**.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Build programs are defined behind the **administer build_scripts configuration**
permission, and run behind the **use build_scripts** permission, from within the
Drupal admin UI.

## How to use it

1. Install and enable `build_scripts` (see [Installation](installation/index.md)).
2. Grant **administer build_scripts configuration** to the operators who will
   define build programs, and **use build_scripts** to those allowed to run them.
   Keep both restricted to trusted people — a configured command runs on your
   server.
3. Define your build programs (stages) — for example asset compilation, cache
   warming, or an external build step.
4. Run a program from the admin UI when needed, and review its log to see what
   happened.

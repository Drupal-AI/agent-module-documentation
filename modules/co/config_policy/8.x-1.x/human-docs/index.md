# Config Policy — manual setup guide

**Config Policy** (`config_policy`) lets you define **policies** that your configuration must
follow, so a team can keep configuration consistent and enforce best practices across a large
site. You create a policy, add **rules** to it that describe how configuration should look
(naming conventions, required values, disallowed settings), and Config Policy can then
**validate** configuration against those rules — and, where a rule supports it, **fix**
configuration automatically or even alter admin forms to stop non‑conforming configuration
being saved in the first place.

The problem it solves is drift of a different kind: not "production differs from code", but
"our configuration no longer follows our own conventions". On a big site with many
contributors, that inconsistency accumulates quietly. Config Policy turns your conventions
into checkable rules. It ships with a set of basic rules to get started, and because rules
are just plugins, developers can add more of their own.

Config Policy is managed entirely from the Drupal UI — you create and configure policies and
rules there, with no need to hand‑edit configuration files — and it also provides a **Drush
command** so you can validate (and optionally fix) configuration as part of CI. It depends on
core's **Field** module and works on Drupal `^10 || ^11`. Note the release is an **alpha
(8.x‑1.4‑alpha4)** and the project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

Config Policy is administered through its own management UI (creating policies, adding rules,
running validate/fix). Because the policies and rules you create *are* the configuration, and
there is no single global settings form, this guide keeps the workflow here rather than in a
separate configuration page.

## How to use it

1. **Create a policy** in the Config Policy management UI. A policy is a named container for
   the rules you want to enforce.
2. **Add rules** to the policy. Each rule describes an expectation about configuration
   (for example a naming convention, a required value, or a disallowed setting). Start from
   the basic rules the module ships and add more as needed; developers can supply custom rule
   plugins.
3. **Validate and fix** from the UI — Config Policy reports configuration that violates the
   policy, and rules that support fixing can correct it. Some rules also alter admin forms to
   prevent non‑conforming configuration from being saved.
4. **Run it in CI** with the Drush command:

   ```bash
   drush config-policy:validate      # or the short alias: drush cpv
   ```

   Add `--fix` to also fix configuration that does not match the policy, and `-y` to skip the
   confirmation prompt (useful in an automated pipeline):

   ```bash
   drush cpv --fix -y
   ```

Access to administering policies is governed by the core **Administer site configuration**
permission, so it is available to the people who already administer site configuration.

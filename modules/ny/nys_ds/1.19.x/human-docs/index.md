# NYS Design System Libraries — manual setup guide

**NYS Design System Libraries** (`nys_ds`) packages the **New York State Design
System (NYSDS)** as Drupal libraries and components, so a traditional theme‑based
Drupal front end can use NYSDS styles, assets and components directly in Twig
templates. It exists to help New York State and government sites build consistent,
accessible interfaces that match the state design standard.

The problem it solves is integration: rather than manually pulling the NYSDS assets
into your theme and wiring up each component, this module ships the design system
**fully built at a specific version inside the module itself** and registers its
components through Drupal's component (single‑directory component) system. You then
reference those components from your templates with a Twig `include`.

An important note on versioning: the module is **versioned to match a specific
NYSDS release**. Install the version of this module that corresponds to the NYSDS
version you need, and avoid `^` or `~` constraints in Composer so upgrades stay
deliberate and reviewable. It is a theming/asset library with no content or
access role of its own, and it is **not** intended for decoupled front ends or
SPAs — for those, include the NYSDS library directly in your project. Requires
Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install a specific version with Composer
   and enable the module.

There is **no configuration page** — the module registers components for use in
Twig and requires no active configuration. Usage is described in "How to use it"
below.

## Where it lives in the admin menu

NYS Design System Libraries adds no admin settings page. Everything happens in your
theme's Twig templates, where you `include` the registered NYSDS components.

## How to use it

1. Enable the module and add it as a **dependency of any theme or module** that
   uses NYSDS components. Drupal registers the components regardless, but declaring
   the dependency keeps the relationship clear.
2. In a Twig template, include a component and pass it the properties it expects.
   For example, the alert component:

   ```twig
   {% set alertLabel = fields.field_alert_label.content %}
   {% include 'nys_ds:alert' with {
     type: alertType,
     icon: alertIcon,
     heading: alertLabel,
     text: fields.field_alert_message.content,
     primaryLabel: alertTypeLabel
   } %}
   ```

3. When a property needs rendered HTML, pass it a render array or a Twig block
   rather than a raw string:

   ```twig
   {% set customContentBlock %}
     My variable: {{ myVariable }}
   {% endset %}
   ```

For much more detailed guidance, including webform components and the bundled
DDEV example site, see the module's expanded documentation linked from its
[project page](https://www.drupal.org/project/nys_ds).

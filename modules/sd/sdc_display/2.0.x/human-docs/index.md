# SDC Display — manual setup guide

**SDC Display** (`sdc_display`) lets you render Drupal fields, field groups, and
whole view modes through **Single Directory Components** (SDC) — the component
system built into modern Drupal, where a component bundles its own Twig template,
CSS, JavaScript, and a schema of `props` and `slots` in one directory. Instead of
writing custom field templates or formatter plugins, you point a field or a view
mode at a component and map the field values onto that component's props and
slots, all from the display configuration UI.

It hooks into the display layer at three levels. **Per field:** a field
formatter gains an "SDC Display" section where you choose a component and feed
the field value into one of its props or slots. **Per view mode:** you can render
an entire view mode as a single component, so an Article's default display could
be built entirely from a `card` component. **Per field group:** it adds a
"Single Directory Component" field‑group formatter (on rendered displays) so a
group of fields renders through one component such as a hero. In every case you
can combine fixed "static" values (a title, a variant name) with one dynamic
field value to fully populate the component.

Which components show up in each picker is controlled by two component tags, so
your team can expose only the design‑approved components for field formatters and
for view modes rather than the entire library. This makes it a clean bridge
between Drupal's content model and a design‑system or Storybook‑based component
library, and everything is stored in exportable display configuration for
deployment.

SDC Display is primarily a tool for developers and site builders working with a
component library; there is no site‑wide settings page. It requires the
`cl_editorial` and `sdc_tags` modules, uses the `e0ipso/schema-forms` library to
build its schema‑driven forms, and needs **PHP 8.1 or newer**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the render
mechanism, config keys, and component tags — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.

## Where it lives in the admin menu

SDC Display has no menu entry of its own. You use it inside the **Manage
display** screens of your entities — for example **Structure → Content types →
Article → Manage display** (`/admin/structure/types/manage/article/display`) —
where its controls appear on field formatters, on the view‑mode form, and on
field groups.

## How to use it

On a **Manage display** screen, open the settings of the field, group, or view
mode you want to render through a component, enable the **SDC Display** option,
choose a component, and map the field value onto one of the component's props or
slots (adding any static values you need). Save the display and the entity now
renders through your component. Because component pickers are filtered by the
`sdc_display:field_formatter` and `sdc_display:view_mode` tags, only the
components your team has tagged for that purpose appear as options.

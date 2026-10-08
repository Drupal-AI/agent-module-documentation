# Progress Circle OR Bar — manual setup guide

**Progress Circle OR Bar** (`progresscirclebar`) gives you a simple field for
displaying a percentage or progress value as either a **circular progress ring**
or a **horizontal progress bar**. It's handy for skill meters, completion
indicators, poll-style counters, and other "80% complete" style statistics.

You add the field to a content type like any other field, enter a value on your
content, and then choose — on the field's display settings — whether it renders
as a circle or a bar. The module uses lightweight plain JavaScript, so it stays
fast and adds no heavy front-end dependencies. It is purely a content-display
feature: it has no access-control role, and the values it shows come from your
content.

A small global settings page lets you pick the background colours used for the
circle and the bar. Everything else — which display style a given field uses — is
decided per field on **Manage display**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The colour settings and per-field setup are small enough to cover here rather than
on a separate page — see "How to use it" below.

## Where it lives in the admin menu

The global colour settings sit at **Configuration → System → Progress Settings**
(`/admin/config/system/progressoptions`). The actual progress fields are added and
formatted on your content types under **Structure → Content types**.

## How to use it

1. **Add the field.** Go to **Structure → Content types → *(your type)* → Manage
   fields → Add field**, and choose the **Progress Circle/Bar** field type. Give
   it a label and save.
2. **Enter values.** When you create or edit content of that type, enter the
   percentage/progress value in the new field.
3. **Choose circle or bar.** Go to the same content type's **Manage display**,
   find your field, and set its format to **Bar** or **Circle** depending on how
   you want it to appear.
4. **Set the colours (optional).** Visit **Configuration → System → Progress
   Settings** (`/admin/config/system/progressoptions`) to set the background
   colours used for the circle and the bar, then save. If you never open this
   page, the field still renders with its defaults.

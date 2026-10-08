# Link No Protocol — manual setup guide

**Link No Protocol** (`link_no_protocol`) provides a friendlier widget for core **Link**
fields: it lets content editors type a URL *without* the `http://` or `https://` prefix.
Instead of demanding `https://example.com`, editors can just type `example.com`, the way
they would in a browser address bar or a search box.

Under the hood the widget is a small extension of the standard core Link widget. It swaps
the field's input from a strict HTML5 URL box (which browsers reject when there is no
protocol) to a plain text box, then fills in the scheme for you: when the value you type
doesn't already start with `http`/`https`, it tentatively tries `https://www.` in front and,
if that host actually resolves, uses it. If the guessed host doesn't resolve, your input is
left untouched and passed through to core's normal handling. Either way the field still
stores a complete, fully-qualified URL — this only changes *data entry*, not what is saved.

There is one per-field option: strip the protocol out of the field's configured default
value so editors see a clean, protocol-less default too. Because everything is a widget,
you turn it on per field on the *Manage form display* screen — there is no global settings
page, no permissions, and no Drush commands. It depends only on core's Link module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no configuration page — you select the widget on the form display for whichever
Link field should use it:

1. Go to the bundle you want to edit — for example **Structure → Content types →
   (your type) → Manage form display**.
2. Find your **Link** field in the list.
3. In its **Widget** column, choose **Link No Protocol** from the drop-down.
4. Click the widget's gear/settings icon to reveal its one setting:
   - **Remove the protocol from the default value** *(on by default)* — when enabled, any
     `http://`/`https://` prefix is stripped from the field's configured default value so
     the editor is shown a protocol-less default. Turn it off to leave the default value
     exactly as configured.
5. Click **Update**, then **Save**.

From then on, editors filling in that field can type just a domain (like `example.com`) and
the widget infers `https://www.` when the host resolves. The setting summary on the form
display reminds you that protocol-less entry is allowed. The widget works on required and
optional fields, on multi-value Link fields, and alongside the Link title options inherited
from the core widget. Because the stored value format is unchanged, you can switch an
existing Link field to this widget without touching any data already saved.

One thing worth knowing: because the widget tries to confirm the host resolves, it performs
a DNS lookup on the entered host when the form is submitted.

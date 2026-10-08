# Clipboard.js — manual setup guide

**Clipboard.js** (`clipboardjs`) adds one‑click "copy to clipboard" buttons to
your content. It wires the popular [clipboard.js](https://clipboardjs.com/)
JavaScript library into Drupal as a set of **field formatters** and **theme
hooks**, so any text value — a phone number, SKU, coupon code, API key, email
address, link, or code snippet — can be copied by a visitor with a single click,
no text‑selecting required.

You use it in one of two ways. Site builders pick a Clipboard.js **formatter** on
an entity's *Manage display* page (or in a View's field settings) — no code
needed. Developers can drop a copy control into any render array or form using the
module's **theme hooks**. Either way a small confirmation (a tooltip or alert like
"Copied!") appears after copying, and every control's label and confirmation text
is configurable.

Two things to note. First, Clipboard.js has **no settings page, no permissions,
and no Drush commands** — its only configuration is the per‑field formatter
settings you set on *Manage display*. Second, the actual clipboard.js JavaScript
library is an **external dependency you must download** (v2.0.11) into your site's
`libraries/clipboard/dist/` directory; if it is missing, Drupal's status report
flags it. See [Installation](installation/index.md) for how to add it. The module
has no other module dependencies and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and download the required clipboard.js library.

## Where it lives in the admin menu

Clipboard.js adds no admin page of its own. You configure it on the **Manage
display** tab of any content type, media type, taxonomy vocabulary, etc. — for
example **Structure → Content types → Article → Manage display**. Its library
status is reported on **Reports → Status report** (`/admin/reports/status`).

## How to use it

### As a field formatter (no code)

1. Go to the **Manage display** page of the entity whose field you want to make
   copyable.
2. For a supported field, choose one of the four formatters in the **Format**
   column:
   - **Clipboard.js Button** — a copy button next to the value.
   - **Clipboard.js Snippet** — the value shown as a snippet with a copy control
     (good for code).
   - **Clipboard.js Textfield** — a read‑only single‑line field with a copy button.
   - **Clipboard.js Textarea** — a read‑only multi‑line box with a copy button.
3. Click the formatter's gear icon to adjust its three settings:
   - **Label** — the button/hover text (default *Click to copy*).
   - **Alert style** — how copying is confirmed: **tooltip** (default), **alert**
     (a JavaScript alert), or **none**.
   - **Alert text** — the confirmation message (default *Copied!*).
4. Save.

Supported field types are: string, email, link, integer, decimal, float, slug,
and slug_path. For a link field the copied value is the URL; for the others it is
the raw value.

### In custom code (theme hooks)

Developers can render a copy control anywhere using one of four render elements —
`clipboardjs_button`, `clipboardjs_snippet`, `clipboardjs_textfield`,
`clipboardjs_textarea`. For example:

```php
$build['copy'] = [
  '#theme' => 'clipboardjs_button',
  '#value' => 'Any copyable value.',
  '#label' => t('Copy code'),
  '#alert_style' => 'tooltip',   // tooltip | alert | none
  '#alert_text' => t('Copied!'),
];
```

Each element gets a unique auto‑generated id. See the
[`agent/`](../agent/start.md) docs for the full variable list.

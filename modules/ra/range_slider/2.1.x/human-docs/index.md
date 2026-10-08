# Range Slider — manual setup guide

**Range Slider** (`range_slider`) lets people set a number by dragging a slider
instead of typing into a plain number box. It wraps the popular
[rangeslider.js](https://rangeslider.js.org) library around Drupal's built-in
HTML5 range input, giving you a friendlier, touch-friendly control that still
falls back to a native range slider if JavaScript is unavailable.

The module gives you three ways to use that slider: a **field widget** for core
numeric fields (integer, decimal, and float), a **Webform element** so you can
drop a slider into any Webform, and a **`range_slider` render element** you can
use directly in custom forms or render arrays. In every case you can show the
live value as the user drags — above, below, left, or right of the slider — and
decorate it with a prefix or suffix such as `$` … `USD`, `kg`, or `%`. Sliders
can be horizontal or vertical, and they respect a field's configured min, max,
and step.

There is **no admin settings page, no permissions, and no Drush commands** —
everything is configured per field widget or per element where you use it. That
is why this guide has no separate configuration page; the how-to below covers it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Range Slider adds no admin pages of its own. You use it from a content type's
**Manage form display** screen (for the field widget) or from the Webform
build screen (for the Webform element).

## How to use it

### Put a slider on a numeric field

1. Add or pick an **integer**, **decimal**, or **float** field on your content
   type (or other entity).
2. Go to **Structure → Content types → (your type) → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
3. On that field's row, choose the **Range Slider** widget.
4. Click the widget's cog icon and set:
   - **Orientation** — **Horizontal** (default) or **Vertical**. Vertical sliders
     are handy in narrow spaces like a sidebar filter.
   - **Output** — where the live value is shown: **No output**, **Below**,
     **Above**, **Left**, or **Right** of the slider.
5. Click **Update**, then **Save**.

The slider automatically honors the field's configured minimum, maximum, and
step, so users cannot drag out of range.

### Add a slider to a Webform

When building a Webform, add the **Range Slider** element (listed under
*Advanced elements*). It offers the same slider with no extra setup beyond
selecting it.

### Use the element in custom code

Developers can use the `range_slider` form element directly in a render array.
It accepts the usual range properties (`#min`, `#max`, `#step`, `#default_value`)
plus `#data-orientation` (`horizontal`/`vertical`), `#output`
(`below`/`above`/`left`/`right`, or `FALSE` for none), and
`#output__field_prefix` / `#output__field_suffix` for decorating the printed
value — see the [`agent/`](../agent/api/element.md) docs for the full example.

### A note on the JavaScript library

The slider loads rangeslider.js 2.3.2 from a CDN (`cdn.jsdelivr.net`) at runtime.
No Composer or npm install is required, but the CDN must be reachable in the
browser — or you can override the Drupal library to serve the files locally.

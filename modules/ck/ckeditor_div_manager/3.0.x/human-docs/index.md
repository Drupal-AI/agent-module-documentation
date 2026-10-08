# CKEditor Div Manager — manual setup guide

**CKEditor Div Manager** (`ckeditor_div_manager`) adds a **Div Manager** button to the
CKEditor 5 toolbar. Clicking it lets an editor wrap content in a `<div>` container and,
through a small pop-up form, set that div's **class**, **id**, **title**, **lang**, and
inline **style** — all without switching to source view or hand-writing HTML.

This is useful whenever a theme needs wrapper markup: grouping several blocks inside
one container, applying a layout or grid class like `simple-grid`, adding a callout or
branded box, giving a region an `id` for in-page anchors or JavaScript, or marking a
passage with a `lang` attribute. Editors get one consistent tool instead of everyone
inventing their own markup.

The module is a pure CKEditor 5 plugin — it adds no PHP settings, no permissions, and
no admin page. You switch it on **per text format** by dragging its button into that
format's toolbar, so you can allow container divs on the formats that need them (say,
Full HTML) while keeping others locked down.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the button on each text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), which is also where CKEditor toolbars are managed.

## How to use it

### Turn the button on for a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and click
   **Configure** next to a format that uses the **CKEditor 5** editor (for example
   *Full HTML*).
2. In the toolbar configuration, drag the **Div Manager** button from *Available
   buttons* into the *Active toolbar*.
3. If the format has **Limit allowed HTML tags and correct faulty HTML** turned on,
   make sure the allowed-tags list permits the container tag, or the markup will be
   stripped on save:
   - At minimum, allow `<div>`.
   - To keep the pop-up's class/id/title values, allow `<div class id title>`.
4. Save the format.

### Insert a container while editing

When editing content with that format, place your cursor where you want the container,
click **Div Manager**, and fill in the pop-up form — content text, plus any of title,
id, class, langcode, and raw styles. Submitting inserts the `<div>` with those
attributes around your content. Existing `<div class="simple-grid">` markup re-opens as
an editable container, so editors can adjust it later.

## Note on the CKEditor library dependency

The module lists a Composer dependency on the older CKEditor 4 `div` library group
(`drupal-ckeditor-libraries-group/div`). Composer installs it automatically, but the
3.0.x release is a self-contained CKEditor 5 build and does not actually use that older
library at runtime.

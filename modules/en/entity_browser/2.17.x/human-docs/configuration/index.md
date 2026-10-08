# Configuration

Configuring Entity Browser means **building one or more browsers** and then
**attaching them to fields**. A browser is a configuration entity assembled from
four pluggable parts, so the edit form is a short two-step wizard.

## Open the browsers list

1. Log in as a user with the **Administer entity browsers** permission.
2. Go to **Configuration → Content authoring → Entity browsers**
   (`/admin/config/content/entity_browser`).
3. Click **Add Entity browser**.

## Step 1 — General settings

On the first wizard screen you choose the browser's overall behavior:

- **Display plugin** — how the browser opens:
  - **Modal** — a dialog over the current page (the most common choice).
  - **iFrame** — the browser embedded in an iframe on the page.
  - **Standalone** — its own page at a dedicated route.
  The display has its own options (for a modal: width, height, link text, and
  whether it auto-opens). Standalone displays can also render in the admin theme
  via a **Use admin theme** option.
- **Widget selector** — how editors switch between widgets:
  - **Tabs**, **Dropdown**, or **Single widget** (when there's only one).
- **Selection display** — how chosen items appear before you submit:
  - **Multi-step display** (browse, add to a running selection, reorder, submit),
    **View**, or **No display**.

## Step 2 — Widgets

On the second screen you add the **widgets** — the actual sources editors pick
from — and order them by weight. The bundled widgets include:

- **View** — lists selectable entities using a View that has an **Entity Browser**
  display. This is the usual way to present a grid or table of existing media.
- **Upload** — a plain file upload.
- **Media image upload** — upload that creates media image entities.
- **Entity form** — create a new entity inline (requires the Entity Browser IEF
  submodule and Inline Entity Form).

For the **View** widget you must first create a View with an *Entity Browser*
display; Entity Browser provides the Views display, field, filter, and
argument-default plugins to support it.

Save the browser when both steps are complete.

## Attach the browser to a field

A browser does nothing until a field uses it:

1. Go to the content type (or other entity) that has an entity-reference or file
   field, and open **Manage form display**.
2. Set that field's widget to **Entity browser** (the
   `entity_browser_entity_reference` or `entity_browser_file` widget).
3. In the widget settings, choose the browser you built and how selected entities
   are shown (rendered teaser, thumbnail, or label).

## Deploying browsers

Browsers are fully exportable configuration (`entity_browser.browser.*`), so you
can move them between environments with Drupal's configuration sync like any other
config. Standalone browsers register a route plus an auto-generated per-browser
access permission — grant that permission to the roles that should be able to open
the browser's page.

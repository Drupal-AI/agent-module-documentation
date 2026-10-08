# Configuration

Setting up Form layout is a two‑stage process: first you tell the module which
entity types are eligible, then you define the actual tabs/accordions on each
bundle's form display.

## Step 1 — Choose which entity types are eligible

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Form layout**
   (`form_layout.admin_settings`).
3. Select the entity types that should have layout functionality — for example
   **Node**, **Media**, **Paragraph**. Only the types you tick here will show a
   *Manage form layout* tab.
4. Save.

## Step 2 — Define the layout for a bundle

1. Go to the bundle you want to organise — for example **Structure → Content
   types → Article → Manage form layout**. (The *Manage form layout* tab sits
   alongside *Manage form display*.)
2. Tick **Enable Form layout for this display** to turn the feature on for this
   particular form display.
3. **Define your regions** in the table. Each region needs:
   - a **Label** — the text an editor sees on the tab or accordion heading, and
   - a **Machine key** — a stable internal identifier for the region.
4. Optionally mark one group as **Open by default**, so it is the region shown
   first when the form loads.
5. Choose the **layout type**:
   - **Vertical tabs** — ideal for complex entities with a lot of metadata.
   - **Horizontal tabs** — good for a few clearly separated content areas.
   - **Details / accordions** — standard collapsible sections built from core
     form elements.
6. **Assign fields** by dragging each field in the table into the region where
   it belongs.
7. **Save.** Your edit form is now grouped into the regions you defined.

## Per form mode

Because the configuration is stored on the form display entity, you can give
each **form mode** its own layout. Enable a form mode for the bundle (in *Manage
form display*), then open the *Manage form layout* tab for that mode and define a
layout independently — for instance a simplified grouping for a Register mode and
the full layout for the default administrative form.

## Good to know

- **Empty groups disappear automatically.** If every field in a tab or accordion
  is hidden or inaccessible to the current user, Form layout hides that group so
  the form stays clean.
- **No data or access changes.** Grouping is purely presentational — all fields
  remain present, and field access is unaffected.
- **Paragraphs.** Nested layouts work inside Paragraphs widgets, so
  component‑based content stays manageable.

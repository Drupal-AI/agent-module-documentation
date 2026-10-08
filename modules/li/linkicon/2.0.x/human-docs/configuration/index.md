# Configuration

Link Icon has two parts: a **per-field** setup (the main event) and a small
**global settings form** for loading an icon font. The per-field setup is a
two-step flow on a core Link field.

## Step 1 — Enable predefined titles on the link field

1. Go to the content type's **Manage fields** page and edit your **Link** field
   (`/admin/structure/types/manage/<bundle>/fields/...`).
2. In the field settings, find the **"Allow link text"** option. Link Icon adds a
   new choice there: **Predefined** (alongside the core Disabled / Optional /
   Required choices). Select it.
3. A **predefined titles** box appears. Enter one allowed title per line in the
   form `key|value` (an optional third part is a tooltip):

   ```
   facebook|Visit my Facebook page
   x-twitter|X
   google-plus|Google+|[node:title]
   ```

   The **key** (`facebook`) becomes the icon-class suffix, the **value** is the
   label editors see, and the optional third part is a tooltip (which can use
   tokens).
4. Save the field.

With *Predefined* on, the link widget's Title box becomes a **select list** of
your allowed titles, so editors pick an approved title (which fixes the icon)
instead of typing free text.

## Step 2 — Choose the Link icon formatter

1. Go to the same bundle's **Manage display** page.
2. Set your link field's **Format** to **"Link icon, based on title"**.
3. Click the gear icon to open its options. Because it extends the core Link
   formatter, all the core options (trim length, URL-only, `rel`, target) are
   there, plus Link Icon's own settings. The most useful ones:

   | Setting | What it does |
   |---|---|
   | **Icon prefix** (`icon`) | The class prefix; the final icon class is `<prefix>-<key>`, e.g. `icon-facebook`. Set it to match your icon font (e.g. `fa`, `bi`). |
   | **Icon / wrapper / label classes** | Extra CSS classes for theming, without a template override. |
   | **Load module CSS** | Emit the module's starter CSS assets. |
   | **Vertical layout** | Stack the icon above the text. |
   | **Style / color presets** | Built-in square/rounded/color presets. |
   | **Tooltip** | Render the title as a pure-CSS tooltip. |
   | **Hide text (icon only)** | Visually hide the title, showing only the icon (still readable by screen readers). |
   | **Max length** (60) | Trim the title/tooltip length. |
   | **Icon position** | Where the icon sits relative to the text. |
   | **`rel="nofollow"` / open in new window** | Inherited link behaviors for outbound links. |
   | **Global title** | A tokenized title (e.g. `[node:title]`) that overrides each link's text. |
   | **Icon size / bundle** | Icon font size, and integration with icon modules (e.g. FontAwesome). |

4. Click **Update**, then **Save** the display.

## Global settings — the icon-font CSS path

The module's own settings form has exactly one option.

1. Go to **Configuration → User interface → Link Icon**
   (`/admin/config/user-interface/linkicon`). It requires the **Administer
   linkicon** permission (`administer linkicon`), which you grant at **People →
   Permissions**.
2. In **Icon font CSS file path**, enter a path to a CSS file — or a
   comma-separated list of several — for example:

   ```
   /libraries/fontello/css/fontello.css
   ```

3. **Leave it empty** if your theme already loads the icon font, or if you use the
   FontAwesome (5+) module with its SVG+JS approach.
4. Save. The module clears its library cache so the new stylesheet is picked up.

This path only loads a stylesheet; the actual icon classes still come from the
prefix plus each predefined key you set in Step 1.

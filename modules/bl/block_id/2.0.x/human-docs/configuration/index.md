# Configuration

Block ID has no central settings page. You set everything **per block**, on that
block's **Configure** form.

## Where to find the fields

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Configure** on the block you want to change.
3. Provided you have the **"administer block id"** permission, the form now
   includes the four fields below. (Without the permission, the fields are hidden
   entirely.)

## The four fields

| Field | What it does |
|-------|--------------|
| **Block ID** | Sets the HTML `id` attribute on the block's wrapper element, replacing the one Drupal would otherwise generate. Use it for a stable CSS/JS hook or an in-page anchor (`#your-id`). |
| **Title CSS class(es)** | Adds one or more classes to the block's **title** element. |
| **Content CSS class(es)** | Adds one or more classes to the block's **content** wrapper. |
| **Block CSS class(es)** | Adds one or more classes to the overall **block wrapper**. |

Each of the three class fields accepts **multiple classes separated by spaces**,
up to 255 characters. Leave any field blank if you don't need it.

## Rules and behaviour

- **Blanks are discarded.** When you save, any of the four fields left empty are
  removed from the block's stored configuration, so the block config stays tidy
  and no empty attributes are emitted.
- **Block IDs must be unique.** If you type an ID that another block already uses,
  the form blocks the save with an error ("… is already used by another block").
  Plan a distinct ID per block instance. An empty ID skips this check.
- **How the values are applied:** at render time the **Block ID** replaces the
  wrapper's `id`, and each class string is split on spaces and added to the
  matching element's classes. The class values are cleaned into valid CSS
  identifiers; the ID is emitted as-is and relies on Drupal's normal attribute
  escaping.
- **It's exportable config.** These values are stored on the block configuration
  entity, so they travel with `drush cex`/`cim` like any other block setting and
  stay consistent across environments.

## Save

Click **Save block**. The custom ID and classes appear in the block's markup on
the next page render — reload a page where the block is placed and inspect it to
confirm.

# Configuration

Setting up Like is a two‑step process: first tell the module **which entity types**
may be liked, then **place and label** the Like element on the displays where you
want it to appear.

## Step 1 — Enable the entity types

1. Log in as a user who can administer the module.
2. Go to **Configuration → User interface → Like**, or navigate directly to
   `/admin/config/user-interface/like`.
3. Tick the **content entity types** you want to enable liking for — for example
   **Content** (nodes), comments, or any other content entity type your site has.
4. Save the form.

Enabling a type here makes a computed "like count" available on that entity and
makes the Like element placeable on its displays.

## Step 2 — Place the Like element on a display

For each bundle where you want the button to appear:

1. Go to **Structure → Content types → *(your type)* → Manage display**
   (or the Manage display of the relevant bundle).
2. Position the **Like** field/element where you want it in the display, just like
   any other field.
3. Open its settings to configure the **labels/literals** shown for the Like
   action (the wording of the button and count). These can be adjusted — and, with
   the appropriate translation setup, translated — per display.
4. Save the display.

## Who can like, and who can see likers

Because a like is a small piece of personal data about an opinion, decide
deliberately:

- Whether **anonymous** users may like content, or only authenticated users.
  Anonymous counts are easier to inflate; if you allow them, consider installing
  **Antibot** (Like integrates with it automatically).
- Who may see an **aggregate count** versus a **list of who liked** — treat those
  as two different disclosures.

## A note on caching

The Like count changes far more often than the page around it, so the module loads
the count through a small GET endpoint rather than baking it into a fully cached
page. This keeps the displayed number reasonably accurate without disabling page
caching for everyone. No configuration is required for this; it is mentioned so the
behavior is expected.

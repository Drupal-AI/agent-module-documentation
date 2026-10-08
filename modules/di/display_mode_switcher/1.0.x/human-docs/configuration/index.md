# Configuration

Setting up Display Mode Switcher is two steps: make sure the view mode you want to
switch *to* exists and shows the right fields, then create a rule that performs the
switch under your chosen conditions.

## Step 1 — create the target view mode

The module switches between view modes, so the one you want to switch *to* must
already exist and be configured:

1. Go to **Structure → Display modes → View modes**
   (`/admin/structure/display-modes/view`) and add a new view mode for your entity
   type — for example `paywall`.
2. Go to that entity type's **Manage display** page, enable the new view mode under
   **Custom display settings**, and configure which fields it shows (for a paywall,
   perhaps just a teaser and a "subscribe" message).

## Step 2 — add a switcher rule

1. Log in as a user with the **administer display mode switcher** permission.
2. Go to **Structure → Display modes → View modes → Switcher rules**
   (`/admin/structure/display-modes/view/switcher`) and click **Add rule**.
3. Fill in the rule:
   - **Entity type** (and optionally **bundle**) — what this rule applies to.
   - **Source display mode** — the view mode that triggers evaluation (e.g. `full`).
     When an entity is about to render in this mode, the rule is considered.
   - **Target display mode** — the view mode to switch to when the rule matches
     (e.g. `paywall`).
   - **Conditions** — one or more conditions that must be true for the switch to
     happen. Use the built‑in **User has role** condition, any core condition (node
     type, language, request path, current theme), or conditions from other
     contrib modules. A rule with **no conditions always matches** — useful as a
     catch‑all fallback set at a high weight.
4. Save the rule.

## How rules are evaluated

- Rules are evaluated in **weight order**; the **first matching rule wins**. This
  makes it easy to build hierarchies — for example an "admin" rule, then a
  "subscriber" rule, then an "anonymous" catch‑all.
- If no rule matches, the entity renders in its original (source) view mode,
  unchanged.
- **Caching is respected automatically** — cache tags, contexts, and max‑age from
  every evaluated condition are merged into the rendered output, so switched
  displays cache correctly.

## Step 3 — test both sides

Render an entity in the source view mode **as a user who meets the conditions** and
confirm the target display appears; then view it **as a user who does not** and
confirm the original display is shown. Because rules are configuration entities, you
can export them (`drush config:export`) and deploy them across environments.
